/**
 * Ping module for botty
 */
module botty.modules.ping;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

/** 
 * Ping command
 */
public final class Ping : Mod
{
    private static string commandStr = ".ping";

    /** 
     * Constructs a new `Ping` module with the provided
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
        import std.string : split, strip;
        string[] splits = split(strip(messageBody), " ");

        if(splits.length == 2)
        {
            // Grab the domain
            string domain = splits[1];

            import std.stdio : writeln;
            writeln("ping: domain is: '"~domain~"'");

            // TODO: Implement me
            import std.process;
            import std.stdio : File;

            import std.stdio : StdioException;

            try
            {
                ProcessPipes pipes = pipeProcess(["/usr/bin/ping", "-c", "4", "-i", "0.2", domain]);

                // Wait for the process to finish
                Pid pid = pipes.pid();
                int exitCode = wait(pid);

                // On clean exit
                if(exitCode == 0)
                {
                    File stdout = pipes.stdout();

                    // Skips the nine lines
                    for(int i = 0; i < 8; i++)
                    {
                        stdout.readln();
                    }

                    string str = strip(stdout.readln(), "\n");
                    writeln(str);
                    getBot().channelMessage(str, channel);
                }
                // On error
                else
                {
                    File stderr = pipes.stderr();

                    string str = strip(stderr.readln(), "\n");
                    writeln(str);
                    getBot().channelMessage(str, channel);
                }
            }
            catch(StdioException e)
            {
                writeln(e);
            }
            catch(ProcessException e)
            {
                writeln(e);
            }
        }
        else
        {
            // TODO: This is an error - too many commands
            getBot().channelMessage("A domain or address is required for the ping (no more than that and no less)", channel);
        }
    }
}