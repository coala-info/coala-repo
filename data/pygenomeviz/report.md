# pygenomeviz CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pygenomeviz_pgv-download-dataset | PASS |  |
| pygenomeviz_pgv-gui | Not completed | GUI web server (Streamlit app), cannot be tested in a batch run |
| pygenomeviz_pgv-mmseqs | Failed | image problem: MMseqs is not installed in the image, so the tool stops with 'alignment is not available in this environment' |
| pygenomeviz_pgv-mummer | Failed | image problem: MUMmer is not installed in the image, so the tool stops with 'alignment is not available in this environment' |
| pygenomeviz_pgv-pmauve | Failed | image problem: progressiveMauve is not installed in the image, so the tool stops with 'alignment is not available in this environment' |
| pygenomeviz_pgv-simpleplot | PASS |  |

## pygenomeviz_pgv-gui

### Tool Description
Launch pyGenomeViz WebApp

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pyGenomeViz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Total Downloads**: 27.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moshi4/pyGenomeViz
- **Stars**: N/A
### Original Help Text
```text
usage: pgv-gui [-p] [-v] [-h]

Launch pyGenomeViz WebApp

options:
  -p , --port    Port number to open web browser (Default: 8501)
  -v, --version  Print version information
  -h, --help     Show this help message and exit
```

## pygenomeviz_pgv-simpleplot

### Tool Description
pyGenomeViz CLI utility for visualization workflow

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pyGenomeViz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgv-simpleplot --gbk_resources IN [IN ...] -o OUT [-v] [-h]
                      [--fig_width] [--fig_track_height]
                      [--feature_track_ratio] [--space_track_ratio]
                      [--tick_track_ratio] [--track_labelsize]
                      [--tick_labelsize] [--align_type] [--tick_style]
                      [--feature_plotstyle] [--arrow_shaft_ratio]
                      [--feature_color] [--feature_linewidth] [--dpi]

pyGenomeViz CLI utility for visualization workflow

General Options:
  --gbk_resources IN [IN ...]  Input genome genbank file resources
                               User can optionally specify genome range and reverse complement.
                               - Example1. Set 100 - 1000 range 'file:100-1000'
                               - Example2. Set reverse complement 'file::-1'
                               - Example3. Set 100 - 1000 range of reverse complement 'file:100-1000:-1'
  -o OUT, --outfile OUT        Output file ('*.png'|'*.jpg'|'*.svg'|'*.pdf'|'*.html')
  -v, --version                Print version information
  -h, --help                   Show this help message and exit

Figure Appearence Options:
  --fig_width                  Figure width (Default: 15)
  --fig_track_height           Figure track height (Default: 1.0)
  --feature_track_ratio        Feature track ratio (Default: 1.0)
  --space_track_ratio          Space (b/w feature) track ratio (Default: 2.0)
  --tick_track_ratio           Tick track ratio (Default: 1.0)
  --track_labelsize            Track label size (Default: 20)
  --tick_labelsize             Tick label size (Default: 15)
  --align_type                 Figure tracks align type ('left'[*]|'center'|'right')
  --tick_style                 Tick style ('bar'|'axis'|None[*])
  --feature_plotstyle          Feature plot style ('bigarrow'[*]|'arrow')
  --arrow_shaft_ratio          Feature arrow shaft ratio (Default: 0.5)
  --feature_color              Feature color (Default: 'orange')
  --feature_linewidth          Feature edge line width (Default: 0.0)
  --dpi                        Figure DPI (Default: 300)

