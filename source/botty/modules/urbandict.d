/** 
 * Urban Dictionary module
 */
module botty.modules.urbandict;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;
import std.net.curl : CurlException;
import std.json : JSONValue, JSONException, parseJSON;
import birchwood;

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
        import std.conv : to, ConvException;

        /**
         * Split the ` .ub   dictionarydef`
         * into two parts `[.ub, dictionarydef]`
         */
        messageBody = strip(messageBody);
        string[] splits = split(messageBody, " ");
        writeln("splits", splits);

        

        try
        {
            
            
            if(splits.length >= 2)
            {

                /** 
                 * Checks for `.ub:2`
                 */
                ulong count = 0;
                long countIdx = splits[0].indexOf(":");
                if(countIdx > -1)
                {
                    string countStr = splits[0].split(":")[1];
                    try
                    {
                        count = to!(ulong)(countStr);
                    }
                    catch(ConvException e)
                    {
                        getBot().channelMessage("Invalid index '"~countStr~"'", channel);
                    }
                }


                writeln("Are we ongod yet? ",messageBody.indexOf(" "));
                string searchTerm = strip(messageBody[messageBody.indexOf(" ")..$]);
                writeln("search term: '"~searchTerm~"'");

                try
                {
                    // Perform lookup and parsing
                    JSONValue[] definitions = doThing(searchTerm);
                    writeln("Definitions count: ", definitions.length);
                    writeln("Selecting definition: ", count);

                    if(definitions.length > 0)
                    {
                        // TODO: Send result below
                        // getBot().channelMessage(translatedText, channel);

                        JSONValue firstDef = definitions[count];

                        string definition = firstDef["definition"].str();
                        string example = firstDef["example"].str();
                        string author = firstDef["author"].str();
                        string permalink = firstDef["permalink"].str();

                        import birchwood.protocol.formatting;

                        writeln("Def '"~definition~"'");
                        writeln("Ex '"~example~"'");
                        writeln("Au '"~definition~"'");
                        writeln("Perm '"~permalink~"'");


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
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
                writeln("IMM   A  W ");
            }
        }
        catch(BirchwoodException e)
        {
            writeln("Birchwood error: ", e);
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
        

        string data = cast(string)get(ubBase~term);
        writeln("UB result: ", data);
        JSONValue[] json = parseJSON(data)["list"].array();

        return json;
    }
}