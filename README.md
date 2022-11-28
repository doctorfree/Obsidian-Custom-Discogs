# Obsidian Discogs Vault

This repository is organized as an Obsidian vault designed to add media descriptions from a Discogs collection in markdown format. It can be viewed using any markdown viewer (e.g. almost any browser) but if Obsidian is used then many additional features will be available including queries using the [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) plugin for [Obsidian](https://obsidian.md/).

The `Obsidian-Custom-Discogs` repository is a stripped down version of the `Obsidian-Discogs-Vault` repository, omitting the pre-generated markdown from my personal Discogs collection while retaining the structure and scripts used to generate a Discogs collection vault. See the [description of Process](Process.md) for an overview of the process and tools employed in the use of this repository.

Other Obsidian vaults I have curated and made public include:

- [Obsidian Beets Vault](https://github.com/doctorfree/Obsidian-Beets-Vault)
- [Obsidian Books Vault](https://github.com/doctorfree/Obsidian-Books-Vault)
- [Obsidian CD Vault](https://github.com/doctorfree/Obsidian-CD-Vault)
- [Obsidian Discogs Vault](https://github.com/doctorfree/Obsidian-Discogs-Vault)
- [Obsidian Roon Vault](https://github.com/doctorfree/Obsidian-Roon-Vault)
- [Obsidian Vinyl Vault](https://github.com/doctorfree/Obsidian-Vinyl-Vault)
- [Obsidian Media Vault](https://github.com/doctorfree/Obsidian-Media-Vault)
- [Pokemon Markdown Vault](https://github.com/doctorfree/Pokedex-Markdown)

## Table of Contents

- [Quickstart](#quickstart)
- [Setup](#setup)
- [Usage](#usage)
- [Dataview](#dataview)
- [Discogs](#discogs)
- [Process](#process)
- [Screenshots](#screenshots)
- [Obsidian Plugins](#obsidian_plugins)
- [See also](#see_also)

## Quickstart

1. [Download the vault](https://github.com/doctorfree/Obsidian-Custom-Discogs/archive/refs/tags/v1.0.1r3.tar.gz)
2. Extract the vault: `tar xf /path/to/Obsidian-Custom-Discogs-1.0.1r3.tar.gz`
3. Set the Discogs username (`DISCOGS_USER`) and API token (`DISCOGS_TOKEN`) in `$HOME/.config/mpprc`
4. Customize the vault by running `./Setup` in the vault folder
5. Open the vault in Obsidian via "Open another vault -> Open folder as vault"

## Setup

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

Alternately, the Discogs username and API token can be specified on the command line:

```console
./Setup -u username -t token
```

The resulting markdown and cover art can be found in the `Username` and `assets` folders where `Username` is your capitalized Discogs username. Multiple Discogs collections from different Discogs users can be converted to markdown in the vault by running the `Setup` script multiple times with different `-u username` arguments.

For example, to generate markdown for the items and artists in Discogs user Dr_Robert's collection, run the following:

```console
./Setup -u Dr_Robert
```

The resulting markdown and cover art can be found in the `Dr_Robert` and `assets` folders.

**[Note:]** For large Discogs collections this process can take a while. Discogs throttles API requests to prevent denial of service attacks. I have tried to minimize API requests where possible but if you see any way to further optimize please [open an issue](https://github.com/doctorfree/Obsidian-Custom-Discogs/issues).

## Usage

### **For the optimal experience, open this vault in Obsidian!**

1. [Download the vault](https://github.com/doctorfree/Obsidian-Custom-Discogs/releases/latest)
3. Open the vault in Obsidian via "Open another vault -> Open folder as vault"
4. Trust us. :) 
5. When Obsidian opens the settings, verify the "Dataview" plugin is enabled
6. Done! The Obsidian Custom Discogs vault is now available to you in its purest and most useful form!

## Dataview

The Obsidian Custom Discogs vault has been curated with metadata allowing queries to be performed using the Obsidian Dataview plugin. Sample queries along with the code used to perform them can be viewed in the [Dataview Queries](Dataview_Queries.md) document.

Additional visual representations of the Custom Discogs Vault, also based upon Dataview queries, are provided by the [Excalibrain](https://github.com/zsviczian/excalibrain) Obsidian plugin.

The Obsidian Custom Discogs vault markdown contains metadata with tags allowing a variety of Obsidian Dataview queries.

## Discogs

[Discogs](https://www.discogs.com) users with curated Discogs collections can generate markdown format files for all items and artists in their Discogs collection using the Discogs API. See [Process.md](Process.md) for details on how to automate this process.

## Process

See the [Process](Process.md) document for a detailed description of the tools and process used to generate this vault.

## Screenshots

### Example album release generated markdown

![](assets/Album-Info-One.png)

![](assets/Album-Info-Two.png)

### Example artist profile generated markdown

![](assets/Artist-Info-One.png)

![](assets/Artist-Info-Two.png)

## Obsidian_Plugins

Obsidian community plugins we have found useful and can recommend include the following:

- [Contextual Typography](https://github.com/mgmeyers/obsidian-contextual-typography): Enables enhanced preview typography
- [Dataview](https://github.com/blacksmithgu/obsidian-dataview): Treats an Obsidian Vault as a database from which you can query
- [Excalibrain](https://github.com/zsviczian/excalibrain): An interactive structured mind-map of an Obsidian vault
- [Excalidraw](https://github.com/zsviczian/obsidian-excalidraw-plugin): Edit and view Excalidraw in Obsidian
- [Hider](https://github.com/kepano/obsidian-hider): Hides various elements of the UI
- [Hover-editor](https://github.com/nothingislost/obsidian-hover-editor): Turns the hover popover into a full featured editor
- [Pandoc](https://github.com/OliverBalfour/obsidian-pandoc): Adds command palette options to export your notes to a variety of formats
- [Quickadd](https://github.com/chhoumann/quickadd): Quickly add content to a vault
- [Shellcommands](https://github.com/Taitava/obsidian-shellcommands): Define and run shell commands
- [Style Settings](https://github.com/mgmeyers/obsidian-style-settings): Enables theme customization
- [Templater](https://github.com/SilentVoid13/Templater): Defines a powerful templating language

## See_also

- [Dataview Queries](Dataview_Queries.md)
- [Process](Process.md)
