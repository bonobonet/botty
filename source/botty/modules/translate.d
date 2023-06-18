/**
 * Translation module
 */
module botty.modules.translate;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

// TODO: Implement me
public final class Translate : Mod
{
    private static string commandStr = ".tr";

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

        // TODO: Implement me
    }

    private static string translate(string inputText, string toLang = "en")
    {
        string translatedText;

        // Apply escaping to both query parameters
        import std.string : fromStringz;
        import etc.c.curl : curl_escape;
        inputText = cast(string)fromStringz(curl_escape(cast(const(char)*)inputText.ptr, cast(int)inputText.length));
        toLang = cast(string)fromStringz(curl_escape(cast(const(char)*)toLang.ptr, cast(int)toLang.length));

        // Do the request
        import std.net.curl;
        string data = cast(string)get("https://translate.google.com/translate_a/single?client=gtx&sl=auto&tl="~toLang~"&dt=t&q="~inputText);

        // FIXME: This needs some cleaning, seems like JSON
        
        translatedText = data;

        return translatedText;
    }
}

version(unittest)
{
    import std.stdio;
}

unittest
{
    string translated = Translate.translate("Halo daar");
    writeln(translated);
}