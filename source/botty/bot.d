module botty.bot;

import birchwood;
import lumars;
import std.conv : to;
import core.thread : Thread, dur;
import botty.mod : Mod;

public class Bot : Client
{
    private string[] channels;

    private Mod[] modules;

    this(ConnectionInfo info, string[] channels)
    {
        super(info);
        this.channels = channels;

        // TODO: testing addTestModules
        addTestModules();
    }

    // TODO: testing method
    private void addTestModules()
    {
        import botty.modules.deavmicomedy : DeavmiComedy;
        import botty.modules.eskom : EskomCalendarAPI;
        import botty.modules.ping : Ping;
        import botty.modules.rot13 : Rot13;
        import botty.modules.translate : Translate;
        modules ~= [
                        new DeavmiComedy(this),
                        new EskomCalendarAPI(this),
                        new Ping(this),
                        new Rot13(this),
                        new Translate(this)
                    ];
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
        
        // reactCommand(fullMessage, channel, msgBody);
        modulePass(fullMessage, channel, msgBody);
    }


    private void modulePass(Message fullMessage, string channel, string msgBody)
    {
        foreach(Mod mod; modules)
        {
            /**
             * Does this module accept the message?
             * If so, then execute its routine
             */
            if(mod.accepts(fullMessage, channel, msgBody))
            {
                mod.react(fullMessage, channel, msgBody);
            }
        }
    }

    // TODO: Remove this, not used anymore (rather modulePass() is used)
    private void reactCommand(Message fullMessage, string channel, string msgBody)
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