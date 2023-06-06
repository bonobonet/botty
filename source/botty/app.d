module botty.app;

import std.stdio;
import birchwood;
import botty.bot : Bot;

void main()
{
	writeln("Edit source/app.d to start your project.");

	ConnectionInfo connInfo = ConnectionInfo.newConnection("worcester.community.networks.deavmi.assigned.network", 6667, "birchwood", "doggie", "Tristan B. Kildaire");

	// // Set the fakelag to 1 second
	// connInfo.setFakeLag(1);
	
	Bot botty = new Bot(connInfo);

	// Start the bot
	botty.start();
}
