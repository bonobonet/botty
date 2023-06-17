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
        import std.string : indexOf, strip;

        long idx = indexOf(messageBody, commandStr);
        string toBeSecretified = messageBody[idx+commandStr.length..$];

        getBot().channelMessage(
            toBeSecretified.map!((ch) {
                    if (ch >= 'a' && ch <= 'z')
                        ch = (ch - 'a' + 13) % 26 + 'a';
                    if (ch >= 'A' && ch <= 'Z')
                        ch = (ch - 'A' + 13) % 26 + 'A';
                    return ch.to!char;
            }), channel
        );
    }
}
