---
banner: "assets/banners/Dataview-Banner.png"
banner_x: 1.0
banner_y: 1.0
---

# Albums released in 1970s

This code displays all albums from the __USERNAME__ folder released in the 70s sorted by year.

````markdown
```dataview
TABLE WITHOUT ID
  artist AS "Artist",
  link(file.link, title) as Album,
  genres AS "Genres",
  year AS "Year"
FROM "__USERNAME__"
WHERE artist != null AND title != null AND year > 1969 AND year < 1980
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
WHERE artist != null AND title != null AND year > 1969 AND year < 1980
SORT year ASC
```
