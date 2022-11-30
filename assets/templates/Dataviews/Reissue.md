---
banner: "assets/banners/Vinyl-Banner.png"
banner_x: 0.5
banner_y: 0.5
---

# Reissue Albums

This code displays reissued albums from the __USERNAME__ folder sorted by artist. The dataview queries look like the following:

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      contains(formats, "Reissue")
GROUP BY "**" + artist + "**"
```
````

## Reissue Albums

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      contains(formats, "Reissue")
GROUP BY "**" + artist + "**"
```
