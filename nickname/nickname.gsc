setupnickname()
{
	self endon("disconnect");
	level endon("end_game");
	path = "nickname/" + self getguid() + ".txt";
	if(!fileexists(path))
	{
		writefile(path, "");
		while(!fileexists(path))
		{
			wait(0,5);
		}
		file2 = fopen(path, "w");
		fwrite(file2, self.name);
		fclose(file2);
		self.pers["nickname"] = self.name;
	}
	else
	{
		self.pers["nickname"] = readfile(path);
	}
}
