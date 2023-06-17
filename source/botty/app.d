module botty.app;

import std.stdio;
import birchwood;
import botty.bot : Bot;
import std.exception : ErrnoException;
import std.json : parseJSON, JSONValue, JSONException;
import core.stdc.stdlib : exit;
import std.string : split;

void main(string[] args)
{
	// TODO: Read path from args and if not present
	// ... then default to `config.json`
	string configPath = "config.json";
	Config config;

	try
	{
		config = getConfig(configPath);
	}
	catch(ErrnoException e)
	{
		// TODO: Replace all writeln with gogga logs
		writeln("Could not open configuration file '"~configPath~"'");
		exit(-1);
	}
	catch(JSONException e)
	{
		writeln("Error parsing the JSON in config file '"~configPath~"'");
		exit(-1);
	}

	// TODO: Extract config info here and set it in the `connInfo` below
	ConnectionInfo connInfo = ConnectionInfo.newConnection("worcester.community.networks.deavmi.assigned.network", 6667, "bottyng", "doggie", "Tristan B. Kildaire");

	// // Set the fakelag to 1 second
	// connInfo.setFakeLag(1);
	
	// Extract the channels to connect to
	string[] channels = split(config.channels, ",");

	Bot botty = new Bot(connInfo, channels);

	// Start the bot
	botty.start();
}

struct Config
{
	/** 
	 * Server's address
	 */
	string serverAddr;

	/** 
	 * Server's port
	 */
	int serverPort;

	/** 
	 * Nickname to use
	 */
	string nickname;

	/** 
	 * Channels to join (in CSV format (for now))
	 */
	string channels;
}

Config getConfig(string configPath)
{
	File configFile;
	configFile.open(configPath);

	ubyte[] data;
	data.length = configFile.size();
	configFile.rawRead(data);
	configFile.close();

	import jstruct;

	JSONValue json = parseJSON(cast(string)data);
	Config config = fromJSON!(Config)(json);

	return config;
}
