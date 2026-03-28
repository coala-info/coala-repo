[ ]
[ ]

[Skip to content](#plotting-capcruncher-output)

CapCruncher Documentation

Plotting CapCruncher output

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](..)
* [Installation](../installation/)
* [Pipeline](../pipeline/)
* [Cluster Setup](../cluster_config/)
* [Hints and Tips](../tips/)
* [ ]

  Plotting CapCruncher output

  [Plotting CapCruncher output](./)

  Table of contents
  + [Introduction](#introduction)
  + [Imports](#imports)
  + [Read plotting coordinates](#read-plotting-coordinates)
  + [Plot using the CapCruncher API](#plot-using-the-capcruncher-api)
  + [Create new objects](#create-new-objects)

    - [Option 1: Create a list of objects and pass them to CCFigure](#option-1-create-a-list-of-objects-and-pass-them-to-ccfigure)
    - [Option 2: Create a object and add tracks to it](#option-2-create-a-object-and-add-tracks-to-it)
  + [Plot the figure (Optional)](#plot-the-figure-optional)
  + [Save the figure](#save-the-figure)

    - [Option 1: Save the figure to a file](#option-1-save-the-figure-to-a-file)
    - [Option 2: Save the figure as a template](#option-2-save-the-figure-as-a-template)
* [CLI Reference](../cli/)
* [ ]

  API Reference

  API Reference
  + [ ]

    capcruncher

    capcruncher
    - [ ]

      api

      api
      * [annotate](../reference/capcruncher/api/annotate/)
      * [deduplicate](../reference/capcruncher/api/deduplicate/)
      * [filter](../reference/capcruncher/api/filter/)
      * [io](../reference/capcruncher/api/io/)
      * [pileup](../reference/capcruncher/api/pileup/)
      * [plotting](../reference/capcruncher/api/plotting/)
      * [statistics](../reference/capcruncher/api/statistics/)
      * [storage](../reference/capcruncher/api/storage/)

Table of contents

* [Introduction](#introduction)
* [Imports](#imports)
* [Read plotting coordinates](#read-plotting-coordinates)
* [Plot using the CapCruncher API](#plot-using-the-capcruncher-api)
* [Create new objects](#create-new-objects)

  + [Option 1: Create a list of objects and pass them to CCFigure](#option-1-create-a-list-of-objects-and-pass-them-to-ccfigure)
  + [Option 2: Create a object and add tracks to it](#option-2-create-a-object-and-add-tracks-to-it)
* [Plot the figure (Optional)](#plot-the-figure-optional)
* [Save the figure](#save-the-figure)

  + [Option 1: Save the figure to a file](#option-1-save-the-figure-to-a-file)
  + [Option 2: Save the figure as a template](#option-2-save-the-figure-as-a-template)

# Plotting CapCruncher output[¶](#plotting-capcruncher-output)

## Introduction[¶](#introduction)

This is a quick overview of the plotting functionality of CapCruncher. Please ensure that you have installed the optional dependencies for CapCruncher by running:

```
pip install capcruncher[full]
```

## Imports[¶](#imports)

In [1]:

Copied!

```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import coolbox.api as cb
from capcruncher.api.plotting import CCTrack, CCFigure
import pyranges as pr
```

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import coolbox.api as cb
from capcruncher.api.plotting import CCTrack, CCFigure
import pyranges as pr

## Read plotting coordinates[¶](#read-plotting-coordinates)

In [2]:

Copied!

```
viewpoints = pr.read_bed("alpha_tile_mm9.bed")
viewpoints
```

viewpoints = pr.read\_bed("alpha\_tile\_mm9.bed")
viewpoints

Out[2]:

|  | Chromosome | Start | End | Name |
| --- | --- | --- | --- | --- |
| 0 | chr11 | 29902950 | 33226736 | Alpha |

## Plot using the CapCruncher API[¶](#plot-using-the-capcruncher-api)

First create a number of `CCTrack` instances supported track types:

* heatmap - a contact matrix heatmap in cool format
* bigwig - a bigwig file containing the number of reads per bin
* bigwig\_summary - a collection of bigwig files containing the number of reads per bin
* scale - a scale bar. Does not require a file to be specified
* bed - a bed file
* xaxis - an x-axis of genomic coordinates. Does not require a file to be specified
* genes - a gene track in bed12 format
* spacer - a spacer track. Does not require a file to be specified

## Create new `CCTrack` objects[¶](#create-new-cctrack-objects)

### Option 1: Create a list of `CCTrack` objects and pass them to CCFigure[¶](#option-1-create-a-list-of-cctrack-objects-and-pass-them-to-ccfigure)

In [3]:

Copied!

```
tracks = [
    CCTrack(None, type="scale"),
    CCTrack(
        "capcruncher_output/results/WT_FL_S3_Replicate1/WT_FL_S3_Replicate1.hdf5",
        type="heatmap",
        binsize=2000,
        title="Alpha Tile",
        viewpoint="Alpha",
        normalization="ice",
        transform="yes",
        style="triangular",
    ),
    CCTrack(None, type="spacer"),
    CCTrack(None, type="spacer"),
    CCTrack(None, type="xaxis"),
]

fig = CCFigure(tracks, auto_spacing=False)
```

tracks = [
CCTrack(None, type="scale"),
CCTrack(
"capcruncher\_output/results/WT\_FL\_S3\_Replicate1/WT\_FL\_S3\_Replicate1.hdf5",
type="heatmap",
binsize=2000,
title="Alpha Tile",
viewpoint="Alpha",
normalization="ice",
transform="yes",
style="triangular",
),
CCTrack(None, type="spacer"),
CCTrack(None, type="spacer"),
CCTrack(None, type="xaxis"),
]
fig = CCFigure(tracks, auto\_spacing=False)

### Option 2: Create a `CCFigure` object and add tracks to it[¶](#option-2-create-a-ccfigure-object-and-add-tracks-to-it)

As this would overwrite the previous figure, we will create a new figure and add the tracks to it.

In [4]:

Copied!

```
fig2 = CCFigure(tracks, auto_spacing=False)
fig2.add_track(CCTrack(None, type="scale"))
```

fig2 = CCFigure(tracks, auto\_spacing=False)
fig2.add\_track(CCTrack(None, type="scale"))

## Plot the figure (Optional)[¶](#plot-the-figure-optional)

In [5]:

Copied!

```
# Plot a specific region if desired
fig.plot("chr11:29902950-33226736")
```

# Plot a specific region if desired
fig.plot("chr11:29902950-33226736")

Out[5]:

![No description has been provided for this image](data:image/png;base64...)

## Save the figure[¶](#save-the-figure)

Two options:

1. Save the figure as a static image using the save method of the `CCFigure`.
2. Save the `CCFigure` as a TOML file which can be edited and either reloaded into a `CCFigure` or used by the command line interface to generate a new figure using `capcruncher plot make-plot`.

### Option 1: Save the figure to a file[¶](#option-1-save-the-figure-to-a-file)

In [6]:

Copied!

```
fig.save("chr11:29902950-33226736", output="test.png")
```

fig.save("chr11:29902950-33226736", output="test.png")

### Option 2: Save the figure as a template[¶](#option-2-save-the-figure-as-a-template)

In [7]:

Copied!

```
fig.to_toml(output="template.toml")
```

fig.to\_toml(output="template.toml")

This will look something like this:

In [21]:

Copied!

```
!head -n 15 template.toml
```

!head -n 15 template.toml

```
["scale 0"]
type = "scale"

["spacer 0"]
type = "spacer"

["spacer 1"]
type = "spacer"

["Alpha Tile"]
type = "heatmap"
binsize = 2000
title = "Alpha Tile"
viewpoint = "Alpha"
normalization = "ice"
```

This template can be re-loaded using the CapCruncher package e.g. using the `CCFigure.from_toml` method. You can also add new tracks to the figure and re-plot it.

See this rather contrived example of reloading the figure and adding a new scale bar to it.

In [14]:

Copied!

```
fig = CCFigure.from_toml("template.toml")
fig.add_track(CCTrack(None, type="scale"))
fig.plot("chr11:29902950-33226736")
```

fig = CCFigure.from\_toml("template.toml")
fig.add\_track(CCTrack(None, type="scale"))
fig.plot("chr11:29902950-33226736")

Out[14]:

![No description has been provided for this image](data:image/png;base64...)

Alternatively the template can be edited and used on the commandline with `capcruncher plot` e.g.

In [18]:

Copied!

```
%%bash
capcruncher \
plot \
--template template.toml \
--region chr11:29902950-33226736 \
-o test.png
```

%%bash
capcruncher \
plot \
--template template.toml \
--region chr11:29902950-33226736 \
-o test.png

This will generate the same figure as before:

![plot](./test.png)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)