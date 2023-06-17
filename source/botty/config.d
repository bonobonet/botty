module botty.config;

import std.stdio : File;
import std.json : parseJSON, JSONValue, JSONException;

public struct Config
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

public Config getConfig(string configPath)
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