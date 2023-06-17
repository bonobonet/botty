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
        // TODO: Implement me
    }
}