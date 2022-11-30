---
banner: "assets/banners/Dataview-Banner.png"
banner_x: 1.0
banner_y: 1.0
---

# Dataview Queries

The Obsidian Discogs Vault markdown contains metadata with tags allowing a variety of queries using the [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) plugin for [Obsidian](https://obsidian.md/). Example Dataview queries are detailed below. Several more Dataview queries are auto-generated during the `Setup` process and can be found in the `Dataviews` folder after initialization with `Setup`.

## Table of Contents

- [Table of Albums Released after 2000](#table)
- [List of Albums Released after 2000](#list)
- [See also](#see_also)

## Example Dataview Queries

Included here are [several examples](Dataviews/Dataviews.md) of utilizing the Obsidian Dataview plugin to make dynamic queries into a vault. The results of these queries will automatically update when the vault is modified. A few lines of code can produce complex queries with detailed results. It takes a bit of study to learn the Dataview plugin but it is worth it. Hopefully these examples will serve as good starting points in that learning process.

### Example Dataview Query

Generated markdown for albums in a Discogs user collectin or local music library contains a YAML format metadata prelude. Metadata properties defined in this prelude can be used to filter the Obsidian vault items using the Dataview plugin.

For example, the markdown for "Fragile" by Yes has the following YAML prelude:

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

### Table

The album metadata can be used to perform Dataview queries to search, filter, and retrieve albums as if they are in a database. For example, to produce a table of all albums in this vault released after 2000, add the following to a markdown file in the vault:

````markdown
```dataview
TABLE WITHOUT ID
  link(file.link, title) as Album,
  artist AS "Artist",
  year AS "Year"
FROM ""
WHERE year > 2000
SORT year ASC
```
````

The above Dataview code block produces the following output:

```dataview
TABLE WITHOUT ID
  link(file.link, title) as Album,
  artist AS "Artist",
  year AS "Year"
FROM ""
WHERE year > 2000
SORT year ASC
```

### List

As a list grouped by artist rather than a table, the following dataview codeblock:

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM ""
WHERE year > 2000
GROUP BY "**" + artist + "**"
```
````

Would list all albums released after 2000:

```dataview
LIST link(rows.file.link, rows.title)
FROM ""
WHERE year > 2000
GROUP BY "**" + artist + "**"
```

## See_also

- [README](README.md)
- [Process](Process.md)
