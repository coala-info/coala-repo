# mindagap CWL Generation Report

## mindagap_mindagap.py

### Tool Description
Takes a single panorama image and fills the empty grid lines with neighbour-weighted values

### Metadata
- **Docker Image**: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/ViriatoII/MindaGap
- **Package**: https://anaconda.org/channels/bioconda/packages/mindagap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mindagap/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ViriatoII/MindaGap
- **Stars**: N/A
### Original Help Text
```text
usage: mindagap.py [-h] [-xt [XTILESIZE]] [-yt [YTILESIZE]] [-e [EDGES]]
                   [-v | --version | --no-version]
                   input [s] [r]

Takes a single panorama image and fills the empty grid lines with neighbour-
weighted values

positional arguments:
  input                 Input tif/png file with grid lines to fill
  s                     Box size for gaussian kernel (bigger better for big
                        gaps but less accurate)
  r                     Number of rounds to apply gaussianBlur (more is
                        better)

optional arguments:
  -h, --help            show this help message and exit
  -xt [XTILESIZE], --Xtilesize [XTILESIZE]
                        Tile size (distance between gridlines) on X axis
  -yt [YTILESIZE], --Ytilesize [YTILESIZE]
                        Tile size (distance between gridlines) on Y axis
  -e [EDGES], --edges [EDGES]
                        Also smooth edges near grid lines
  -v, --version, --no-version
                        Print version number. (default: False)
```


## mindagap_rgb_from_z_tiles.py

### Tool Description
Reads 3 3D tif files, extracts desired z layer and creates 3-channel RGB tiff image

### Metadata
- **Docker Image**: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/ViriatoII/MindaGap
- **Package**: https://anaconda.org/channels/bioconda/packages/mindagap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgb_from_z_tiles.py [-h] [-outdir [OUT]] [-r [RED]] [-g [GREEN]]
                           [-gp GREEN_PADDING] [-bp BLUE_PADDING]
                           [-corr CORRECT_ILUM] -b BLUE [-z [Z]]

Reads 3 3D tif files, extracts desired z layer and creates 3-channel RGB tiff
image

optional arguments:
  -h, --help            show this help message and exit
  -outdir [OUT], --out [OUT]
                        Output directory to save RGB tif files
  -r [RED], --red [RED]
                        WGA (cellwall stain) tif
  -g [GREEN], --green [GREEN]
                        Constructive signal tif
  -gp GREEN_PADDING, --green_padding GREEN_PADDING
                        Add X green layers around asked Z layer
  -bp BLUE_PADDING, --blue_padding BLUE_PADDING
                        Average X blue layers around asked Z layer
  -corr CORRECT_ILUM, --correct_ilum CORRECT_ILUM
                        Correct ilumination for Red channel. 1.0 to 3.0 for
                        fine tunning. 0 to turn off.

Mandatory named arguments:
  -b BLUE, --blue BLUE  DAPI tif
  -z [Z], --z [Z]       The desired Z layers to keep
```


## mindagap_duplicate_finder.py

### Tool Description
Takes a single XYZ_coordinates.txt file and searches for duplicates along grid happening at every 2144 pixels

### Metadata
- **Docker Image**: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/ViriatoII/MindaGap
- **Package**: https://anaconda.org/channels/bioconda/packages/mindagap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: duplicate_finder.py [-h] [-p PLOT]
                           input [Xtilesize] [Ytilesize] [windowsize]
                           [maxfreq] [minMode]

Takes a single XYZ_coordinates.txt file and searches for duplicates along grid
happening at every 2144 pixels

positional arguments:
  input                 Input gene xyz coordinates file
  Xtilesize             Tile size (distance between gridlines) on X axis
  Ytilesize             Tile size (distance between gridlines) on Y axis
  windowsize            Window arround gridlines to search for duplicates
  maxfreq               Maximum transcript count to calculate X/Y shifts
                        (better to discard very common genes)
  minMode               Minumum occurances of ~XYZ_shift to consider it valid

optional arguments:
  -h, --help            show this help message and exit
  -p PLOT, --plot PLOT  Illustrative lineplot of duplicated pairs with
                        annotated XYZ shift per tileOvlap
```

