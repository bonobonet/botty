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
        else
        {

        }
       
        writeln("Eskom command: '"~command~"'");

        // getBot().channelMessage(funniedText, channel);
    }
}