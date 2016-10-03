# Fist Weapon - WoW Guild Website Builder [![Build Status](https://travis-ci.org/JamesHDuffield/fistweapon.svg?branch=master)](https://travis-ci.org/JamesHDuffield/fistweapon)

This project is designed to create a moderation light World of Warcraft guild website. Information about your guild is loaded from battle.net through api calls and news is loaded from your discord channel to create a dynamic site that takes no maintenance!

## Starting your own guild website

Sign up for Heroku, then click the button below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Modify the options as specified below:
- DISCORD_CHANNEL_ID: Ensure development mode is active and obtain your [channel id](https://support.discordapp.com/hc/en-us/articles/206346498-Where-can-I-find-my-server-ID-)
- DISCORD_KEY: This key will be the [discord bot's](https://discordapp.com/developers/applications/me/create) token, following the format 'Bot <token>'. Ensure that the bot is [registered](https://discordapp.com/developers/docs/topics/oauth2#adding-bots-to-guilds) for permission to the channel referenced above.
- BNET_API_KEY: API key for Blizzard battle.net API. You can apply for a key [here](https://dev.battle.net/member/register).
- BNET_REGION: Battle.net region. (us, eu, etc)
- WOW_REALM: World of Warcraft realm/server name
- WOW_GUILD: Name of World of Warcraft Guild
- WOW_CHARACTER_NAME: Name of character to track progression data on. Must be a member of the selected guild. It is usually best to select someone like the guild leader.
- WOW_RAIDS: Comma seperated list of raids to display progression for. (e.g 'The Emerald Nightmare,Hellfire Citadel,Firelands')
- REPORT_USERNAME: Username for authentication moderate reports
- REPORT_PASSWORD: Password for authentication moderate reports

Click Deploy to create you're new guild website.

## Development Setup

Make sure you have installed the following plugins:
```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-librarian-chef-nochef
```

Then you can `vagrant up`!
