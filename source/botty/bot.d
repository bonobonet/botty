module botty.bot;

import birchwood;

public class Bot : Client
{
    this(ConnectionInfo info)
    {
        super(info);
    }

    public override void onChannelMessage(Message fullMessage, string channel, string msgBody)
    {
        // TODO: Implement me
    }
}