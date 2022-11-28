---
banner: "assets/banners/Dataview-Banner.png"
banner_x: 1.0
banner_y: 1.0
---

# Discogs Progressive Albums

This code displays all albums in a progressive genre from the __USERNAME__ folder with a release year sorted by year.

````markdown
```dataview
TABLE WITHOUT ID
  artist AS "Artist",
  link(file.link, title) as Album,
  genres AS "Genres",
  year AS "Year"
FROM "__USERNAME__"
WHERE year > 0 AND contains(genres, "Prog")
SORT year ASC
```
````

Output of above code:

```dataview
TABLE WITHOUT ID
  artist AS "Artist",
  link(file.link, title) as Album,
  genres AS "Genres",
  year AS "Year"
FROM "__USERNAME__"
WHERE year > 0 AND contains(genres, "Prog")
SORT year ASC
```

As a list sorted by artist:

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE contains(genres, "Prog Rock")
GROUP BY "**" + artist + "**"
```
````

Produces:

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE contains(genres, "Prog Rock")
GROUP BY "**" + artist + "**"
```
