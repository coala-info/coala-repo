cwlVersion: v1.2
class: CommandLineTool
baseCommand: trackplot
label: trackplot
doc: "Welcome to use trackplot\n\nTool homepage: https://github.com/ygidtu/trackplot"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Path to gtf file
    inputBinding:
      position: 101
      prefix: --annotation
  - id: annotation_scale
    type:
      - 'null'
      - float
    doc: The size of annotation plot in final plot
    inputBinding:
      position: 101
      prefix: --annotation-scale
  - id: backend
    type:
      - 'null'
      - string
    doc: Recommended backend
    inputBinding:
      position: 101
      prefix: --backend
  - id: barcode
    type:
      - 'null'
      - File
    doc: Path to barcode list file
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: The default cell barcode tag label
    inputBinding:
      position: 101
      prefix: --barcode-tag
  - id: choose_primary
    type:
      - 'null'
      - boolean
    doc: Whether choose primary transcript to plot
    inputBinding:
      position: 101
      prefix: --choose-primary
  - id: clustering
    type:
      - 'null'
      - boolean
    doc: Enable clustering of the heatmap
    inputBinding:
      position: 101
      prefix: --clustering
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: The clustering method for heatmap
    inputBinding:
      position: 101
      prefix: --clustering-method
  - id: color_factor
    type:
      - 'null'
      - int
    doc: Index of column with color levels (1-based)
    inputBinding:
      position: 101
      prefix: --color-factor
  - id: customized_junction
    type:
      - 'null'
      - File
    doc: Path to junction table
    inputBinding:
      position: 101
      prefix: --customized-junction
  - id: data
    type:
      - 'null'
      - Directory
    doc: The path to directory contains all necessary data files
    inputBinding:
      position: 101
      prefix: --data
  - id: del_ratio_ignore
    type:
      - 'null'
      - float
    doc: Ignore the deletion gap in nanopore or pacbio reads
    inputBinding:
      position: 101
      prefix: --del-ratio-ignore
  - id: density
    type:
      - 'null'
      - File
    doc: The path to list of input files for density plot
    inputBinding:
      position: 101
      prefix: --density
  - id: density_by_strand
    type:
      - 'null'
      - boolean
    doc: Whether to draw density plot by strand
    inputBinding:
      position: 101
      prefix: --density-by-strand
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: The distance metric for heatmap
    inputBinding:
      position: 101
      prefix: --distance-metric
  - id: distance_ratio
    type:
      - 'null'
      - float
    doc: The distance between transcript label and transcript line
    inputBinding:
      position: 101
      prefix: --distance-ratio
  - id: domain
    type:
      - 'null'
      - boolean
    doc: Add domain information into annotation track
    inputBinding:
      position: 101
      prefix: --domain
  - id: domain_exclude
    type:
      - 'null'
      - string
    doc: Which domain will be excluded in annotation plot
    inputBinding:
      position: 101
      prefix: --domain-exclude
  - id: domain_include
    type:
      - 'null'
      - string
    doc: Which domain will be included in annotation plot
    inputBinding:
      position: 101
      prefix: --domain-include
  - id: dpi
    type:
      - 'null'
      - int
    doc: The resolution of output file
    inputBinding:
      position: 101
      prefix: --dpi
  - id: event
    type:
      - 'null'
      - string
    doc: 'Event range eg: chr1:100-200:+'
    inputBinding:
      position: 101
      prefix: --event
  - id: exon_scale
    type:
      - 'null'
      - float
    doc: The scale of exon
    inputBinding:
      position: 101
      prefix: --exon-scale
  - id: fill_step
    type:
      - 'null'
      - string
    doc: Define step if the filling should be a step function
    inputBinding:
      position: 101
      prefix: --fill-step
  - id: focus
    type:
      - 'null'
      - string
    doc: The highlight regions
    inputBinding:
      position: 101
      prefix: --focus
  - id: font
    type:
      - 'null'
      - string
    doc: Fonts
    inputBinding:
      position: 101
      prefix: --font
  - id: font_size
    type:
      - 'null'
      - int
    doc: The font size of x, y-axis and so on
    inputBinding:
      position: 101
      prefix: --font-size
  - id: genome
    type:
      - 'null'
      - File
    doc: Path to genome fasta
    inputBinding:
      position: 101
      prefix: --genome
  - id: group_by_cell
    type:
      - 'null'
      - boolean
    doc: Group by cell types in density/line plot
    inputBinding:
      position: 101
      prefix: --group-by-cell
  - id: heatmap
    type:
      - 'null'
      - File
    doc: The path to list of input files for heatmap plot
    inputBinding:
      position: 101
      prefix: --heatmap
  - id: heatmap_scale
    type:
      - 'null'
      - boolean
    doc: Do scale on heatmap matrix
    inputBinding:
      position: 101
      prefix: --heatmap-scale
  - id: heatmap_vmax
    type:
      - 'null'
      - int
    doc: Maximum value to anchor the colormap
    inputBinding:
      position: 101
      prefix: --heatmap-vmax
  - id: heatmap_vmin
    type:
      - 'null'
      - int
    doc: Minimum value to anchor the colormap
    inputBinding:
      position: 101
      prefix: --heatmap-vmin
  - id: height
    type:
      - 'null'
      - float
    doc: The height of single subplot
    inputBinding:
      position: 101
      prefix: --height
  - id: hic
    type:
      - 'null'
      - File
    doc: The path to list of input files for HiC plot
    inputBinding:
      position: 101
      prefix: --hic
  - id: hide_legend
    type:
      - 'null'
      - boolean
    doc: Whether to hide legend
    inputBinding:
      position: 101
      prefix: --hide-legend
  - id: hide_y_label
    type:
      - 'null'
      - boolean
    doc: Whether hide y-axis label
    inputBinding:
      position: 101
      prefix: --hide-y-label
  - id: host
    type:
      - 'null'
      - string
    doc: The ip address binding to
    inputBinding:
      position: 101
      prefix: --host
  - id: igv
    type:
      - 'null'
      - File
    doc: The path to list of input files for IGV plot
    inputBinding:
      position: 101
      prefix: --igv
  - id: included_junctions
    type:
      - 'null'
      - string
    doc: The junction id for including
    inputBinding:
      position: 101
      prefix: --included-junctions
  - id: interval
    type:
      - 'null'
      - File
    doc: Path to list of interval files in bed format
    inputBinding:
      position: 101
      prefix: --interval
  - id: intron_scale
    type:
      - 'null'
      - float
    doc: The scale of intron
    inputBinding:
      position: 101
      prefix: --intron-scale
  - id: legend_ncol
    type:
      - 'null'
      - int
    doc: The number of columns of legend
    inputBinding:
      position: 101
      prefix: --legend-ncol
  - id: legend_position
    type:
      - 'null'
      - string
    doc: The legend position
    inputBinding:
      position: 101
      prefix: --legend-position
  - id: line
    type:
      - 'null'
      - File
    doc: The path to list of input files for line plot
    inputBinding:
      position: 101
      prefix: --line
  - id: link
    type:
      - 'null'
      - string
    doc: The link between two site at bottom
    inputBinding:
      position: 101
      prefix: --link
  - id: local_domain
    type:
      - 'null'
      - Directory
    doc: Load local domain folder and load into annotation track
    inputBinding:
      position: 101
      prefix: --local-domain
  - id: log
    type:
      - 'null'
      - string
    doc: y axis log transformed (0, 2, 10, or zscore)
    inputBinding:
      position: 101
      prefix: --log
  - id: logfile
    type:
      - 'null'
      - File
    doc: save log info into file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: m6a
    type:
      - 'null'
      - string
    doc: Highlight the RNA m6a modification cite
    inputBinding:
      position: 101
      prefix: --m6a
  - id: motif
    type:
      - 'null'
      - File
    doc: The path to customized bedGraph file
    inputBinding:
      position: 101
      prefix: --motif
  - id: motif_region
    type:
      - 'null'
      - string
    doc: The region of motif to plot
    inputBinding:
      position: 101
      prefix: --motif-region
  - id: motif_width
    type:
      - 'null'
      - float
    doc: The width of ATCG characters
    inputBinding:
      position: 101
      prefix: --motif-width
  - id: n_y_ticks
    type:
      - 'null'
      - int
    doc: The number of ticks of y-axis
    inputBinding:
      position: 101
      prefix: --n-y-ticks
  - id: no_gene
    type:
      - 'null'
      - boolean
    doc: Do not show gene id next to transcript id
    inputBinding:
      position: 101
      prefix: --no-gene
  - id: normalize_format
    type:
      - 'null'
      - string
    doc: The normalize format for bam file
    inputBinding:
      position: 101
      prefix: --normalize-format
  - id: only_customized_junction
    type:
      - 'null'
      - boolean
    doc: Only used customized junctions
    inputBinding:
      position: 101
      prefix: --only-customized-junction
  - id: plots
    type:
      - 'null'
      - Directory
    doc: The path to directory where to save the backend plot data and logs
    inputBinding:
      position: 101
      prefix: --plots
  - id: polya
    type:
      - 'null'
      - string
    doc: Visualize the poly(A) part at end of reads
    inputBinding:
      position: 101
      prefix: --polya
  - id: port
    type:
      - 'null'
      - int
    doc: The port to listen on
    inputBinding:
      position: 101
      prefix: --port
  - id: process
    type:
      - 'null'
      - int
    doc: How many cpu to use
    inputBinding:
      position: 101
      prefix: --process
  - id: proxy
    type:
      - 'null'
      - string
    doc: The http or https proxy for EBI/Uniprot requests
    inputBinding:
      position: 101
      prefix: --proxy
  - id: raster
    type:
      - 'null'
      - boolean
    doc: The would convert heatmap and site plot to raster image
    inputBinding:
      position: 101
      prefix: --raster
  - id: ref_color
    type:
      - 'null'
      - string
    doc: The color of exons
    inputBinding:
      position: 101
      prefix: --ref-color
  - id: remove_duplicate_umi
    type:
      - 'null'
      - boolean
    doc: Drop duplicated UMIs by barcode
    inputBinding:
      position: 101
      prefix: --remove-duplicate-umi
  - id: remove_empty
    type:
      - 'null'
      - boolean
    doc: Whether to plot empty transcript
    inputBinding:
      position: 101
      prefix: --remove-empty
  - id: reverse_minus
    type:
      - 'null'
      - boolean
    doc: Whether to reverse strand of bam/annotation file
    inputBinding:
      position: 101
      prefix: --reverse-minus
  - id: rs
    type:
      - 'null'
      - string
    doc: Real strand information of each reads
    inputBinding:
      position: 101
      prefix: --rs
  - id: same_y
    type:
      - 'null'
      - boolean
    doc: Whether different density/line plots shared same y-axis boundaries
    inputBinding:
      position: 101
      prefix: --same-y
  - id: same_y_by_groups
    type:
      - 'null'
      - File
    doc: Set groups for --same-y
    inputBinding:
      position: 101
      prefix: --same-y-by-groups
  - id: same_y_sc
    type:
      - 'null'
      - boolean
    doc: Similar with --same-y, but only shared same y-axis boundaries between 
      same single cell files
    inputBinding:
      position: 101
      prefix: --same-y-sc
  - id: sc_density_height_ratio
    type:
      - 'null'
      - float
    doc: The relative height of single cell density plots
    inputBinding:
      position: 101
      prefix: --sc-density-height-ratio
  - id: sc_heatmap_height_ratio
    type:
      - 'null'
      - float
    doc: The relative height of single cell heatmap plots
    inputBinding:
      position: 101
      prefix: --sc-heatmap-height-ratio
  - id: show_exon_id
    type:
      - 'null'
      - boolean
    doc: Whether show gene id or gene name
    inputBinding:
      position: 101
      prefix: --show-exon-id
  - id: show_id
    type:
      - 'null'
      - boolean
    doc: Whether show gene id or gene name
    inputBinding:
      position: 101
      prefix: --show-id
  - id: show_junction_num
    type:
      - 'null'
      - boolean
    doc: Whether to show the number of junctions
    inputBinding:
      position: 101
      prefix: --show-junction-num
  - id: show_mean_junction_num
    type:
      - 'null'
      - boolean
    doc: Whether to show the mean junction count averaged across multiple 
      samples
    inputBinding:
      position: 101
      prefix: --show-mean-junction_num
  - id: show_row_names
    type:
      - 'null'
      - boolean
    doc: Show row names of heatmap
    inputBinding:
      position: 101
      prefix: --show-row-names
  - id: show_site
    type:
      - 'null'
      - boolean
    doc: Whether to draw additional site plot
    inputBinding:
      position: 101
      prefix: --show-site
  - id: site_strand
    type:
      - 'null'
      - string
    doc: Which strand kept for site plot
    inputBinding:
      position: 101
      prefix: --site-strand
  - id: sites
    type:
      - 'null'
      - string
    doc: Where to plot additional indicator lines
    inputBinding:
      position: 101
      prefix: --sites
  - id: smooth_bin
    type:
      - 'null'
      - int
    doc: The bin size used to smooth ATAC fragments
    inputBinding:
      position: 101
      prefix: --smooth-bin
  - id: start_server
    type:
      - 'null'
      - boolean
    doc: Start web ui instead of running in cmd mode
    inputBinding:
      position: 101
      prefix: --start-server
  - id: stroke
    type:
      - 'null'
      - string
    doc: The stroke regions
    inputBinding:
      position: 101
      prefix: --stroke
  - id: stroke_scale
    type:
      - 'null'
      - float
    doc: The size of stroke plot in final image
    inputBinding:
      position: 101
      prefix: --stroke-scale
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold to filter low abundance junctions
    inputBinding:
      position: 101
      prefix: --threshold
  - id: timeout
    type:
      - 'null'
      - int
    doc: The requests timeout when `--domain` is True
    inputBinding:
      position: 101
      prefix: --timeout
  - id: title
    type:
      - 'null'
      - string
    doc: Title
    inputBinding:
      position: 101
      prefix: --title
  - id: transcripts_to_show
    type:
      - 'null'
      - string
    doc: Which transcript to show, transcript name or id in gtf file
    inputBinding:
      position: 101
      prefix: --transcripts-to-show
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: The default UMI barcode tag label
    inputBinding:
      position: 101
      prefix: --umi-tag
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable debug level log
    inputBinding:
      position: 101
      prefix: --verbose
  - id: width
    type:
      - 'null'
      - int
    doc: The width of output file
    inputBinding:
      position: 101
      prefix: --width
  - id: y_limit
    type:
      - 'null'
      - File
    doc: Manually set the y limit for all plots supported
    inputBinding:
      position: 101
      prefix: --y-limit
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output graph file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trackplot:0.5.7--pyhdfd78af_0
