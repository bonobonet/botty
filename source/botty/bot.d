module botty.bot;

import birchwood;
import lumars;

public class Bot : Client
{
    this(ConnectionInfo info)
    {
        super(info);
    }

    /** 
     * Starts the bot by initializing the modules
     * and connecting it to the remote server
     */
    public void start()
    {
        // Authenticate
    	connect();
    }

    public override void onChannelMessage(Message fullMessage, string channel, string msgBody)
    {
        // TODO: Implement me
    }
}