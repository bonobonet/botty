module botty.bot;

import birchwood;
import lumars;
import std.conv : to;

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

        // Wait a little then try join (TODO: Should we not detect this in birchwood perhaps)
        // TODO: Join channels listed in configuration
        joinChannel("#general");

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
                message = bold("From")~" "~italics(to!(string)(schedule.getStart())~" "~bold("Till")~" "~italics(to!(string)(schedule.getFinish())));
                channelMessage(message, channel);

            }

            
        }
    }
}