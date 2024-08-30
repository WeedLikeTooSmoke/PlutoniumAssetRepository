How to setup the files

What you'll need first
1. Feddddddd's t6 utils plugin (goes in /plutonium/storage/t6/plugins/t6-gsc-utils.dll)
2. A web server wether it be IIS, Xampp, Wamp they all should work fine as long as youre using up to date php (im using PHP 8+)
3. mysql setup


edit /game/class.database.php and add your mysql settings<br>
edit /game/configs/config.request.php and add your api key and server name<br>
edit /game/configs/config.settings.php and replace the data with what you want them to be<br>

add the below text to you server config file
//////////////////////////////////////////////////<br>
//              Clipstone Settings              //<br>
//////////////////////////////////////////////////<br>
set x_api_key "put your api key here"<br>

upload the database howveer you want from /database/

if you need any help you can get to me in my discord server or message me on my twitter

https://discord.gg/clipstone
https://x.com/weedliketoosmok
