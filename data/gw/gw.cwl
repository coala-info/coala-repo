cwlVersion: v1.2
class: CommandLineTool
baseCommand: gw
label: gw
doc: "Reference genome in .fasta format with .fai index file\n\nTool homepage: https://github.com/kcleal/gw"
inputs:
  - id: genome
    type: File
    doc: Reference genome in .fasta format with .fai index file
    default: ''
    inputBinding:
      position: 1
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Bam/cram alignment file. Repeat for multiple files stacked vertically
    default: ''
    inputBinding:
      position: 102
      prefix: --bam
  - id: command
    type:
      - 'null'
      - string
    doc: Apply command before drawing e.g. -c 'sort strand'
    default: ''
    inputBinding:
      position: 102
      prefix: --command
  - id: delay
    type:
      - 'null'
      - int
    doc: Delay in milliseconds before each update, useful for remote connections
    default: 0
    inputBinding:
      position: 102
      prefix: --delay
  - id: dimensions
    type:
      - 'null'
      - string
    doc: Image dimensions (px)
    default: 1366x800
    inputBinding:
      position: 102
      prefix: --dims
  - id: filter_reads
    type:
      - 'null'
      - string
    doc: Filter to apply to all reads
    default: ''
    inputBinding:
      position: 102
      prefix: --filter
  - id: ideogram_file
    type:
      - 'null'
      - File
    doc: Ideogram bed file (uncompressed). Any bed file should work
    inputBinding:
      position: 102
      prefix: --ideogram
  - id: images
    type:
      - 'null'
      - string
    doc: Glob path to .png images to display e.g. '*.png'. Can not be used with 
      -v
    inputBinding:
      position: 102
      prefix: --images
  - id: indel_length
    type:
      - 'null'
      - int
    doc: Indels >= this length (bp) will have text labels
    default: 15
    inputBinding:
      position: 102
      prefix: --indel-length
  - id: input_labels_file
    type:
      - 'null'
      - File
    doc: Input labels from tab-separated FILE (use with -v or -i)
    default: ''
    inputBinding:
      position: 102
      prefix: --in-labels
  - id: labels
    type:
      - 'null'
      - string
    doc: Choice of labels to use. Provide as comma-separated list e.g. 
      'PASS,FAIL'
    default: PASS,FAIL
    inputBinding:
      position: 102
      prefix: --labels
  - id: link_alignments
    type:
      - 'null'
      - string
    doc: Draw linking lines between these alignments
    default: none
    inputBinding:
      position: 102
      prefix: --link
  - id: log2_coverage
    type:
      - 'null'
      - boolean
    doc: Scale coverage track to log2
    default: false
    inputBinding:
      position: 102
      prefix: --log2-cov
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Reduce memory usage by discarding quality values
    default: false
    inputBinding:
      position: 102
      prefix: --low-mem
  - id: max_tlen
    type:
      - 'null'
      - int
    doc: Maximum tlen to display on plot
    default: 2000
    inputBinding:
      position: 102
      prefix: --max-tlen
  - id: min_chrom_size
    type:
      - 'null'
      - int
    doc: Minimum chromosome size for chromosome-scale images
    default: 10000000
    inputBinding:
      position: 102
      prefix: --min-chrom-size
  - id: no_edges
    type:
      - 'null'
      - boolean
    doc: Edge colours are not shown
    default: false
    inputBinding:
      position: 102
      prefix: --no-edges
  - id: no_insertions
    type:
      - 'null'
      - boolean
    doc: Insertions below --indel-length are not shown
    default: false
    inputBinding:
      position: 102
      prefix: --no-insertions
  - id: no_mismatches
    type:
      - 'null'
      - boolean
    doc: Mismatches are not shown
    default: false
    inputBinding:
      position: 102
      prefix: --no-mismatches
  - id: no_show
    type:
      - 'null'
      - boolean
    doc: Don't display images to screen
    default: false
    inputBinding:
      position: 102
      prefix: --no-show
  - id: no_soft_clips
    type:
      - 'null'
      - boolean
    doc: Soft-clips are not shown
    default: false
    inputBinding:
      position: 102
      prefix: --no-soft-clips
  - id: number_of_tiles
    type:
      - 'null'
      - string
    doc: Images tiles to display (used with -v and -i)
    default: 3x3
    inputBinding:
      position: 102
      prefix: --number
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output file format
    default: png
    inputBinding:
      position: 102
      prefix: --fmt
  - id: padding
    type:
      - 'null'
      - int
    doc: Padding +/- in bp to add to each region from -v or -r
    default: 500
    inputBinding:
      position: 102
      prefix: --pad
  - id: parse_label
    type:
      - 'null'
      - string
    doc: Label to parse from vcf file (used with -v) e.g. 'filter' or 'info.SU' 
      or 'qual'
    default: filter
    inputBinding:
      position: 102
      prefix: --parse-label
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Region of alignment file to display in window. Repeat to horizontally 
      split window into multiple regions
    inputBinding:
      position: 102
      prefix: --region
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume labelling from last user-labelled variant
    default: false
    inputBinding:
      position: 102
      prefix: --resume
  - id: session_file
    type:
      - 'null'
      - File
    doc: GW session file to load (.ini suffix)
    default: ''
    inputBinding:
      position: 102
      prefix: --session
  - id: show_config_path
    type:
      - 'null'
      - boolean
    doc: Display path of loaded .gw.ini config
    default: false
    inputBinding:
      position: 102
      prefix: --config
  - id: show_mods
    type:
      - 'null'
      - boolean
    doc: Base modifications are shown
    default: false
    inputBinding:
      position: 102
      prefix: --mods
  - id: split_view_size
    type:
      - 'null'
      - int
    doc: Max variant size before region is split into two smaller panes (used 
      with -v only)
    default: 10000
    inputBinding:
      position: 102
      prefix: --split-view-size
  - id: start_index
    type:
      - 'null'
      - int
    doc: Start labelling from -v / -i index (zero-based)
    default: 0
    inputBinding:
      position: 102
      prefix: --start-index
  - id: theme
    type:
      - 'null'
      - string
    doc: Image theme igv|dark|slate
    default: dark
    inputBinding:
      position: 102
      prefix: --theme
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: tlen_y_axis
    type:
      - 'null'
      - boolean
    doc: Y-axis will be set to template-length (tlen) bp. Relevant for 
      paired-end reads only
    default: false
    inputBinding:
      position: 102
      prefix: --tlen-y
  - id: tracks
    type:
      - 'null'
      - type: array
        items: string
    doc: Track to display at bottom of window BED/VCF/GFF3/GTF/BEGBID/BIGWIG. 
      Repeat for multiple files stacked vertically
    default: ''
    inputBinding:
      position: 102
      prefix: --track
  - id: variants_file
    type:
      - 'null'
      - File
    doc: VCF/BCF/BED file to derive regions from. Can not be used with -i
    inputBinding:
      position: 102
      prefix: --variants
  - id: ylim_coverage
    type:
      - 'null'
      - int
    doc: Maximum y limit of coverage track
    default: 50
    inputBinding:
      position: 102
      prefix: --cov
  - id: ylim_reads
    type:
      - 'null'
      - int
    doc: Maximum y limit (depth) of reads in image
    default: 50
    inputBinding:
      position: 102
      prefix: --ylim
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output folder to save images
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output single image to file
    outputBinding:
      glob: $(inputs.output_file)
  - id: out_vcf_file
    type:
      - 'null'
      - File
    doc: Output labelling results to vcf FILE (the -v option is required)
    outputBinding:
      glob: $(inputs.out_vcf_file)
  - id: out_labels_file
    type:
      - 'null'
      - File
    doc: Output labelling results to tab-separated FILE (use with -v or -i)
    outputBinding:
      glob: $(inputs.out_labels_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gw:1.2.6--hff18be8_0
