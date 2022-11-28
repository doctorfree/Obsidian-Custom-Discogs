---
banner: "assets/banners/Dataview-Banner.png"
banner_x: 1.0
banner_y: 1.0
---

# All Discogs Albums

This code displays all albums from the __USERNAME__ folder sorted by artist.

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "A")
GROUP BY "**" + artist + "**"
```
````

Or, for artists whose name does not start with A-Z,

````markdown
```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      regexmatch("^(?![a-z]).+", lower(artist))
GROUP BY "**" + artist + "**"
```
````

## Navigation

| **[A](#a)** | **[B](#b)** | **[C](#c)** | **[D](#d)** | **[E](#e)** | **[F](#f)** | **[G](#g)** | **[H](#h)** | **[I](#i)** | **[J](#j)** | **[K](#k)** | **[L](#l)** | **[M](#m)** | **[N](#n)** | **[O](#o)** | **[P](#p)** | **[Q](#q)** | **[R](#r)** | **[S](#s)** | **[T](#t)** | **[U](#u)** | **[V](#v)** | **[W](#w)** | **[X](#x)** | **[Y](#y)** | **[Z](#z)** |
|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|


## 0-9+

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      regexmatch("^(?![a-z]).+", lower(artist))
GROUP BY "**" + artist + "**"
```

## A

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "A")
GROUP BY "**" + artist + "**"
```

## B

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "B")
GROUP BY "**" + artist + "**"
```

## C

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "C")
GROUP BY "**" + artist + "**"
```

## D

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "D")
GROUP BY "**" + artist + "**"
```

## E

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "E")
GROUP BY "**" + artist + "**"
```

## F

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "F")
GROUP BY "**" + artist + "**"
```

## G

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "G")
GROUP BY "**" + artist + "**"
```

## H

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "H")
GROUP BY "**" + artist + "**"
```

## I

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "I")
GROUP BY "**" + artist + "**"
```

## J

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "J")
GROUP BY "**" + artist + "**"
```

## K

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "K")
GROUP BY "**" + artist + "**"
```

## L

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "L")
GROUP BY "**" + artist + "**"
```

## M

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "M")
GROUP BY "**" + artist + "**"
```

## N

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "N")
GROUP BY "**" + artist + "**"
```

## O

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "O")
GROUP BY "**" + artist + "**"
```

## P

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "P")
GROUP BY "**" + artist + "**"
```

## Q

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "Q")
GROUP BY "**" + artist + "**"
```

## R

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "R")
GROUP BY "**" + artist + "**"
```

## S

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "S")
GROUP BY "**" + artist + "**"
```

## T

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "T")
GROUP BY "**" + artist + "**"
```

## U

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "U")
GROUP BY "**" + artist + "**"
```

## V

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "V")
GROUP BY "**" + artist + "**"
```

## W

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "W")
GROUP BY "**" + artist + "**"
```

## X

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "X")
GROUP BY "**" + artist + "**"
```

## Y

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "Y")
GROUP BY "**" + artist + "**"
```

## Z

```dataview
LIST link(rows.file.link, rows.title)
FROM "__USERNAME__"
WHERE artist != null AND
      title != null AND
      startswith(upper(artist), "Z")
GROUP BY "**" + artist + "**"
```
