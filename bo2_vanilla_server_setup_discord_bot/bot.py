import discord
import mysql
from discord.ext import commands
from discord import app_commands
from mysql.connector import MySQLConnection, Error, Connect

TOKEN = '' # put your discord bot otken here
client = discord.Client(intents=discord.Intents.all())
SERVERID = # put your server id here

mydb = mysql.connector.connect(
 host="localhost",
 user="", # put your mysql username here
 password="", # put your mysql password here
 database="" # put your mysql database name here
)

class abot (discord.Client):
    def __init__(self):
        super().__init__(intents=discord.Intents.default(), status=discord.Status.online)
        self.synced = False

    async def on_ready(self):
        await tree.sync(guild=discord.Object(id=SERVERID))
        self.synced = True
        print("The bot is online and connected!")

bot = abot()
tree = app_commands.CommandTree(bot)

def checkStats(stats):
    match stats:
        case "kills":
            return True
        case "revives":
            return True
        case "downs":
            return True
        case "deaths":
            return True
        case _:
            return False

def checkGame(game):
    match game:
        case "bo2":
            return True
        case "bo1":
            return True
        case _:
            return False

def checkType(type):
    match type:
        case "modded":
            return True
        case "vanilla":
            return True
        case _:
            return False

@tree.command(name="leaderboard",description="Shows all highest rounds for all maps",guild=discord.Object(id=SERVERID))
async def self(interaction: discord.Interaction, type:str, game:str):
    embedVar = discord.Embed(title="Error", description="Something went wrong running this command", color=0xe74c3c)

    if checkType(type):
        if checkGame(game):
            query = mydb.cursor()
            query.execute("SELECT * FROM "+game+"_"+type+"_round_leaderboard")
            result = query.fetchall()
            embedVar = discord.Embed(title=game+" "+type+" Leaderboard", description="Showing the "+type+" "+game+" zombie highest round leaderboard", color=0x3498db)
            for row in result:
                embedVar.add_field(name=row[1], value="Round " + str(row[3]) + " by " + row[2], inline=False)
            embedVar.set_image(url="https://i.postimg.cc/QC3x486S/Banner-Clipstone.png")
            embedVar.set_thumbnail(url="https://storage.ko-fi.com/cdn/useruploads/post/068c8d03-e724-4676-b40d-3dcfa63690bb_3f5ca16c-e7b5-4851-8ac6-8874b1b6224f.png")

    await interaction.response.send_message(embed=embedVar)

@tree.command(name="topstats",description="Shows the highest stats players",guild=discord.Object(id=SERVERID))
async def self(interaction: discord.Interaction, type:str, game:str, stats:str):
    embedVar = discord.Embed(title="Error", description="Something went wrong running this command", color=0xe74c3c)

    if checkType(type):
        if checkGame(game):
            if checkStats(stats):
                query = mydb.cursor()
                query.execute("SELECT "+stats+", username FROM "+game+"_"+type+"_zombie_user_stats ORDER BY "+stats+" DESC LIMIT 10")
                result = query.fetchall()
                embedVar = discord.Embed(title=game+" "+type+" Leaderboard", description="Showing the "+type+" "+game+" zombie highest stats leaderboard", color=0x3498db)
                for row in result:
                    embedVar.add_field(name=stats, value=row[1] + "'s " + stats + ": "+str(row[0]), inline=False)
                embedVar.set_image(url="https://i.postimg.cc/QC3x486S/Banner-Clipstone.png")
                embedVar.set_thumbnail(url="https://storage.ko-fi.com/cdn/useruploads/post/068c8d03-e724-4676-b40d-3dcfa63690bb_3f5ca16c-e7b5-4851-8ac6-8874b1b6224f.png")

    await interaction.response.send_message(embed=embedVar)

bot.run(TOKEN)
