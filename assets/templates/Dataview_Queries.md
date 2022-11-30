---
banner: "assets/banners/Dataview-Banner.png"
banner_x: 1.0
banner_y: 1.0
---

# Dataview Queries

The Obsidian Custom Discogs vault markdown contains metadata with tags allowing a variety of queries using the [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) plugin for [Obsidian](https://obsidian.md/). A few example Dataview queries are detailed below.

## Example Dataview Queries

Included here are [several examples](Dataviews/Dataviews.md) of utilizing the Obsidian Dataview plugin to make dynamic queries into a vault. The results of these queries will automatically update when the vault is modified. A few lines of code can produce complex queries with detailed results. It takes a bit of study to learn the Dataview plugin but it is worth it. Hopefully these examples will serve as good starting points in that learning process.

### Example Dataview Query

The markdown for "Fragile" by Yes has the following YAML prelude:

```yaml
---
title: Fragile
artist: Yes
label: Atlantic
formats: Vinyl, LP, Album, Reissue
genres: Rock, Prog Rock, Art Rock, Symphonic Rock
rating: 4.7
released: 2016-05-13
year: 1971
releaseid: 8515237
mediacondition: 
sleevecondition: 
speed: 
weight: 
notes: 
---
```

#### Dataview query

The above album metadata can be used to perform Dataview queries to search, filter, and retrieve albums as if they are in a database. For example, to produce a table of all albums in this vault by Yes released prior to 1980 add the following to a markdown file in the vault:

````markdown
```dataview
TABLE WITHOUT ID
  link(file.link, title) as Album,
  artist AS "Artist",
  year AS "Year"
FROM "__USERNAME__"
WHERE artist = "Yes" and year < 1980
SORT year ASC
```
````

The above Dataview code block produces the following output:

```dataview
TABLE WITHOUT ID
  link(file.link, title) as Album,
  artist AS "Artist",
  year AS "Year"
FROM "__USERNAME__"
WHERE artist = "Yes" and year < 1980
SORT year ASC
```

As a list grouped by artist rather than a table, the following dataview codeblock:

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE (artist = "Yes" OR artist = "XTC") AND
      year < 1990
GROUP BY "**" + artist + "**"
```
````

Would list all albums by Yes or XTC released prior to 1990:

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE (artist = "Yes" OR artist = "XTC") AND
      year < 1990
GROUP BY "**" + artist + "**"
```

## See also

- [Dataview: __USERNSTR__ Index](Dataviews/__USERNAME___Dataviews.md)
- [Dataview: __USERNSTR__ Albums](Dataviews/__USERNAME___Albums.md)
- [Dataview: __USERNSTR__ Albums 1977](Dataviews/__USERNAME___Albums_1977.md)
- [Dataview: __USERNSTR__ Albums 70s](Dataviews/__USERNAME___Albums_70s.md)
- [Dataview: __USERNSTR__ Art Rock](Dataviews/__USERNAME___Art_Rock.md)
- [Dataview: __USERNSTR__ Progressive](Dataviews/__USERNAME___Progressive.md)
- [Dataview: __USERNSTR__ Reissue](Dataviews/__USERNAME___Reissue.md)
- [Index of the __USERNSTR__ Vault](__USERNAME___Index.md)
- [README](README.md)
- [Process](Process.md)

