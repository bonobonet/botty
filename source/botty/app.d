module botty.app;

import std.stdio;
import birchwood;
import botty.bot : Bot;

void main()
{
	writeln("Edit source/app.d to start your project.");

	ConnectionInfo connInfo;

	Bot botty = new Bot(connInfo);
}
