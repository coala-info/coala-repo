# trackplot CWL Generation Report

## trackplot

### Tool Description
Welcome to use trackplot

### Metadata
- **Docker Image**: quay.io/biocontainers/trackplot:0.5.7--pyhdfd78af_0
- **Homepage**: https://github.com/ygidtu/trackplot
- **Package**: https://anaconda.org/channels/bioconda/packages/trackplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trackplot/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/ygidtu/trackplot
- **Stars**: N/A
### Original Help Text
```text
Usage: trackplot [OPTIONS]

  Welcome to use trackplot

Options:
  --version                       Show the version and exit.
  --verbose                       enable debug level log
  --logfile PATH                  save log info into file
  -e, --event TEXT                Event range eg: chr1:100-200:+
  Common input files configuration: 
    --color-factor INTEGER RANGE  Index of column with color levels (1-based);
                                  NOTE: LUAD|red -> LUAD while be labeled in
                                  plots and red while be the fill color
                                  [default: 1; x>=1]
    --barcode PATH                Path to barcode list file, At list two
                                  columns were required, - 1st The name of bam
                                  file, not the alias of bam;
                                  
                                  - 2nd the barcode;
                                  
                                  - 3rd The group label, optional;
                                  
                                  - 4th The color of each cell type, default
                                  using the color of corresponding bam file.
    --barcode-tag TEXT            The default cell barcode tag label
                                  [default: CB]
    --umi-tag TEXT                The default UMI barcode tag label  [default:
                                  UB]
    -p, --process INTEGER RANGE   How many cpu to use  [1<=x<=20]
    --group-by-cell               Group by cell types in density/line plot
    --remove-duplicate-umi        Drop duplicated UMIs by barcode
    --normalize-format [count|cpm|rpkm]
                                  The normalize format for bam file  [default:
                                  count]
  Output settings: 
    -o, --output PATH             Path to output graph file
    -d, --dpi INTEGER RANGE       The resolution of output file  [default:
                                  300; x>=1]
    --raster                      The would convert heatmap and site plot to
                                  raster image (speed up rendering and produce
                                  smaller files), only affects pdf, svg and PS
    --height FLOAT                The height of single subplot, default adjust
                                  image height by content  [default: 1]
    --width INTEGER RANGE         The width of output file, default adjust
                                  image width by content  [default: 10; x>=0]
    --backend TEXT                Recommended backend  [default: Agg]
  Reference settings: 
    -r, --annotation PATH         Path to gtf file, both transcript and exon
                                  tags are necessary
    --interval PATH               Path to list of interval files in bed
                                  format, 1st column is path to file, 2nd
                                  column is the label [optional]
    --show-id                     Whether show gene id or gene name
    --show-exon-id                Whether show gene id or gene name
    --no-gene                     Do not show gene id next to transcript id
    --domain                      Add domain information into annotation track
    --proxy TEXT                  The http or https proxy for EBI/Uniprot
                                  requests,if `--domain` is True, eg:
                                  http://127.0.0.1:1080
    --timeout INTEGER RANGE       The requests timeout when `--domain` is
                                  True.  [default: 10; x>=1]
    --local-domain TEXT           Load local domain folder and load into
                                  annotation track, download from https://hgdo
                                  wnload.soe.ucsc.edu/gbdb/hg38/uniprot/
                                  [default: ""]
    --domain-include TEXT         Which domain will be included in annotation
                                  plot
    --domain-exclude TEXT         Which domain will be excluded in annotation
                                  plot
    --remove-empty                Whether to plot empty transcript
    --transcripts-to-show TEXT    Which transcript to show, transcript name or
                                  id in gtf file, eg: transcript1,transcript2
                                  [default: ""]
    --choose-primary              Whether choose primary transcript to plot.
    --ref-color TEXT              The color of exons  [default: black]
    --intron-scale FLOAT          The scale of intron  [default: 0.5]
    --exon-scale FLOAT            The scale of exon  [default: 1]
  Density plot settings: 
    --density PATH                The path to list of input files, a tab
                                  separated text file,
                                  
                                  - 1st column is path to input file,
                                  
                                  - 2nd column is the file category,
                                  
                                  - 3rd column is input file alias (optional),
                                  
                                  - 4th column is color of input files
                                  (optional),
                                  
                                  - 5th column is the library of input file
                                  (optional, only required by bam file),
                                  
                                  - 6th column is the number of total reads
                                  (optional, only required by bam file).
    --customized-junction TEXT    Path to junction table column name needs to
                                  be bam name or bam alias.
    --only-customized-junction    Only used customized junctions.
    -t, --threshold INTEGER RANGE
                                  Threshold to filter low abundance junctions
                                  [default: 0; x>=0]
    --density-by-strand           Whether to draw density plot by strand
    --show-site                   Whether to draw additional site plot
    --site-strand [all|+|-]       Which strand kept for site plot, default use
                                  all  [default: all]
    --included-junctions TEXT     The junction id for including, chr1:1-100
    --show-junction-num           Whether to show the number of junctions
    --show-mean-junction-num      Whether to show the mean junction count
                                  averaged across multiple samples.
    --fill-step [pre|post|mid]    Define step if the filling should be a step
                                  function, i.e. constant in between x.  The
                                  value determines where the step will occur:
                                  
                                  - pre: The y value is continued constantly
                                  to the left from every x position,  i.e. the
                                  interval (x[i-1], x[i]] has the value y[i].
                                  
                                  - post: The y value is continued constantly
                                  to the right from every x position,  i.e.
                                  the interval [x[i], x[i+1]) has the value
                                  y[i].
                                  
                                  - mid: Steps occur half-way between the x
                                  positions."  [default: post]
    --smooth-bin INTEGER          The bin size used to smooth ATAC fragments.
                                  [default: 20]
    --sc-density-height-ratio FLOAT
                                  The relative height of single cell density
                                  plots  [default: 1]
  Line plot settings: 
    --line PATH                   The path to list of input files, a tab
                                  separated text file,
                                  
                                  - 1st column is path to input file,
                                  
                                  - 2nd column is the file category,
                                  
                                  - 3rd column is input file group (optional),
                                  
                                  - 4th column is input file alias (optional),
                                  
                                  - 5th column is color platte of
                                  corresponding group (optional). - 6th column
                                  is the number of total reads (optional, only
                                  required by bam file).
    --hide-legend                 Whether to hide legend
    --legend-position TEXT        The legend position
    --legend-ncol INTEGER RANGE   The number of columns of legend  [x>=0]
  Heatmap plot settings: 
    --heatmap PATH                The path to list of input files, a tab
                                  separated text file,
                                  
                                  - 1st column is path to input file,
                                  
                                  - 2nd column is the file category,
                                  
                                  - 3rd column is input file group (optional),
                                  
                                  - 4th column is color platte of
                                  corresponding group. - 5th column is the
                                  number of total reads (optional, only
                                  required by bam file).
    --clustering                  Enable clustering of the heatmap
    --clustering-method [single|complete|average|weighted|centroid|median|ward]
                                  The clustering method for heatmap  [default:
                                  ward]
    --distance-metric [braycurtis|canberra|chebyshev|cityblock|correlation|cosine|dice|euclidean|hamming|jaccard|jensenshannon|kulsinski|kulczynski1|mahalanobis|matching|minkowski|rogerstanimoto|russellrao|seuclidean|sokalmichener|sokalsneath|sqeuclidean|yule]
                                  The distance metric for heatmap  [default:
                                  euclidean]
    --heatmap-scale               Do scale on heatmap matrix.
    --heatmap-vmin INTEGER        Minimum value to anchor the colormap,
                                  otherwise they are inferred from the data.
    --heatmap-vmax INTEGER        Maximum value to anchor the colormap,
                                  otherwise they are inferred from the data.
    --show-row-names              Show row names of heatmap
    --sc-heatmap-height-ratio FLOAT
                                  The relative height of single cell heatmap
                                  plots  [default: 0.2]
  IGV settings: 
    --igv PATH                    The path to list of input files, a tab
                                  separated text file,
                                  
                                  - 1st column is path to input file,
                                  
                                  - 2nd column is the file category,
                                  
                                  - 3rd column is input file alias (optional),
                                  
                                  - 4th column is color of input files
                                  (optional),
                                  
                                  - 5th column is exon_id for sorting the
                                  reads (optional).
    --m6a TEXT                    trackplot will load location information
                                  from the given tags and  then highlight the
                                  RNA m6a modification cite at individual
                                  reads.  If there are multiple m6a
                                  modification site, please add tag as follow,
                                  234423,234450
    --polya TEXT                  trackplot will load length of poly(A) from
                                  the given tags and then visualize the
                                  poly(A) part at end of each individual
                                  reads.
    --rs TEXT                     trackplot will load real strand information
                                  of each reads from the given tags and
                                  
                                   the strand information is necessary for
                                   visualizing poly(A) part.
    --del-ratio-ignore FLOAT RANGE
                                  Ignore the deletion gap in nanopore or
                                  pacbio reads.
                                  
                                  if a deletion region was smaller than
                                  (alignment length) * (del_ratio_ignore),
                                  
                                  then the deletion gap will be filled.
                                  
                                  currently the del_ratio_ignore was 1.0.
                                  [0.0<=x<=1.0]
  HiC settings: 
    --hic PATH                    The path to list of input files, a tab
                                  separated text file,
                                  
                                  - 1st column is path to input file,
                                  
                                  - 2nd column is the file category,
                                  
                                  - 3rd column is input file alias (optional),
                                  
                                  - 4th column is color of input files
                                  (optional),
                                  
                                  - 5th column is data transform for HiC
                                  matrix, eg 0, 2, 10 (optional). Same to
                                  `--log`
  Additional annotation: 
    -f, --genome PATH             Path to genome fasta
    --sites TEXT                  Where to plot additional indicator lines,
                                  comma separated int
    --stroke TEXT                 The stroke regions:
                                  start1-end1:start2-end2@color-label, draw a
                                  stroke line at bottom, default color is red
    --link TEXT                   The link: start1-end1:start2-end2@color,
                                  draw a link between two site at bottom,
                                  default color is blue
    --focus TEXT                  The highlight regions: 100-200:300-400
  Motif settings: 
    --motif PATH                  The path to customized bedGraph file, first
                                  three columns is chrom, start and end site,
                                  the following 4 columns is the weight of
                                  ATCG.
    --motif-region TEXT           The region of motif to plot in start-end
                                  format  [default: ""]
    --motif-width FLOAT           The width of ATCG characters  [default: 0.8]
  Layout settings: 
    --n-y-ticks INTEGER RANGE     The number of ticks of y-axis  [x>=0]
    --distance-ratio FLOAT        The distance between transcript label and
                                  transcript line  [default: 0]
    --annotation-scale FLOAT      The size of annotation plot in final plot
                                  [default: 0.25]
    --stroke-scale FLOAT          The size of stroke plot in final image
                                  [default: 0.25]
  Overall settings: 
    --font-size INTEGER RANGE     The font size of x, y-axis and so on  [x>=1]
    --reverse-minus               Whether to reverse strand of bam/annotation
                                  file
    --hide-y-label                Whether hide y-axis label
    --same-y                      Whether different density/line plots shared
                                  same y-axis boundaries
    --same-y-sc                   Similar with --same-y, but only shared same
                                  y-axis boundaries between same single cell
                                  files
    --same-y-by-groups PATH       Set groups for --same-y, this parameter is
                                  path to a file with 2 columns,  - 1st is the
                                  label to specific input, - 2nd the the group
                                  labels - the input files not listed will use
                                  the global y limits
    --y-limit PATH                Manully set the y limit for all plots
                                  supported, this parameter is path to a file
                                  with 3 columns, - 1st is the label to
                                  specific input, - 2nd the maximum y - 3rd
                                  the minimum y - the input files not listed
                                  will use the default
    --log [0|2|10|zscore]         y axis log transformed, 0 -> not log
                                  transform;2 -> log2;10 -> log10
    --title TEXT                  Title
    --font TEXT                   Fonts
  Web settings: 
    --start-server                Start web ui instead of running in cmd mode
    --host TEXT                   The ip address binding to
    --port INTEGER                The port to listen on
    --plots PATH                  The path to directory where to save the
                                  backend plot data and logs, required while
                                  using appImage.
    --data PATH                   The path to directory contains all necessary
                                  data files.
  -h, --help                      Show this message and exit.
```

