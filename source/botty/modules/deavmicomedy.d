module botty.modules.deavmicomedy;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

public class DeavmiComedy : Mod
{
    this(Bot bot)
    {
        super(bot);
    }

    public override bool accepts(Message fullMessage, string channel, string messageBody)
    {
        import std.string;

        import std.stdio;
        writeln("Yesh");
        
        if(messageBody.startsWith(".deavmicomedy"))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public override void react(Message fullMessage, string channel, string messageBody)
    {
        getBot().channelMessage("comedy", channel);
    }
}