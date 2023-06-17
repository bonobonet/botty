module botty.bot;

import birchwood;
import lumars;
import std.conv : to;
import core.thread : Thread, dur;

public class Bot : Client
{
    private string[] channels;

    this(ConnectionInfo info, string[] channels)
    {
        super(info);
        this.channels = channels;
    }

    /** 
     * Starts the bot by initializing the modules
     * and connecting it to the remote server
     */
    public void start()
    {
        // Authenticate
    	connect();

        // Wait a little then try join (TODO: Should we not detect this in birchwood perhaps)
        Thread.sleep(dur!("seconds")(2));

        // Join channels requested
        joinChannel(channels);
    }

    public override void onChannelMessage(Message fullMessage, string channel, string msgBody)
    {
        // TODO: Implement me
        // fullMessage.getFrom
        // channelMessage("Yes I received '"~msgBody~"' BOI!", "#general");
        
        reactCommand(fullMessage, channel, msgBody);
    }

    public void reactCommand(Message fullMessage, string channel, string msgBody)
    {
        fullMessage.getFrom();


        import std.stdio;
        import std.string;
        writeln(msgBody);
        writeln(split(msgBody, " "));

        string[] stuff = split(msgBody, " ");

        string command = stuff[1];

        // TODO: Make nicer, let it also search the `getAreas()`
        if(command == "eskont")
        {
            import eskomcalendar;
            EskomCalendar calendar = new EskomCalendar();

            string area = "western-cape-worscester";

            string message = "Load shedding for area '"~area~"':";
            channelMessage(message, channel);

            Schedule[] schedules = calendar.getSchedules(area);
            foreach(Schedule schedule; schedules)
            {
                message = bold("From")~" "~italics(to!(string)(schedule.getStart()))~" "~bold("Till")~" "~italics(to!(string)(schedule.getFinish()));
                channelMessage(message, channel);

            }

            
        }
    }
}