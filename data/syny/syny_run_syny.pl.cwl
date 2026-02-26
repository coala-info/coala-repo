cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_syny.pl
label: syny_run_syny.pl
doc: "Runs the SYNY pipeline\n\nTool homepage: https://github.com/PombertLab/SYNY"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Specify genome alignment tool: minimap or mashmap'
    default: minimap
    inputBinding:
      position: 101
      prefix: --aligner
  - id: alternate_barplot_colors
    type:
      - 'null'
      - boolean
    doc: 'Color clusters by alternating colors; colors are not related within/between
      contigs; [Default: off]'
    inputBinding:
      position: 101
      prefix: --bclusters
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GenBank GBF/GBFF Annotation files (GZIP files are supported)
    inputBinding:
      position: 101
      prefix: --annot
  - id: barplot_color_palette
    type:
      - 'null'
      - string
    doc: Barplot color palette
    default: Spectral
    inputBinding:
      position: 101
      prefix: --palette
  - id: barplot_font_size
    type:
      - 'null'
      - float
    doc: Barplot font size
    default: 8.0
    inputBinding:
      position: 101
      prefix: --bfsize
  - id: barplot_height
    type:
      - 'null'
      - float
    doc: Barplot figure height in inches
    default: 10.8
    inputBinding:
      position: 101
      prefix: --bheight
  - id: barplot_mode
    type:
      - 'null'
      - string
    doc: 'Barplot mode: pair (pairwise), cat (concatenated), all (cat + pair)'
    default: pair
    inputBinding:
      position: 101
      prefix: --bpmode
  - id: barplot_width
    type:
      - 'null'
      - float
    doc: Barplot figure width in inches
    default: 19.2
    inputBinding:
      position: 101
      prefix: --bwidth
  - id: circos_mode
    type:
      - 'null'
      - string
    doc: 'Circos plot mode: pair (pairwise), cat (concatenated), all (cat + pair)'
    default: pair
    inputBinding:
      position: 101
      prefix: --circos
  - id: circos_orientation
    type:
      - 'null'
      - string
    doc: 'Karyotype orientation: normal, inverted or both'
    default: normal
    inputBinding:
      position: 101
      prefix: --orientation
  - id: circos_prefix
    type:
      - 'null'
      - string
    doc: Prefix for concatenated plots
    default: circos
    inputBinding:
      position: 101
      prefix: --circos_prefix
  - id: color_by_cluster
    type:
      - 'null'
      - boolean
    doc: 'Color by cluster instead of contig/chromosome [Default: off]'
    inputBinding:
      position: 101
      prefix: --clusters
  - id: contig_label_font
    type:
      - 'null'
      - string
    doc: Contig label font
    default: bold
    inputBinding:
      position: 101
      prefix: --label_font
  - id: contig_label_size
    type:
      - 'null'
      - int
    doc: Contig label size
    default: 36
    inputBinding:
      position: 101
      prefix: --label_size
  - id: contig_label_type
    type:
      - 'null'
      - string
    doc: 'Contig label type: mixed (arabic + roman numbers), arabic, roman, or names'
    default: mixed
    inputBinding:
      position: 101
      prefix: --labels
  - id: custom_color_file
    type:
      - 'null'
      - File
    doc: Load custom colors from file
    inputBinding:
      position: 101
      prefix: --custom_file
  - id: custom_color_preset
    type:
      - 'null'
      - string
    doc: 'Use a custom color preset, e.g.: --custom_preset chloropicon'
    inputBinding:
      position: 101
      prefix: --custom_preset
  - id: dotplot_color
    type:
      - 'null'
      - string
    doc: Dotplot color
    default: blue
    inputBinding:
      position: 101
      prefix: --color
  - id: dotplot_color_palette
    type:
      - 'null'
      - string
    doc: 'Use a color palette instead: e.g. --dotpalette inferno'
    inputBinding:
      position: 101
      prefix: --dotpalette
  - id: dotplot_font_size
    type:
      - 'null'
      - float
    doc: Dotplot font size
    default: 8.0
    inputBinding:
      position: 101
      prefix: --dfsize
  - id: dotplot_height
    type:
      - 'null'
      - float
    doc: Dotplot figure height in inches
    default: 10.8
    inputBinding:
      position: 101
      prefix: --dheight
  - id: dotplot_multiplier
    type:
      - 'null'
      - float
    doc: Axes units multiplier (for dotplots)
    default: 100000.0
    inputBinding:
      position: 101
      prefix: --multi
  - id: dotplot_subplot_height_distance
    type:
      - 'null'
      - float
    doc: Vertical distance (height) between subplots
    default: 0.1
    inputBinding:
      position: 101
      prefix: --hdis
  - id: dotplot_subplot_width_distance
    type:
      - 'null'
      - float
    doc: Horizontal distance (width) between subplots
    default: 0.05
    inputBinding:
      position: 101
      prefix: --wdis
  - id: dotplot_width
    type:
      - 'null'
      - float
    doc: Dotplot figure width in inches
    default: 19.2
    inputBinding:
      position: 101
      prefix: --dwidth
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: DIAMOND BLASTP evalue cutoff
    default: '1e-10'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: exclude_regex
    type:
      - 'null'
      - string
    doc: Exclude contigs with names matching the regular expression(s); e.g. 
      --exclude '^AUX'
    inputBinding:
      position: 101
      prefix: --exclude
  - id: gaps
    type:
      - 'null'
      - type: array
        items: int
    doc: Allowable number of gaps between gene pairs
    default: 0
    inputBinding:
      position: 101
      prefix: --gaps
  - id: heatmap_auto_color_bar
    type:
      - 'null'
      - boolean
    doc: Set color bar values automatically instead
    inputBinding:
      position: 101
      prefix: --hauto
  - id: heatmap_color_palette
    type:
      - 'null'
      - string
    doc: Heatmap color palette
    default: winter_r
    inputBinding:
      position: 101
      prefix: --hmpalette
  - id: heatmap_font_size
    type:
      - 'null'
      - float
    doc: Heatmap font size
    default: 8.0
    inputBinding:
      position: 101
      prefix: --hfsize
  - id: heatmap_height
    type:
      - 'null'
      - float
    doc: Heatmap figure height in inches
    default: 10.0
    inputBinding:
      position: 101
      prefix: --hheight
  - id: heatmap_max_color_bar
    type:
      - 'null'
      - int
    doc: Set maximum color bar value
    default: 100
    inputBinding:
      position: 101
      prefix: --hmax
  - id: heatmap_min_color_bar
    type:
      - 'null'
      - int
    doc: Set minimum color bar value
    default: 0
    inputBinding:
      position: 101
      prefix: --hmin
  - id: heatmap_width
    type:
      - 'null'
      - float
    doc: Heatmap figure width in inches
    default: 10.0
    inputBinding:
      position: 101
      prefix: --hwidth
  - id: include_contigs_file
    type:
      - 'null'
      - File
    doc: Select contigs with names from input text file(s) (one name per line); 
      i.e. exclude everything else
    inputBinding:
      position: 101
      prefix: --include
  - id: linear_map_font_size
    type:
      - 'null'
      - float
    doc: Font size
    default: 8.0
    inputBinding:
      position: 101
      prefix: --lfsize
  - id: linear_map_height
    type:
      - 'null'
      - float
    doc: Linear map figure height in inches
    default: 5.0
    inputBinding:
      position: 101
      prefix: --lheight
  - id: linear_map_reference_palette
    type:
      - 'null'
      - string
    doc: Reference genome color palette
    default: tab20
    inputBinding:
      position: 101
      prefix: --lm_rpalette
  - id: linear_map_rotation
    type:
      - 'null'
      - int
    doc: Contig name rotation
    default: 90
    inputBinding:
      position: 101
      prefix: --lmrotation
  - id: linear_map_target_palette
    type:
      - 'null'
      - string
    doc: Target genome color palette
    default: Blues
    inputBinding:
      position: 101
      prefix: --lm_xpalette
  - id: linear_map_width
    type:
      - 'null'
      - float
    doc: Heatmap figure width in inches
    default: 20.0
    inputBinding:
      position: 101
      prefix: --lwidth
  - id: list_custom_color_presets
    type:
      - 'null'
      - boolean
    doc: List available custom color presets
    inputBinding:
      position: 101
      prefix: --list_preset
  - id: mashmap_percentage_identity
    type:
      - 'null'
      - int
    doc: Specify mashmap3 percentage identity
    default: 85
    inputBinding:
      position: 101
      prefix: --mpid
  - id: max_ideograms
    type:
      - 'null'
      - int
    doc: Set max number of ideograms
    default: 200
    inputBinding:
      position: 101
      prefix: --max_ideograms
  - id: max_links
    type:
      - 'null'
      - int
    doc: Set max number of links
    default: 75000
    inputBinding:
      position: 101
      prefix: --max_links
  - id: max_points_per_track
    type:
      - 'null'
      - int
    doc: Set max number of points per track
    default: 75000
    inputBinding:
      position: 101
      prefix: --max_points_per_track
  - id: max_ticks
    type:
      - 'null'
      - int
    doc: Set max number of ticks
    default: 5000
    inputBinding:
      position: 101
      prefix: --max_ticks
  - id: min_alignment_size
    type:
      - 'null'
      - int
    doc: Filter out alignments/clusters smaller than integer value (e.g. 
      --min_asize 5000)
    inputBinding:
      position: 101
      prefix: --min_asize
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum contig size (in bp)
    default: 1
    inputBinding:
      position: 101
      prefix: --minsize
  - id: minimap_asm_preset
    type:
      - 'null'
      - int
    doc: Specify minimap max divergence preset (--asm 5, 10 or 20)
    default: off
    inputBinding:
      position: 101
      prefix: --asm
  - id: monochrome_barplot_color
    type:
      - 'null'
      - string
    doc: 'Use a monochrome barplot color instead: e.g. --monobar blue'
    inputBinding:
      position: 101
      prefix: --monobar
  - id: no_barplots
    type:
      - 'null'
      - boolean
    doc: Turn off barplots
    inputBinding:
      position: 101
      prefix: --no_barplot
  - id: no_circos_plots
    type:
      - 'null'
      - boolean
    doc: Turn off Circos plots
    inputBinding:
      position: 101
      prefix: --no_circos
  - id: no_circos_ticks
    type:
      - 'null'
      - boolean
    doc: Turn off ticks in Circos plots
    inputBinding:
      position: 101
      prefix: --no_cticks
  - id: no_dotplot_ticks
    type:
      - 'null'
      - boolean
    doc: Turn off ticks on x and y axes
    inputBinding:
      position: 101
      prefix: --noticks
  - id: no_dotplots
    type:
      - 'null'
      - boolean
    doc: Turn off dotplots
    inputBinding:
      position: 101
      prefix: --no_dotplot
  - id: no_heatmaps
    type:
      - 'null'
      - boolean
    doc: Turn off heatmaps
    inputBinding:
      position: 101
      prefix: --no_heatmap
  - id: no_linear_maps
    type:
      - 'null'
      - boolean
    doc: Turn off linemaps
    inputBinding:
      position: 101
      prefix: --no_linemap
  - id: no_minimap2_secondary_alignments
    type:
      - 'null'
      - boolean
    doc: Turn off minimap2 secondary alignments
    inputBinding:
      position: 101
      prefix: --no_sec
  - id: no_nucleotide_biases
    type:
      - 'null'
      - boolean
    doc: Turn off nucleotide biases and GC/AT skews subplots
    inputBinding:
      position: 101
      prefix: --no_ntbiases
  - id: no_skews
    type:
      - 'null'
      - boolean
    doc: Turn off GC / AT skews subplots
    inputBinding:
      position: 101
      prefix: --no_skews
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: SYNY
    inputBinding:
      position: 101
      prefix: --outdir
  - id: parallel_threads
    type:
      - 'null'
      - int
    doc: Number of graphs to plot in parralel; defaults to --threads if 
      unspecified
    inputBinding:
      position: 101
      prefix: --pthreads
  - id: ranges_file
    type:
      - 'null'
      - File
    doc: 'Select contigs with subranges from input text file(s): name start end'
    inputBinding:
      position: 101
      prefix: --ranges
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference to use for concatenated plots; uses first genome 
      (alphabetically) if ommitted
    inputBinding:
      position: 101
      prefix: --ref
  - id: resume_alignments
    type:
      - 'null'
      - boolean
    doc: Resume minimap/mashmap computations (skip completed alignments)
    inputBinding:
      position: 101
      prefix: --resume
  - id: size_unit
    type:
      - 'null'
      - string
    doc: Size unit (Kb or Mb)
    default: Mb
    inputBinding:
      position: 101
      prefix: --unit
  - id: skip_gene_cluster_reconstruction
    type:
      - 'null'
      - boolean
    doc: Skip gene cluster reconstructions
    inputBinding:
      position: 101
      prefix: --no_clus
  - id: skip_pairwise_alignments
    type:
      - 'null'
      - boolean
    doc: Skip minimap/mashmap pairwise genome alignments
    inputBinding:
      position: 101
      prefix: --no_map
  - id: skip_vcf_creation
    type:
      - 'null'
      - boolean
    doc: Skip minimap VCF file creation (files can be quite large)
    inputBinding:
      position: 101
      prefix: --no_vcf
  - id: step_size
    type:
      - 'null'
      - int
    doc: Sliding windows step (nucleotide biases)
    default: 5000
    inputBinding:
      position: 101
      prefix: --stepsize
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Sliding windows size (nucleotide biases)
    default: 10000
    inputBinding:
      position: 101
      prefix: --winsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syny:1.3.2--py312pl5321h7e72e81_0
stdout: syny_run_syny.pl.out
