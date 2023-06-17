/**
 * Ping module for botty
 */
module botty.modules.ping;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

public class Ping : Mod
{
    private static string commandStr = ".ping";

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
        import std.string : split, strip;
        string[] splits = split(strip(messageBody), " ");

        if(splits.length == 2)
        {
            // Resolve the domain (TODO: Add this)
            string domain = splits[1];

            import std.stdio : writeln;
            writeln("ping: domain is: '"~domain~"'");

            // TODO: Implement me
        }
        else
        {
            // TODO: This is an error - too many commands
            getBot().channelMessage("A domain or address is required for the ping (no more than that and no less)", channel);
        }
    }
}