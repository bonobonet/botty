/** 
 * Deavmi Comedy module
 */
module botty.modules.deavmicomedy;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

/** 
 * Deavmi Comedy command
 */
public final class DeavmiComedy : Mod
{
    private static string commandStr = ".deavmicomedy";

    /** 
     * Constructs a new `DeavmiComedy` module with the provided
     * bot to associate with
     *
     * Params:
     *   bot = the `Bot` to associate with
     */
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

        import std.stdio;
        writeln("comedic");

        // Guaranteed to not be -1 as `accepts()` wouldn't have passed then
        long funnyIdx = indexOf(messageBody, commandStr);
        string toBeFunnied = messageBody[funnyIdx+commandStr.length..$];

        // // Apply the comedy (courtesy of @rany2's original Botty code)
        // import std.regex : regex, replaceAll;
        // string ranyRegex = `\x1f|\x01|\x02|\x12|\x0f|\x1d|\x16|\x0f(?:\d{1,2}(?:,\d{1,2})?)?|\x03(?:\d{1,2}(?:,\d{1,2})?)?`;
        // auto replacementRegex = regex(ranyRegex);
        
        // import std.stdio;
        // writeln(replacementRegex);

        // string funniedText = replaceAll(toBeFunnied, replacementRegex, "$&");

        string funniedText;
        foreach(char fChar; toBeFunnied)
        {
            funniedText = funniedText ~ fChar ~ ' ';
        }
        funniedText = funniedText.strip();

        getBot().channelMessage(funniedText, channel);
    }
}