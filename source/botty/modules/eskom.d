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
        import std.string : indexOf;

        // Guaranteed to not be -1 as `accepts()` wouldn't have passed then
        long commandIdx = indexOf(messageBody, commandStr);
        string command = messageBody[commandIdx+commandStr.length..$];

        // TODO: For this we should rather split the message by `" "`

        import std.stdio;
        writeln("Eskom command: '"~command~"'");

        // getBot().channelMessage(funniedText, channel);
    }
}