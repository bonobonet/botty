/** 
 * Base definitions from which can be used
 * to derive one's own Botty modules
 */
module botty.mod;

import botty.bot : Bot;
import birchwood.protocol.messages : Message;

/** 
 * Represents a module that has code that can be run
 * dependent on whether it accepts the provided message
 */
public abstract class Mod
{
    private Bot bot;
    this(Bot bot)
    {
        this.bot = bot;
    }

    public final Bot getBot()
    {
        return bot;
    }

    public abstract bool accepts(Message fullMessage, string channel, string messageBody);
    public abstract void react(Message fullMessage, string channel, string messageBody);
}