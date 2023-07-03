/** 
 * Urban Dictionary module
 */
module botty.modules.urbandict;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

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
        string[] splits = split(strip(messageBody), " ");
        writeln("splits", splits);

        if(splits.length >= 2)
        {
            string searchTerm = splits[1];
            getBot().channelMessage("hehe", channel);
        }
        else
        {
            // Do nothing
        }
    }
}