# Changelog

## Version 1.0.2 Release 6

- Set vault name if none specified in `Setup`

## Version 1.0.2 Release 5

- Add `wget` to dependencies
- Fix typo in `DISCOGS_USER` in `Tools/Discogs/` scripts and markdown
- Modify retry album search query term, removing the year and brackets
- Change user agent from `MusicPlayerPlus` to `ObsidianCustomDiscogs`
- Update markdown for `Setup` and `albums2discogs` changes

## Version 1.0.2 Release 4

* Handle vault and folder name args to support spaces in names
* Only pass vault and folder args if set
* Add configuration for Obsidian graph view to ignore Tools/Discogs/json/

## Version 1.0.2 Release 3

* Improve artist/album search with Discogs API search query
* URL encode search strings in search-albums-markdown
* Corrected Setup usage message

## Version 1.0.2 Release 2

* Support for adding releases to a Discogs collection
    * From previous `Setup -L /path/to/library` generated markdown
    * Can specify collection folder name 
    * Can specify local input folder name 
    * Can use existing collection folder or create new folder
    * Checks if release already exists in collection
* Fix artist links when artist name has spaces
* Support for adding releases to Discogs collection in Setup
* Support for vault and collection folder names with spaces
* Support for removing previously added items from a Discogs user collection folder

## Version 1.0.2 Release 1

* Add support for generation of markdown from a local library using Discogs API
* Additional fixes for mixing Discogs user collection and local music library
* Add artist profile creation for music library markdown generated using Discogs API
* Support for multiple local libraries (and multiple Discogs user collections)

## Version 1.0.1 Release 3

* Add Quickstart section to README and Release Notes
* Add -R option to Setup to remove intermediate JSON from previous run

## Version 1.0.1 Release 2

* Upgrade Doctorfree Obsidian theme
* Change references to 'album' metadata to 'title' in dataview queries
* Second pass at getting the filenames and links correct per user
* Check for curl and jq in Setup
* Fix generated Dataviews index
* Improve User Profile generated markdown

## Version 1.0.1 Release 1

* Fixed support for multiple Discogs users in the same vault
* Fixed bug with release pages for multiple Discogs users in the same vault
* Deleted daily note gif banner
* Use templates to generate index and query markdown per Discogs user

## Version 1.0.0 Release 2

* Simplify setup, generalize where possible to support multiple Discogs users
* Add Setup script and Obsidian settings

## Version 1.0.0 Release 1

* Copy and adapted from the Obsidian-Discogs-Vault
