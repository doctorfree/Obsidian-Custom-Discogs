---
banner: "assets/banners/Dataview-Banner.png"
banner_x: 1.0
banner_y: 1.0
---

# Discogs Progressive Rock Albums

This code displays all albums in a progressive genre from the __USERNAME__ folder with a release year sorted by year.

````markdown
```dataview
TABLE WITHOUT ID
  artist AS "Artist",
  link(file.link, album) as Album,
  genres AS "Genres",
  year AS "Year"
FROM "__USERNAME__"
WHERE artist != null AND album != null AND year > 0 AND contains(genres, "Prog")
SORT year ASC
```
````

Output of above code:

```dataview
TABLE WITHOUT ID
  artist AS "Artist",
  link(file.link, album) as Album,
  genres AS "Genres",
  year AS "Year"
FROM "__USERNAME__"
WHERE artist != null AND album != null AND year > 0 AND contains(genres, "Prog")
SORT year ASC
```
