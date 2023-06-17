/**
 * Eskom Calendar API module
 *
 * This let's one query for load shedding
 * in their area and also get a list of areas
 */
module botty.modules.eskom;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;
import eskomcalendar;

public class EskomCalendarAPI : Mod
{
    private static string commandStr = ".eskom";
    private EskomCalendar calendar;

    this(Bot bot)
    {
        super(bot);

        // INitialize a new EskomCalendar provider
        this.calendar = new EskomCalendar();
    }

    public override bool accepts(Message fullMessage, string channel, string messageBody)
    {
        import std.string : startsWith;
        return messageBody.startsWith(commandStr);
    }

    public override void react(Message fullMessage, string channel, string messageBody)
    {
        import std.stdio;
        import std.string : indexOf, split, strip;

        // Guaranteed to not be -1 as `accepts()` wouldn't have passed then
        long commandIdx = indexOf(messageBody, commandStr);
        string command = messageBody[commandIdx+commandStr.length..$];

        // TODO: For this we should rather split the message by `" "`
        string[] splits = messageBody.split(" ");
        writeln("Eskom splits: ", splits);

        // TODO: Send message of error if the `splits` is too small
        command = strip(splits[1]);

        if(command.length == 0)
        {
            getBot().channelMessage("Invalid command for Eskom Calendar", channel);
        }
        /**
         * Searching for areas
         *
         * Usage: `.eskom areas` (for all areas)
         *        `.eskom areas 500-510` (all areas from 500 to 509)
         */
        else if(command == "areas")
        {
            // TODO: Look for optional range
            // TODO: Do fuzzy search?
            string[] areas = calendar.getAreas();

            int begin = -1, end = -1;

            // Range-based search
            if(splits.length == 3)
            {
                // Extract the range as n-m format
                string rangeInput = splits[2];
                string[] rangeElements = split(rangeInput, "-");

                if(rangeElements.length == 2)
                {
                    import std.conv : to, ConvException;
                    try
                    {
                        begin = to!(int)(rangeElements[0]);
                        end = to!(int)(rangeElements[1]);
                    }
                    catch(ConvException e)
                    {
                        getBot().channelMessage("Invalid range elements '"~rangeInput~"'", channel);
                        return;    
                    }
                }
                else
                {
                    getBot().channelMessage("Invalid range '"~rangeInput~"'", channel);
                    return;
                }
            }

            // If a range was specified
            if(begin != -1 && end != -1)
            {
                for(int idx = begin; idx < end && idx < areas.length; idx++)
                {
                    string curArea = areas[idx];
                    // TODO: Spruce the layout up with text formatting
                    getBot().channelMessage(curArea, channel);
                }
            }
            // If a range was not specified (list all of them)
            else
            {
                // TODO: Spruce the layout up with text formatting
                foreach(string area; areas)
                {
                    getBot().channelMessage(area, channel);
                }
            }

            // TODO: Do this with just one set of loop code
        }
       
        writeln("Eskom command: '"~command~"'");
    }
}