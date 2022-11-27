---
banner: "assets/banners/Process-Banner.png"
banner_x: 0.2
banner_y: 0.8
---

# Process

Several custom scripts and utilities were used to automate the generation of markdown files in the Obsidian Custom Discogs vault. These custom scripts utilize the Discogs API to make requests, parse the returned JSON data, and generate markdown format documents for items in the Discogs collection.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Discogs Collection](#discogs_collection)
- [Updates](#updates)
- [See also](#see_also)

## Overview

If your media library is cataloged in the online service [Discogs](https://discogs.com) then it is possible to query your online library using the Discogs API. The returned results of these API requests can be converted to markdown format.

## Requirements

Most of the download, conversion, creation, and curation process was performed on Linux using the standard utilities included with every Linux distribution. It is probably also possible to use these same tools on Mac OS as its underlying operating system and utilities are BSD. I doubt this will work on Windows but maybe with WSL. Use Linux.

In addition to the standard Linux utilities, the download and conversion tools require `curl` and `jq`.

## Discogs_Collection

Automation for generating markdown from a user's [Discogs](https://discogs.com) collection has been implemented in the `Tools/Discogs/albums2markdown` and `Tools/Discogs/artists2markdown` scripts. These scripts use the Discogs API to retrieve album/artist data and generate the markdown and cover art for all items and artists in a user's Discogs collection.

The Discogs API requires a Discogs username and, optionally, a Discogs API token. These can be found in your Discogs account and placed in the file `$HOME/.config/mpprc` as follows:

```shell
# The Discogs username can be found by visiting discogs.com. Login, use the
# dropdown of your user icon in the upper right corner, click on 'Profile'.
# Your Discogs username is the last component of the profile URL. IF you do
# not have a Discogs account, leave blank.
DISCOGS_USER=your_discogs_username
# The Discogs API token can be found by visiting
# https://www.discogs.com/settings/developers
DISCOGS_TOKEN="your_discogs_api_token"
```

After configuring your Discogs username and API token, generate markdown for your Discogs collection by running the `Setup.sh` script:

```console
./Setup.sh
```

The resulting markdown and cover art can be found in the `username` and `assets` folders where `username` is your capitalized Discogs username.

**[Note:]** For large Discogs collections this process can take a while.

See the script [Tools/Discogs/albums2markdown](Tools/Discogs/albums2markdown.md):

See the script [Tools/Discogs/artists2markdown](Tools/Discogs/artists2markdown.md):

## Updates

Updating the vault with new markdown for items or artists added to your Discogs collection is supported by the above scripts. Automation for this task has been coded in the `Tools/Discogs/albums2markdown` and `Tools/Discogs/artists2markdown` scripts. To update the Discogs markdown and cover art with newly added entries to a Discogs collection, simply rerun the `Setup.sh` script with the '-U' or '-F' option ('-U' is faster, '-F' regenerates all Discogs markdown):

```console
./Setup.sh -U
```

## See_also

- [README](README.md)
- [Discogs Queries](Discogs_Queries.md)
