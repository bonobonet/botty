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
    /** 
     * The `Bot` associated with this module instance
     */
    private Bot bot;

    /** 
     * Creates a new `Mod`-ule with the associated bot
     * such that one can get access to facilities for
     * sending messages
     *
     * Params:
     *   bot = the `Bot` to associate with this instance
     */
    this(Bot bot)
    {
        this.bot = bot;
    }

    /** 
     * Returns the `Bot` instance associated with this module
     *
     * Returns: the associated `Bot`
     */
    protected final Bot getBot()
    {
        return bot;
    }

    public abstract bool accepts(Message fullMessage, string channel, string messageBody);
    public abstract void react(Message fullMessage, string channel, string messageBody);
}