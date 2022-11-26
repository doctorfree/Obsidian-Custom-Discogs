# Release Notes

## Table of contents

1. [Overview](#overview)
1. [Installation](#installation)
1. [Configuration](#configuration)
1. [Customization](#customization)
1. [Removal](#removal)
1. [Support](#support)
1. [Changelog](#changelog)

## Overview

The Obsidian Custom Discogs vault is an [Obsidian](https://obsidian.md) vault designed to automate the generation of [Discogs](https://discogs.com) items and artist descriptions in markdown format. It can be viewed using any markdown viewer (e.g. almost any browser) but if Obsidian is used then many additional features will be available including queries using the [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) plugin for [Obsidian](https://obsidian.md/).

The `Obsidian-Custom-Discogs` repository can be used to automate the generation of Obsidian vault markdown files that reflect the items and artists in a Discogs collection. See the [description of Process](https://github.com/doctorfree/Obsidian-Custom-Discogs/Process.md) for an overview of the process and tools employed in the creation of this repository.

These are the release notes for Version 1.0.0 Release 1 of the Obsidian Custom Discogs vault.

## Installation

The Obsidian Custom Discogs vault can be installed on Windows, Mac, or Linux. The following installation instructions are for Mac and Linux. Windows users can follow similar steps.

**For the optimal experience, open this vault in Obsidian!**

1. [Download the vault](https://github.com/doctorfree/Obsidian-Custom-Discogs/releases/latest)
3. Open the vault in Obsidian via "Open another vault -> Open folder as vault"
4. Trust us. :) 
5. When Obsidian opens the settings, verify that the "Dataview", "Excalidraw", and "Excalibrain" plugins are enabled
6. Done! The Obsidian Custom Discogs vault is now available to you in its purest and most useful form!

### Download the release archive

[Download the latest release](https://github.com/doctorfree/Obsidian-Custom-Discogs/releases/latest).

Those familiar with `wget` can download this release from the command line with:

```shell
wget --quiet -O ~/Downloads/Obsidian-Custom-Discogs-v1.0.0r1.tar.gz \
  https://github.com/doctorfree/Obsidian-Custom-Discogs/archive/refs/tags/v1.0.0r1.tar.gz
```

### Extract the release archive

Currently release archives are available in either ZIP or compressed tar archive format.

To extract the ZIP archive:

```shell
cd /path/to/your/vaults # e.g. `cd ~/Documents/Obsidian`
unzip /path/to/Obsidian-Custom-Discogs-1.0.0r1.zip
```

To extract the compressed tar archive:

```shell
cd /path/to/your/vaults # e.g. `cd ~/Documents`
tar xf /path/to/Obsidian-Custom-Discogs-1.0.0r1.tar.gz
```

Once extracted, the Obsidian Custom Discogs vault is now available in `/path/to/your/vaults/Obsidian-Custom-Discogs-1.0.0r1/`.

The downloaded archive can be deleted:

```shell
rm -f /path/to/Obsidian-Custom-Discogs-1.0.0r1.zip
```

or

```shell
rm -f /path/to/Obsidian-Custom-Discogs-1.0.0r1.tar.gz
```

## Configuration

The Obsidian Custom Discogs vault is pre-configured for use with [Obsidian](https://obsidian.md). Install Obsidian for your platform by clicking the appropriate installation link at the Obsidian website. Obsidian is available for Windows, Mac, and Linux as well as mobile devices.

Add a new vault in Obsidian with `Open folder as vault` and navigate to the `Obsidian-Custom-Discogs-1.0.0r1` extracted folder. When prompted, `Trust` and enable the `Dataview` plugin if it is not already enabled.

The Obsidian Custom Discogs vault includes the `Doctorfree` Obsidian theme. Enable this Obsidian theme in Obsidian by visiting `Settings -> Appearance` and selecting `Doctorfree` from the dropdown in the `Themes` section.

Obsidian is required for some features but is not necessary to view the Obsidian Custom Discogs vault. Any markdown viewer/editor can be used. If the Obsidian Custom Discogs vault is extracted into a website folder, it can be viewed using most browsers.

### Discogs Queries

The Obsidian Custom Discogs vault has been curated with metadata allowing queries to be performed using the Obsidian Dataview plugin. Sample queries along with the code used to perform them can be viewed in the [Discogs Queries](https://github.com/doctorfree/Obsidian-Custom-Discogs/Discogs_Queries.md) document.

## Customization

Scripts included with the Obsidian Custom Discogs vault make it possible to customize the vault with your personal Discogs collection. If you have a Discogs account and have curated a Discogs collection there, then you can run the Obsidian Custom Discogs vault scripts to generate vault markdown reflecting your Discogs collection. These instructions will setup an automated workflow to retrieve your Discogs collection via the Discogs API and generate markdown from that collection.

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

After configuring your Discogs username and API token, generate markdown for your Discogs collection by running the following commands:

```console
cd Tools/Discogs
./mkdiscogs -a
```

The resulting markdown and cover art can be found in the `username` and `assets` folders where `username` is your capitalized Discogs username.

**[Note:]** For large Discogs collections this process can take a while.

## Removal

To remove the Obsidian Custom Discogs vault simply remove the extracted folder and its contents:

```shell
cd /path/to/your/vaults # e.g. `cd ~/Documents/Obsidian`
rm -rf Obsidian-Custom-Discogs-1.0.0r1
```

## Support

Support the development and improvement of the Obsidian Custom Discogs vault by [sponsoring the Projects of Doctorfree](https://github.com/sponsors/doctorfree).

<a href="https://www.buymeacoffee.com/doctorfree"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=doctorfree&button_colour=5F7FFF&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00"></a>

## Changelog

View the full changelog for this release at https://github.com/doctorfree/Obsidian-Custom-Discogs/blob/v1.0.0r1/CHANGELOG.md
