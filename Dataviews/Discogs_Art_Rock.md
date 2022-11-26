---
banner: "assets/banners/Vinyl-Banner.png"
banner_x: 0.5
banner_y: 0.5
---

# Discogs Art Rock Albums

This code displays art rock albums in the __USERNAME__ folder sorted by artist. The dataview query look like the following:

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      contains(genres, "Art")
GROUP BY "**" + artist + "**"
```
````

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      contains(genres, "Art")
GROUP BY "**" + artist + "**"
```
