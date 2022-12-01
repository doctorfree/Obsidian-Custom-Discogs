---
banner: "assets/banners/Process-Banner.png"
banner_x: 0.2
banner_y: 0.8
---

# Process

Several custom scripts and utilities were used to automate the generation of markdown files in the Obsidian Custom Discogs vault. These custom scripts utilize the Discogs API to make requests, parse the returned JSON data, and generate markdown format documents for items in the Discogs collection or local music library.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Discogs Collection](#discogs_collection)
- [Local Music Library](#local_music_library)
- [Usage](#usage)
- [Updates](#updates)
- [See also](#see_also)

## Overview

If your media library is cataloged in the online service [Discogs](https://discogs.com) or stored locally in `.../artist name/album name/` folders then it is possible to query the Discogs API to retrieve info on the artists, albums, and tracks in your collection or library. The returned results of these API requests can be converted to markdown format.

## Requirements

Most of the download, conversion, creation, and curation process was performed on Linux using the standard utilities included with every Linux distribution. It is probably also possible to use these same tools on Mac OS as its underlying operating system and utilities are BSD. I doubt this will work on Windows but maybe with WSL. Use Linux.

In addition to the standard Linux utilities, the download and conversion tools require `curl` and `jq`.

## Discogs_Collection

Automation for generating markdown from a user's [Discogs](https://discogs.com) collection has been implemented in the `Tools/Discogs/mkdiscogs`, `Tools/Discogs/albums2markdown` and `Tools/Discogs/artists2markdown` scripts. These scripts use the Discogs API to retrieve album/artist data and generate the markdown and cover art for all items and artists in a user's Discogs collection.

The Discogs API requires a Discogs username and, optionally, a Discogs API token. These can be found in your Discogs account and placed in the file `$HOME/.config/mpprc` as follows:

```shell
# The Discogs username can be found by visiting discogs.com. Login, use the
# dropdown of your user icon in the upper right corner, click on 'Profile'.
# Your Discogs username is the last component of the profile URL. IF you do
# not have a Discogs account, leave blank.
DISCOGS_USER="your_discogs_username"
# The Discogs API token can be found by visiting
# https://www.discogs.com/settings/developers
DISCOGS_TOKEN="your_discogs_api_token"
```

After configuring your Discogs username and API token, generate markdown for your Discogs collection by running the `Setup` script:

```console
./Setup
```

The resulting markdown and cover art can be found in the `Username` and `assets` folders where `Username` is your capitalized Discogs username.

If you wish to generate markdown from another Discogs user, run the `Setup` script with the `-u user` option. For example, to generate markdown for the items and artists in Discogs user Dr_Robert's collection, run the following:

```console
./Setup -u Dr_Robert
```

The resulting markdown and cover art can be found in the `Dr_Robert` and `assets` folders.

**[Note:]** For large Discogs collections this process can take a while.

See the script [Tools/Discogs/mkdiscogs](Tools/Discogs/mkdiscogs.md):

See the script [Tools/Discogs/albums2markdown](Tools/Discogs/albums2markdown.md):

See the script [Tools/Discogs/artists2markdown](Tools/Discogs/artists2markdown.md):

## Local_Music_Library

Don't have a Discogs user collection? No problem, the same tools and Discogs API requests can be used to automate the generation of markdown descriptions of a local music library. You will still need a Discogs account and Discogs API token. The account and token are free. But you do not have to go through the manual process of adding all the albums in your library into Discogs as a user collection.

**[Note:]** To generate markdown from a local music library, the library must be organized by artist subfolders containing album folders. For example, the tracks from the album "Imagine" by John Lennon would be in the folder `/path/to/library/John Lennon/Imagine/`. If you prefer pathnames without spaces, use an underscore in place of spaces and the markdown generation scripts will perform the appropriate transformation when searching Discogs (e.g. `/path/to/library/John_Lennon/Imagine/` would work).

Follow the same process described above to configure `~/.config/mpprc` with your Discogs username and API token. After configuring your Discogs username and API token, generate markdown from your local music library by running the `Setup` script with the `-L /path/to/library` option:

```console
./Setup -L /path/to/library
```

The markdown and cover art generated from a local music library can be found in the `Music_Library` and `assets` folders. Multiple local libraries from different folder paths can be converted to markdown in the vault by running the `Setup` script multiple times with different `-L /path/to/library` arguments and by providing different vault names for each library with the `-v vault` command line option.

For example, to generate markdown for the albums and artists in `/u/audio/jazz` and name the markdown output folder `Jazz`, run the following:

```console
./Setup -L /u/audio/jazz -v Jazz
```

## Usage

The `Setup` command has the following output from `./Setup -h`:

```console
Usage: ./Setup [-L /path/to/library] [-v vault] [-R] [-U] [-t token] [-u user] [-h]
Where:
	-L 'path' indicates use a local music library rather than Discogs collection
	-R indicates remove intermediate JSON created during previous run
	-U indicates perform an update of the Discogs collection
	-t 'token' specifies the Discogs API token
	-u 'user' specifies the Discogs username
	-v 'vault' specifies the folder name for generated artist/album markdown
	-h displays this usage message and exits
Example invocations:
	# Retrieve Discogs collection
	# Generated markdown in capitalized Discogs username folder
	./Setup
	# Generated markdown in 'Discogs' folder
	./Setup -v Discogs
	# Retrieve Discogs user 'foobar' collection
	./Setup -u foobar
	# Retrieve Discogs data for local music library in /u/audio
	./Setup -L /u/audio -v Audio
	# Provide Discogs username and API token on command line
	./Setup -L ~/Music -u doctorfree -t xyzkdkslekjrelrkek
	# Retrieve Discogs data for genre local music library in /u/jazz
	./Setup -L /u/jazz -v Jazz
```

## Updates

Updating the vault with new markdown for items or artists added to your Discogs collection or local music library is supported by the above scripts. Automation for this task has been coded in the automation scripts. To update the Discogs markdown and cover art with newly added entries to a Discogs collection, simply rerun the `Setup` script with the '-U' or '-F' option ('-U' is faster, '-F' regenerates all Discogs markdown):

```console
./Setup -U
```

Similarly, to update generated markdown with newly added entries in a local music library, rerun the `Setup` script with '-U':

```console
./Setup -L /path/to/library -U
```

## See_also

- [Dataview Queries](Dataview_Queries.md)
- [README](README.md)
- [Release Notes](Release_Notes.md)
