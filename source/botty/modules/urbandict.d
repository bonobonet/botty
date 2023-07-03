/** 
 * Urban Dictionary module
 */
module botty.modules.urbandict;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;
import std.net.curl : CurlException;

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

            getBot().channelMessage("hehe", searchTerm);
        }
        else
        {
            // Do nothing
        }
    }

    private static void doThing(string term)
    {
        import std.string : fromStringz;
        import etc.c.curl : curl_escape;
        term = cast(string)fromStringz(curl_escape(cast(const(char)*)term.ptr, cast(int)term.length));

        // Do the request
        import std.net.curl;
        string data = cast(string)get(ubBase~term);
        
        import std.stdio;
        writeln("UB result: ", data);
    }
}