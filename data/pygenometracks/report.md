# pygenometracks CWL Generation Report

## pygenometracks_make_tracks_file

### Tool Description
Facilitates the creation of a configuration file for pyGenomeTracks. The program takes a list of files and does the boilerplate for the configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenometracks:3.9--pyhdfd78af_0
- **Homepage**: //github.com/maxplanck-ie/pyGenomeTracks
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenometracks/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pygenometracks/overview
- **Total Downloads**: 86.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: make_tracks_file --trackFiles <bigwig file> <bed file> etc. -o tracks.ini

Facilitates the creation of a configuration file for pyGenomeTracks. The
program takes a list of files and does the boilerplate for the configuration
file.

options:
  -h, --help            show this help message and exit
  --trackFiles TRACKFILES [TRACKFILES ...], -f TRACKFILES [TRACKFILES ...]
                        Files to use in for the tracks. The ending of the file
                        is used to define the type of track. E.g. `.bw` for
                        bigwig, `.bed` for bed etc. For a arcs or links file,
                        the file ending recognized is `.arcs` or `.links`
                        (default: None)
  --out output file, -o output file
                        File to save the tracks (default: None)
  --version             show program's version number and exit
```


## pygenometracks_pyGenomeTracks

### Tool Description
Plots genomic tracks on specified region(s). Citations : Ramirez et al. High-resolution TADs reveal DNA sequences underlying genome organization in flies. Nature Communications (2018) doi:10.1038/s41467-017-02525-w Lopez-Delisle et al. pyGenomeTracks: reproducible plots for multivariate genomic datasets. Bioinformatics (2020) doi:10.1093/bioinformatics/btaa692

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenometracks:3.9--pyhdfd78af_0
- **Homepage**: //github.com/maxplanck-ie/pyGenomeTracks
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenometracks/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyGenomeTracks --tracks tracks.ini --region chr1:1000000-4000000 -o image.png

Plots genomic tracks on specified region(s). Citations : Ramirez et al. High-
resolution TADs reveal DNA sequences underlying genome organization in flies.
Nature Communications (2018) doi:10.1038/s41467-017-02525-w Lopez-Delisle et
al. pyGenomeTracks: reproducible plots for multivariate genomic datasets.
Bioinformatics (2020) doi:10.1093/bioinformatics/btaa692

options:
  -h, --help            show this help message and exit
  --tracks TRACKS       File containing the instructions to plot the tracks.
                        The tracks.ini file can be genarated using the
                        `make_tracks_file` program.
  --region REGION       Region to plot, the format is chr:start-end
  --BED BED             Instead of a region, a file containing the regions to
                        plot, in BED format, can be given. If this is the
                        case, multiple files will be created. It will use the
                        value of --outFileName as a template and put the
                        coordinates between the file name and the extension.
  --width WIDTH         figure width in centimeters (default is 40)
  --plotWidth PLOTWIDTH
                        width in centimeters of the plotting (central) part
  --height HEIGHT       Figure height in centimeters. If not given, the figure
                        height is computed based on the heights of the tracks.
                        If given, the track height are proportionally scaled
                        to match the desired figure height.
  --title TITLE, -t TITLE
                        Plot title
  --outFileName OUTFILENAME, -out OUTFILENAME
                        File name to save the image, file prefix in case
                        multiple images are stored
  --fontSize FONTSIZE   Font size for the labels of the plot (default is 0.3 *
                        figure width)
  --dpi DPI             Resolution for the image in case the ouput is a raster
                        graphics image (e.g png, jpg) (default is 72)
  --trackLabelFraction TRACKLABELFRACTION
                        By default the space dedicated to the track labels is
                        0.05 of the plot width. This fraction can be changed
                        with this parameter if needed.
  --trackLabelHAlign {left,right,center}
                        By default, the horizontal alignment of the track
                        labels is left. This alignemnt can be changed to right
                        or center.
  --decreasingXAxis     By default, the x-axis is increasing. Use this option
                        if you want to see all tracks with a decreasing
                        x-axis.
  --version             show program's version number and exit
```


## Metadata
- **Skill**: not generated