[*] marker means the default value.
```

## pygenomeviz_pgv-mmseqs

### Tool Description
pyGenomeViz CLI utility for visualization workflow using MMseqs

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pyGenomeViz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgv-mmseqs --gbk_resources IN [IN ...] -o OUT [--format  [...]]
                  [--reuse] [-v] [-h] [-e] [--min_identity] [-t] [--fig_width]
                  [--fig_track_height] [--feature_track_ratio]
                  [--link_track_ratio] [--tick_track_ratio]
                  [--track_labelsize] [--tick_labelsize] [--normal_link_color]
                  [--inverted_link_color] [--align_type] [--tick_style]
                  [--feature_plotstyle] [--arrow_shaft_ratio]
                  [--feature_color] [--feature_linewidth] [--colorbar_width]
                  [--colorbar_height] [--curve] [--dpi]

pyGenomeViz CLI utility for visualization workflow using MMseqs

General Options:
  --gbk_resources IN [IN ...]  Input genome genbank file resources
                               User can optionally specify genome range and reverse complement.
                               - Example1. Set 100 - 1000 range 'file:100-1000'
                               - Example2. Set reverse complement 'file::-1'
                               - Example3. Set 100 - 1000 range of reverse complement 'file:100-1000:-1'
  -o OUT, --outdir OUT         Output directory
  --format  [ ...]             Output image format ('png'[*]|'jpg'|'svg'|'pdf'|`html`[*])
  --reuse                      Reuse previous result if available
  -v, --version                Print version information
  -h, --help                   Show this help message and exit

MMseqs Options:
  -e , --evalue                MMseqs RBH search E-value parameter (Default: 1e-03)
  --min_identity               Min-identity threshold to be plotted (Default: 0)
  -t , --thread_num            Threads number parameter (Default: MaxThread - 1)

Figure Appearence Options:
  --fig_width                  Figure width (Default: 15)
  --fig_track_height           Figure track height (Default: 1.0)
  --feature_track_ratio        Feature track ratio (Default: 1.0)
  --link_track_ratio           Link track ratio (Default: 5.0)
  --tick_track_ratio           Tick track ratio (Default: 1.0)
  --track_labelsize            Track label size (Default: 20)
  --tick_labelsize             Tick label size (Default: 15)
  --normal_link_color          Normal link color (Default: 'grey')
  --inverted_link_color        Inverted link color (Default: 'red')
  --align_type                 Figure tracks align type ('left'|'center'[*]|'right')
  --tick_style                 Tick style ('bar'|'axis'|None[*])
  --feature_plotstyle          Feature plot style ('bigarrow'[*]|'arrow')
  --arrow_shaft_ratio          Feature arrow shaft ratio (Default: 0.5)
  --feature_color              Feature color (Default: 'orange')
  --feature_linewidth          Feature edge line width (Default: 0.0)
  --colorbar_width             Colorbar width (Default: 0.01)
  --colorbar_height            Colorbar height (Default: 0.2)
  --curve                      Plot curved style link (Default: OFF)
  --dpi                        Figure DPI (Default: 300)

[*] marker means the default value.
```

## pygenomeviz_pgv-mummer

### Tool Description
pyGenomeViz CLI utility for visualization workflow using MUMmer

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pyGenomeViz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgv-mummer --gbk_resources IN [IN ...] -o OUT [--format  [...]]
                  [--reuse] [-v] [-h] [--seqtype] [--min_length]
                  [--min_identity] [-t] [--fig_width] [--fig_track_height]
                  [--feature_track_ratio] [--link_track_ratio]
                  [--tick_track_ratio] [--track_labelsize] [--tick_labelsize]
                  [--normal_link_color] [--inverted_link_color] [--align_type]
                  [--tick_style] [--feature_plotstyle] [--arrow_shaft_ratio]
                  [--feature_color] [--feature_linewidth] [--pseudo]
                  [--pseudo_color] [--colorbar_width] [--colorbar_height]
                  [--curve] [--dpi]

pyGenomeViz CLI utility for visualization workflow using MUMmer

General Options:
  --gbk_resources IN [IN ...]  Input genome genbank file resources
                               User can optionally specify genome range and reverse complement.
                               - Example1. Set 100 - 1000 range 'file:100-1000'
                               - Example2. Set reverse complement 'file::-1'
                               - Example3. Set 100 - 1000 range of reverse complement 'file:100-1000:-1'
  -o OUT, --outdir OUT         Output directory
  --format  [ ...]             Output image format ('png'[*]|'jpg'|'svg'|'pdf'|`html`[*])
  --reuse                      Reuse previous result if available
  -v, --version                Print version information
  -h, --help                   Show this help message and exit

MUMmer Alignment Options:
  --seqtype                    MUMmer alignment sequence type ('protein'[*]|'nucleotide')
  --min_length                 Min-length threshold to be plotted (Default: 0)
  --min_identity               Min-identity threshold to be plotted (Default: 0)
  -t , --thread_num            Threads number parameter (Default: MaxThread - 1)

