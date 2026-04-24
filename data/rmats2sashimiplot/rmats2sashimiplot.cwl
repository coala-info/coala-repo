cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmats2sashimiplot
label: rmats2sashimiplot
doc: "Generate sashimi plots from rMATS output or coordinate and annotation input.\n\
  \nTool homepage: https://github.com/Xinglab/rmats2sashimiplot"
inputs:
  - id: color
    type:
      - 'null'
      - string
    doc: "Specify a list of colors with one color per plot. Without grouping there
      is one plot per replicate. With grouping there is one plot per group: --color
      '#CC0011[,#FF8800]'"
    inputBinding:
      position: 101
      prefix: --color
  - id: coordinate_and_annotation
    type:
      - 'null'
      - string
    doc: The genome region coordinates and a GFF3 (not GTF) annotation file of 
      genes and transcripts. The format is -c 
      {chromosome}:{strand}:{start}:{end}:{/path/to/gff3} (Only if using 
      Coordinate and annotation input)
    inputBinding:
      position: 101
      prefix: --c
  - id: event_type
    type:
      - 'null'
      - string
    doc: "Type of event from rMATS result used in the analysis. 'SE': skipped exon,
      'A5SS': alternative 5' splice site, 'A3SS' alternative 3' splice site, 'MXE':
      mutually exclusive exons, 'RI': retained intron. (Only if using rMATS event
      input)"
    inputBinding:
      position: 101
      prefix: --event-type
  - id: events_file
    type:
      - 'null'
      - File
    doc: The rMATS output event file (Only if using rMATS event input)
    inputBinding:
      position: 101
      prefix: --e
  - id: exon_scale
    type:
      - 'null'
      - float
    doc: 'How much to scale down exons. Default: 1'
    inputBinding:
      position: 101
      prefix: --exon_s
  - id: figure_height
    type:
      - 'null'
      - float
    doc: Set the output figure height (in inches). Default is 7 if sample size <
      5 and 14 if sample size is 5 or more
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: figure_width
    type:
      - 'null'
      - float
    doc: 'Set the output figure width (in inches). Default: 8'
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: font_size
    type:
      - 'null'
      - int
    doc: 'Set the font size. Default: 8'
    inputBinding:
      position: 101
      prefix: --font-size
  - id: group_info_file
    type:
      - 'null'
      - File
    doc: The path to a *.gf file which groups the replicates. One sashimi plot 
      will be generated for each group instead of the default behavior of one 
      plot per replicate
    inputBinding:
      position: 101
      prefix: --group-info
  - id: hide_number
    type:
      - 'null'
      - boolean
    doc: Do not display the read count on the junctions
    inputBinding:
      position: 101
      prefix: --hide-number
  - id: intron_scale
    type:
      - 'null'
      - float
    doc: 'How much to scale down introns. For example, --intron_s 5 results in an
      intron with real length of 100 being plotted as 100/5 = 20. Default: 1'
    inputBinding:
      position: 101
      prefix: --intron_s
  - id: keep_event_chr_prefix
    type:
      - 'null'
      - boolean
    doc: force the contig name in the provided events file to be used
    inputBinding:
      position: 101
      prefix: --keep-event-chr-prefix
  - id: label1
    type:
      - 'null'
      - string
    doc: The label for the first sample.
    inputBinding:
      position: 101
      prefix: --l1
  - id: label2
    type:
      - 'null'
      - string
    doc: The label for the second sample.
    inputBinding:
      position: 101
      prefix: --l2
  - id: min_counts
    type:
      - 'null'
      - int
    doc: 'Individual junctions with read count below --min-counts will be omitted
      from the plot. Default: 0'
    inputBinding:
      position: 101
      prefix: --min-counts
  - id: no_text_background
    type:
      - 'null'
      - boolean
    doc: Do not put a white box behind the junction read count
    inputBinding:
      position: 101
      prefix: --no-text-background
  - id: output_dir
    type: Directory
    doc: The output directory.
    inputBinding:
      position: 101
      prefix: --o
  - id: remove_event_chr_prefix
    type:
      - 'null'
      - boolean
    doc: remove any leading "chr" from contig names in the provided events file
    inputBinding:
      position: 101
      prefix: --remove-event-chr-prefix
  - id: sample1_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'sample_1 bam files: s1_rep1.bam[,s1_rep2.bam]'
    inputBinding:
      position: 101
      prefix: --b1
  - id: sample1_sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'sample_1 sam files: s1_rep1.sam[,s1_rep2.sam]'
    inputBinding:
      position: 101
      prefix: --s1
  - id: sample2_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'sample_2 bam files: s2_rep1.bam[,s2_rep2.bam]'
    inputBinding:
      position: 101
      prefix: --b2
  - id: sample2_sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'sample_2 sam files: s2_rep1.sam[,s2_rep2.sam]'
    inputBinding:
      position: 101
      prefix: --s2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmats2sashimiplot:3.0.0--py39hdff8610_2
stdout: rmats2sashimiplot.out
