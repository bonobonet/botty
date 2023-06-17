module botty.modules.rot13;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

public final class Rot13 : Mod
{
    private static string commandStr = ".rot13";

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

        // TODO: Implement me @rany2
    }
}