/**
 * Translation module
 */
module botty.modules.translate;

import botty.mod;
import botty.bot : Bot;
import birchwood.protocol.messages : Message;

import std.json : parseJSON, JSONException, JSONValue;
import std.net.curl : CurlException;

/**
 * Translation module
 */
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
        import std.string : indexOf, strip, split;

    
        string[] splits = split(strip(messageBody), " ");
        long textIdx = indexOf(messageBody, " ");
    

        // Check for `.tr:<lang>`
        string toLang = "en";
        long toLangIdx = splits[0].indexOf(":");
        if(toLangIdx > -1)
        {
            toLang = splits[0].split(":")[1];
        }

        if(textIdx > -1)
        {
            string textToTranslate = strip(messageBody[textIdx+1..$]);

            if(textToTranslate.length == 0)
            {
                getBot().channelMessage("No text to translate", channel);
                return;
            }

            try
            {
                string translatedText = translate(textToTranslate, toLang);
                getBot().channelMessage(translatedText, channel);
            }
            // On network error
            catch(CurlException e)
            {
                getBot().channelMessage("There was a network error when translating", channel);
            }
            // On parsing error
            catch(JSONException e)
            {
                getBot().channelMessage("There was a parsing error when translating", channel);
            }
        }
        else
        {
            getBot().channelMessage("Please specify a text to translate", channel);
        }   
    }

    /** 
     * Translates the provided text into the given language (default `"en"` for English)
     *
     * Params:
     *   inputText = the text to translate
     * Returns: the translated text
     */
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

        // Parse the result
        JSONValue[] result = parseJSON(data).array();

        import std.stdio : writeln;
        writeln(result);

        // FIXME: This needs some cleaning, seems like JSON

        
        writeln(translatedText = result[0].array()[0].array()[0].str());

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