Figure Appearence Options:
  --fig_width                  Figure width (Default: 15)
  --fig_track_height           Figure track height (Default: 1.0)
  --feature_track_ratio        Feature track ratio (Default: 1.0)
  --link_track_ratio           Link track ratio (Default: 5.0)
  --tick_track_ratio           Tick track ratio (Default: 1.0)
  --track_labelsize            Track label size (Default: 20)
  --tick_labelsize             Tick label size (Default: 15)
  --normal_link_color          Normal link color (Default: 'grey')
  --inverted_link_color        Inverted link color (Default: 'red')
  --align_type                 Figure tracks align type ('left'|'center'[*]|'right')
  --tick_style                 Tick style ('bar'|'axis'|None[*])
  --feature_plotstyle          Feature plot style ('bigarrow'[*]|'arrow')
  --arrow_shaft_ratio          Feature arrow shaft ratio (Default: 0.5)
  --feature_color              Feature color (Default: 'orange')
  --feature_linewidth          Feature edge line width (Default: 0.0)
  --pseudo                     Show pseudogene feature
  --pseudo_color               Pseudogene feature color (Default: 'grey')
  --colorbar_width             Colorbar width (Default: 0.01)
  --colorbar_height            Colorbar height (Default: 0.2)
  --curve                      Plot curved style link (Default: OFF)
  --dpi                        Figure DPI (Default: 300)

[*] marker means the default value.
```

## pygenomeviz_pgv-pmauve

### Tool Description
pyGenomeViz CLI utility for visualization workflow using progressiveMauve

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pyGenomeViz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgv-pmauve --seq_files IN [IN ...] -o OUT [--refid] [--format  [...]]
                  [--reuse] [-v] [-h] [--fig_width] [--fig_track_height]
                  [--feature_track_ratio] [--link_track_ratio]
                  [--tick_track_ratio] [--track_labelsize] [--tick_labelsize]
                  [--normal_link_color] [--inverted_link_color] [--align_type]
                  [--tick_style] [--plotstyle] [--cmap] [--curve] [--dpi]

pyGenomeViz CLI utility for visualization workflow using progressiveMauve

General Options:
  --seq_files IN [IN ...]  Input genome sequence files (Genbank or Fasta format)
  -o OUT, --outdir OUT     Output directory
  --refid                  Reference genome index (Default: 0)
  --format  [ ...]         Output image format ('png'[*]|'jpg'|'svg'|'pdf'|`html`[*])
  --reuse                  Reuse previous result if available
  -v, --version            Print version information
  -h, --help               Show this help message and exit

Figure Appearence options:
  --fig_width              Figure width (Default: 15)
  --fig_track_height       Figure track height (Default: 1.0)
  --feature_track_ratio    Feature track ratio (Default: 1.0)
  --link_track_ratio       Link track ratio (Default: 5.0)
  --tick_track_ratio       Tick track ratio (Default: 1.0)
  --track_labelsize        Track label size (Default: 20)
  --tick_labelsize         Tick label size (Default: 15)
  --normal_link_color      Normal link color (Default: 'grey')
  --inverted_link_color    Inverted link color (Default: 'tomato')
  --align_type             Figure tracks align type ('left'|'center'[*]|'right')
  --tick_style             Tick style ('bar'|'axis'|None[*])
  --plotstyle              Block box plot style ('box'[*]|'bigbox')
  --cmap                   Block box colormap (Default: 'hsv')
  --curve                  Plot curved style link (Default: OFF)
  --dpi                    Figure DPI (Default: 300)

[*] marker means the default value.
```

## pygenomeviz_pgv-download-dataset

### Tool Description
Download pyGenomeViz genbank dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pyGenomeViz/
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenomeviz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgv-download-dataset -n  [-o] [-v] [-h]

Download pyGenomeViz genbank dataset

options:
  -n , --name     Dataset name
  -o , --outdir   Output directory (Default: .)
  -v, --version   Print version information
  -h, --help      Show this help message and exit

Dataset name = ['escherichia_phage', 'erwinia_phage', 'enterobacteria_phage',
'escherichia_coli', 'mycoplasma_gallisepticum']
```
