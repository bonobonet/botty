/** 
 * Rot13 module
 */
module botty.modules.rot13;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

/** 
 * Rot 13 command
 */
public final class Rot13 : Mod
{
    private static string commandStr = ".rot13";

    /** 
     * Constructs a new `Rot13` module with the provided
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
        

        long idx = indexOf(messageBody, commandStr);
        string toBeSecretified = messageBody[idx+commandStr.length..$];

        getBot().channelMessage(doRot(toBeSecretified), channel);
    }

    /** 
     * Computes the Rot13 of the given input text
     *
     * Params:
     *   text = the input text to transform
     * Returns: the transformed text
     */
    private string doRot(string text)
    {
        import std.algorithm : map;
        import std.conv : to;

        return to!(string)(text.map!((ch) {
                    if (ch >= 'a' && ch <= 'z')
                        ch = (ch - 'a' + 13) % 26 + 'a';
                    if (ch >= 'A' && ch <= 'Z')
                        ch = (ch - 'A' + 13) % 26 + 'A';
                    return ch.to!char;
            }));
    }
}
