# CakBot

Cak's Command bot for Discord®

## Custom Commmand Syntax

!addcomm [permitted flags] [args] output

 - [permitted flags] - a list of the flags that this command is usable with
   - use -- instead to make the flag implicit in all uses of the command
 - [args] - $[type][?][*] 
   - ? - Specifies an optional argument. Optional args must come last.
   - \* - Specifies a text arg that may contain spaces. Must be final arg.
     - ***TODO DETERMINE \*/? compatability***
   - Supported types: ***TODO***

### Flags

 - -d : deletes the users message calling the bot

## Dependencies

Uses ruby version 2.3.3, but probably also works with other versions just fine.

Initially cloned from the dicordrb repository, then modified. Cloned from this commit: https://github.com/meew0/discordrb/commit/1de6923bd5e7001d5250c1bd8a78ff36be7d247e

## Usage

Create a .env file with the following information about your bot:

    CLIENT_ID = [clientid]
    CLIENT_SECRET = 'client secret here'
    TOKEN = 'token here'

Then Run the file "lib/cakbot.rb"

## License

The bot is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Specs

I don't intend to maintain the original specs as I modify the Discordrb source.

I might write specs for my own code but ¯\_(ツ)_/¯

## Notes from the original README

### Voice dependencies

This section only applies to you if you want to use voice functionality.
* [libsodium](https://github.com/meew0/discordrb/wiki/Installing-libsodium)
* A compiled libopus distribution for your system, anywhere the script can find it. See [here](https://github.com/meew0/discordrb/wiki/Installing-libopus) for installation instructions.
* [FFmpeg](https://www.ffmpeg.org/download.html) installed and in your PATH

In addition to this, if you're on Windows and want to use voice functionality, your installed Ruby version **needs to be 32 bit**, as otherwise Opus won't work.


#### Troubleshooting

**If you're having trouble getting voice playback to work**:

Look here: https://github.com/meew0/discordrb/wiki/Voice-sending#troubleshooting
