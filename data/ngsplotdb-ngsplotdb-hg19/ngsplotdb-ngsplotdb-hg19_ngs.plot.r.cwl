cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs.plot.r
label: ngsplotdb-ngsplotdb-hg19_ngs.plot.r
doc: "ngs.plot.r is a tool for generating various plots related to genomic data, including
  coverage profiles and heatmaps. It supports multiple genomes and regions, and offers
  extensive customization options for data processing and visualization.\n\nTool homepage:
  https://github.com/shenlab-sinai/ngsplot"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for loading genes in batch(default=100)
    inputBinding:
      position: 101
      prefix: -CS
  - id: color_scale
    type:
      - 'null'
      - string
    doc: 'Color scale used to map values to colors in a heatmap local(default): base
      on each individual heatmap region: base on all heatmaps belong to the same region
      global: base on all heatmaps together min_val,max_val: custom scale using a
      pair of numerics'
    inputBinding:
      position: 101
      prefix: -SC
  - id: cov_config_file
    type: File
    doc: Indexed bam file or a configuration file for multiplot
    inputBinding:
      position: 101
      prefix: -C
  - id: database_table_or_plottype
    type:
      - 'null'
      - string
    doc: 'Further information provided to select database table or plottype: This
      is a string of description separated by comma. E.g. protein_coding,K562,rnaseq(order
      of descriptors does not matter) means coding genes in K562 cell line drawn in
      rnaseq mode.'
    inputBinding:
      position: 101
      prefix: -F
  - id: draw_axis_labels
    type:
      - 'null'
      - boolean
    doc: Draw X- and Y-axis labels? 1(default) or 0
    inputBinding:
      position: 101
      prefix: -XYL
  - id: draw_box
    type:
      - 'null'
      - boolean
    doc: Draw box around plot? 1(default) or 0
    inputBinding:
      position: 101
      prefix: -BOX
  - id: draw_legend
    type:
      - 'null'
      - boolean
    doc: Draw legend? 1(default) or 0
    inputBinding:
      position: 101
      prefix: -LEG
  - id: draw_vertical_lines
    type:
      - 'null'
      - boolean
    doc: Draw vertical lines? 1(default) or 0
    inputBinding:
      position: 101
      prefix: -VLN
  - id: flanking_region_factor
    type:
      - 'null'
      - float
    doc: Flanking region factor
    inputBinding:
      position: 101
      prefix: -N
  - id: flanking_region_size
    type:
      - 'null'
      - int
    doc: Flanking region size(will override flanking factor)
    inputBinding:
      position: 101
      prefix: -L
  - id: flooding_fraction
    type:
      - 'null'
      - float
    doc: Flooding fraction:[0, 1), default=0.02
    inputBinding:
      position: 101
      prefix: -FC
  - id: font_size
    type:
      - 'null'
      - int
    doc: Font size(default=12)
    inputBinding:
      position: 101
      prefix: -FS
  - id: forbid_image_output
    type:
      - 'null'
      - boolean
    doc: Forbid image output if set to 1(default=0)
    inputBinding:
      position: 101
      prefix: -FI
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: Fragment length used to calculate physical coverage(default=150)
    inputBinding:
      position: 101
      prefix: -FL
  - id: gene_database
    type:
      - 'null'
      - string
    doc: 'Gene database: ensembl(default), refseq'
    inputBinding:
      position: 101
      prefix: -D
  - id: gene_list_or_bed_file
    type:
      - 'null'
      - File
    doc: Gene list to subset regions OR bed file for custom region
    inputBinding:
      position: 101
      prefix: -E
  - id: gene_order_algorithm
    type:
      - 'null'
      - string
    doc: 'Gene order algorithm used in heatmaps: total(default), hc, max, prod, diff,
      km and none(according to gene list supplied)'
    inputBinding:
      position: 101
      prefix: -GO
  - id: genome
    type: string
    doc: Genome name. Use ngsplotdb.py list to show available genomes.
    inputBinding:
      position: 101
      prefix: -G
  - id: heatmap_color
    type:
      - 'null'
      - string
    doc: 'Color for heatmap. For bam-pair, use color-tri(neg_color:[neu_color]:pos_color)
      Hint: must use R colors, such as darkgreen, yellow and blue2 The neutral color
      is optional(default=black)'
    inputBinding:
      position: 101
      prefix: -CO
  - id: heatmap_color_distribution
    type:
      - 'null'
      - float
    doc: 'Color distribution for heatmap(default=0.6). Must be a positive number Hint:
      lower values give more widely spaced colors at the negative end In other words,
      they shift the neutral color to positive values If set to 1, the neutral color
      represents 0(i.e. no bias)'
    inputBinding:
      position: 101
      prefix: -CD
  - id: heatmap_reduce_ratio
    type:
      - 'null'
      - int
    doc: Reduce ratio(default=30). The parameter controls the heatmap height The
      smaller the value, the taller the heatmap
    inputBinding:
      position: 101
      prefix: -RR
  - id: image_height
    type:
      - 'null'
      - float
    doc: Image height(default=7)
    inputBinding:
      position: 101
      prefix: -HG
  - id: image_title
    type:
      - 'null'
      - string
    doc: Image title
    inputBinding:
      position: 101
      prefix: -T
  - id: image_width
    type:
      - 'null'
      - float
    doc: Image width(default=8)
    inputBinding:
      position: 101
      prefix: -WD
  - id: interval_larger_than_flanking
    type:
      - 'null'
      - boolean
    doc: Shall interval be larger than flanking in plot?(0 or 1, 
      default=automatic)
    inputBinding:
      position: 101
      prefix: -IN
  - id: kmeans_max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations(default=20) for K-means
    inputBinding:
      position: 101
      prefix: -MIT
  - id: kmeans_num_random_starts
    type:
      - 'null'
      - int
    doc: Number of random starts(default=30) in K-means
    inputBinding:
      position: 101
      prefix: -NRS
  - id: kmeans_or_hc_clusters
    type:
      - 'null'
      - int
    doc: K-means or HC number of clusters(default=5)
    inputBinding:
      position: 101
      prefix: -KNC
  - id: line_width
    type:
      - 'null'
      - int
    doc: Line width(default=3)
    inputBinding:
      position: 101
      prefix: -LWD
  - id: low_count_cutoff
    type:
      - 'null'
      - int
    doc: Low count cutoff(default=10) in rank-based normalization
    inputBinding:
      position: 101
      prefix: -LOW
  - id: mapping_quality_cutoff
    type:
      - 'null'
      - int
    doc: Mapping quality cutoff to filter reads(default=20)
    inputBinding:
      position: 101
      prefix: -MQ
  - id: moving_window_width
    type:
      - 'null'
      - int
    doc: Moving window width to smooth avg. profiles, must be integer 
      1=no(default); 3=slightly; 5=somewhat; 9=quite; 13=super.
    inputBinding:
      position: 101
      prefix: -MW
  - id: normalization_algorithm
    type:
      - 'null'
      - string
    doc: 'Algorithm used to normalize coverage vectors: spline(default), bin'
    inputBinding:
      position: 101
      prefix: -AL
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: '#CPUs to use. Set 0(default) for auto detection'
    inputBinding:
      position: 101
      prefix: -P
  - id: output_name
    type: string
    doc: 'Name for output: multiple files will be generated'
    inputBinding:
      position: 101
      prefix: -O
  - id: plot_standard_errors
    type:
      - 'null'
      - boolean
    doc: Shall standard errors be plotted?(0 or 1)
    inputBinding:
      position: 101
      prefix: -SE
  - id: random_sample_regions
    type:
      - 'null'
      - float
    doc: Randomly sample the regions for plot, must be:(0, 1]
    inputBinding:
      position: 101
      prefix: -S
  - id: region
    type: string
    doc: 'Genomic regions to plot: tss, tes, genebody, exon, cgi, enhancer, dhs or
      bed'
    inputBinding:
      position: 101
      prefix: -R
  - id: shaded_area_opacity
    type:
      - 'null'
      - float
    doc: Opacity of shaded area, suggested value:[0, 0.5] default=0, i.e. no 
      shading, just lines
    inputBinding:
      position: 101
      prefix: -H
  - id: strand_specific_coverage
    type:
      - 'null'
      - string
    doc: 'Strand-specific coverage calculation: both(default), same, opposite'
    inputBinding:
      position: 101
      prefix: -SS
  - id: trim_fraction
    type:
      - 'null'
      - float
    doc: The fraction of extreme values to be trimmed on both ends default=0, 
      0.05 means 5% of extreme values will be trimmed
    inputBinding:
      position: 101
      prefix: -RB
  - id: yaxis_scale
    type:
      - 'null'
      - string
    doc: 'Y-axis scale: auto(default) or min_val,max_val(custom scale)'
    inputBinding:
      position: 101
      prefix: -YAS
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
stdout: ngsplotdb-ngsplotdb-hg19_ngs.plot.r.out
