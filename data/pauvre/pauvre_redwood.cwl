cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pauvre
  - redwood
label: pauvre_redwood
doc: "Plot long reads and RNA-seq data in a circular 'redwood' plot, often used for
  mitochondrial genomes.\n\nTool homepage: https://github.com/conchoecia/gloTK"
inputs:
  - id: doubled
    type:
      - 'null'
      - type: array
        items: string
    doc: If your fasta file was doubled to map circularly, use this flag or you may
      encounter plotting errors. Accepts multiple arguments. 'main' is for the sam
      file passed with --sam, 'rnaseq' is for the sam file passed with --rnaseq
    inputBinding:
      position: 101
      prefix: --doubled
  - id: dpi
    type:
      - 'null'
      - int
    doc: Change the dpi from the default 600 if you need it higher
    inputBinding:
      position: 101
      prefix: --dpi
  - id: fileform
    type:
      - 'null'
      - type: array
        items: string
    doc: Which output format would you like? Def.=png
    inputBinding:
      position: 101
      prefix: --fileform
  - id: gff
    type:
      - 'null'
      - File
    doc: The input filepath for the gff annotation to plot
    inputBinding:
      position: 101
      prefix: --gff
  - id: interlace
    type:
      - 'null'
      - boolean
    doc: Interlace the reads so the pileup plot looks better. Doesn't work currently
    inputBinding:
      position: 101
      prefix: --interlace
  - id: invert
    type:
      - 'null'
      - boolean
    doc: invert the image so that it looks better on a dark background. DOESN'T DO
      ANYTHING.
    inputBinding:
      position: 101
      prefix: --invert
  - id: log
    type:
      - 'null'
      - boolean
    doc: Plot the RNAseq track with a log scale
    inputBinding:
      position: 101
      prefix: --log
  - id: main_bam
    type:
      - 'null'
      - File
    doc: The input filepath for the bam file to plot. Ideally was plotted with a fasta
      file that is two copies of the mitochondrial genome concatenated.
    inputBinding:
      position: 101
      prefix: --main_bam
  - id: no_timestamp
    type:
      - 'null'
      - boolean
    doc: Turn off time stamps in the filename output.
    inputBinding:
      position: 101
      prefix: --no_timestamp
  - id: query
    type:
      - 'null'
      - type: array
        items: string
    doc: Query your reads to change plotting options
    inputBinding:
      position: 101
      prefix: --query
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rnaseq_bam
    type:
      - 'null'
      - File
    doc: The input filepath for the rnaseq bam file to plot
    inputBinding:
      position: 101
      prefix: --rnaseq_bam
  - id: small_start
    type:
      - 'null'
      - string
    doc: 'This determines where the shortest of the filtered reads will appear on
      the redwood plot: on the outside or on the inside? Default puts longest on outside.'
    inputBinding:
      position: 101
      prefix: --small_start
  - id: sort
    type:
      - 'null'
      - string
    doc: What value to use to sort the order in which the reads are plotted? (ALNLEN,
      TRULEN, MAPLEN, POS)
    inputBinding:
      position: 101
      prefix: --sort
  - id: ticks
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify control for the number of ticks.
    inputBinding:
      position: 101
      prefix: --ticks
  - id: transparent
    type:
      - 'null'
      - boolean
    doc: Specify this option if you DON'T want a transparent background. Default is
      on.
    inputBinding:
      position: 101
      prefix: --transparent
outputs:
  - id: output_base_name
    type:
      - 'null'
      - File
    doc: Specify a base name for the output file(s). The input file base name is the
      default.
    outputBinding:
      glob: $(inputs.output_base_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauvre:0.1924--py_0
