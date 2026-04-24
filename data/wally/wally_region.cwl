cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wally
  - region
label: wally_region
doc: "Display BAM alignments in a specified region.\n\nTool homepage: https://github.com/tobiasrausch/wally"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Sorted BAM files to display
    inputBinding:
      position: 1
  - id: bed_annotation_file
    type:
      - 'null'
      - File
    doc: BED annotation file (optional)
    inputBinding:
      position: 102
      prefix: --bed
  - id: genome_fasta
    type: File
    doc: genome fasta file
    inputBinding:
      position: 102
      prefix: --genome
  - id: insert_size_cutoff
    type:
      - 'null'
      - float
    doc: insert size cutoff, median+m*MAD
    inputBinding:
      position: 102
      prefix: --mad-cutoff
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: min. mapping quality
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: min_snv_coverage
    type:
      - 'null'
      - int
    doc: min. SNV coverage
    inputBinding:
      position: 102
      prefix: --snv-cov
  - id: min_snv_vaf
    type:
      - 'null'
      - float
    doc: min. SNV VAF
    inputBinding:
      position: 102
      prefix: --snv-vaf
  - id: num_horizontal_images
    type:
      - 'null'
      - int
    doc: number of horizontal images
    inputBinding:
      position: 102
      prefix: --split
  - id: paired_end_view
    type:
      - 'null'
      - boolean
    doc: paired-end view
    inputBinding:
      position: 102
      prefix: --paired
  - id: plot_height
    type:
      - 'null'
      - int
    doc: height of the plot
    inputBinding:
      position: 102
      prefix: --height
  - id: plot_width
    type:
      - 'null'
      - int
    doc: width of the plot
    inputBinding:
      position: 102
      prefix: --width
  - id: region_to_display
    type:
      - 'null'
      - string
    doc: region to display
    inputBinding:
      position: 102
      prefix: --region
  - id: regions_bed_file
    type:
      - 'null'
      - File
    doc: BED file with regions to display
    inputBinding:
      position: 102
      prefix: --rfile
  - id: show_clips
    type:
      - 'null'
      - boolean
    doc: show soft- and hard-clips
    inputBinding:
      position: 102
      prefix: --clip
  - id: show_supplementary_alignments
    type:
      - 'null'
      - boolean
    doc: show supplementary alignments
    inputBinding:
      position: 102
      prefix: --supplementary
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wally:0.7.1--h4d20210_1
stdout: wally_region.out
