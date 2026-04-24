cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - scoredist
label: methylartist_scoredist
doc: "Plot the distribution of modification scores from methylartist databases or
  BAM files.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: one or more .bam files with MM and ML tags for modification calls (see 
      samtags spec)
    inputBinding:
      position: 101
      prefix: --bam
  - id: db
    type:
      - 'null'
      - File
    doc: methylartist database(s), can be comma-delimited
    inputBinding:
      position: 101
      prefix: --db
  - id: lw
    type:
      - 'null'
      - int
    doc: line width
    inputBinding:
      position: 101
      prefix: --lw
  - id: mod
    type: string
    doc: modification to plot (will list for user if incorrect)
    inputBinding:
      position: 101
      prefix: --mod
  - id: motif
    type:
      - 'null'
      - string
    doc: modified motif to highlight (e.g. CG)
    inputBinding:
      position: 101
      prefix: --motif
  - id: palette
    type:
      - 'null'
      - string
    doc: palette for phases, see 
      https://seaborn.pydata.org/tutorial/color_palettes.html
    inputBinding:
      position: 101
      prefix: --palette
  - id: ref
    type:
      - 'null'
      - File
    doc: reference genome fasta (samtools faidx indexed)
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_size
    type:
      - 'null'
      - int
    doc: sample size
    inputBinding:
      position: 101
      prefix: --n
  - id: svg
    type:
      - 'null'
      - boolean
    doc: Save output in SVG format
    inputBinding:
      position: 101
      prefix: --svg
  - id: xmax
    type:
      - 'null'
      - float
    doc: Maximum x-axis value
    inputBinding:
      position: 101
      prefix: --xmax
  - id: xmin
    type:
      - 'null'
      - float
    doc: Minimum x-axis value
    inputBinding:
      position: 101
      prefix: --xmin
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'output file name (default: generated from input)'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
