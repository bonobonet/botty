/** 
 * Urban Dictionary module
 */
module botty.modules.urbandict;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;
import std.net.curl : CurlException;
import std.json : JSONValue, JSONException, parseJSON;

/** 
 * Urban dictionary command
 */
public final class UrbanDict : Mod
{
    private static string commandStr = ".ub";

    /** 
     * Base URL to use for constructing requests
     */
    private static string ubBase = "http://api.urbandictionary.com/v0/define?term=";

    /** 
     * Constructs a new `UrbanDict` module with the provided
     * bot to associate with
     *
     * Params:
     *   bot = the `Bot` to associate with
     */
    this(Bot bot)
    {
        super(bot);
    }

    public override bool accepts(Message fullMessage, string channel, string messageBody)
    {
        import std.string : startsWith;
        return messageBody.startsWith(commandStr);
    }

    public override void react(Message fullMessage, string channel, string messageBody)
    {
        import std.string : indexOf, strip;

        import std.stdio;
        import std.string : split;

        /**
         * Split the ` .ub   dictionarydef`
         * into two parts `[.ub, dictionarydef]`
         */
        messageBody = strip(messageBody);
        string[] splits = split(messageBody, " ");
        writeln("splits", splits);

        if(splits.length >= 2)
        {
            string searchTerm = strip(messageBody[messageBody.indexOf(" ")..$]);

            try
            {
                // Perform lookup and parsing
                JSONValue[] definitions = doThing(searchTerm);

                if(definitions.length >= 0)
                {
                    // TODO: Send result below
                    // getBot().channelMessage(translatedText, channel);

                    JSONValue firstDef = definitions[0];

                    string definition = firstDef["definition"].str();
                    string example = firstDef["example"].str();
                    string author = firstDef["author"].str();
                    string permalink = firstDef["permalink"].str();

                    import birchwood.protocol.formatting;

                    getBot().channelMessage(bold("Definition: ")~definition, channel);
                    getBot().channelMessage(bold("Example: ")~example, channel);
                    getBot().channelMessage(bold("Author: ")~author, channel);
                    getBot().channelMessage(bold("Permalink: ")~permalink, channel);
                }
                // If no definitions are found
                else
                {
                    getBot().channelMessage("No definitions for '"~searchTerm~"'", channel);
                }              
            }
            // On network error
            catch(CurlException e)
            {
                getBot().channelMessage("There was a network error when looking up on urban dictionary", channel);
            }
            // On parsing error
            catch(JSONException e)
            {
                getBot().channelMessage("There was a parsing error when looking up on urban dictionary", channel);
            }
        }
        else
        {
            // Do nothing
        }
    }

    private static JSONValue[] doThing(string term)
    {
        import std.string : fromStringz;
        import etc.c.curl : curl_escape;
        term = cast(string)fromStringz(curl_escape(cast(const(char)*)term.ptr, cast(int)term.length));

        // Do the request
        import std.net.curl;
        
        
        import std.stdio;
        // writeln("UB result: ", data);

        string data = cast(string)get(ubBase~term);
        JSONValue[] json = parseJSON(data)["list"].array();

        return json;
    }
}