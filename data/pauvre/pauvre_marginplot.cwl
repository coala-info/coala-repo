cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pauvre
  - marginplot
label: pauvre_marginplot
doc: "Generate a margin plot of read length versus quality from FASTQ files.\n\nTool
  homepage: https://github.com/conchoecia/gloTK"
inputs:
  - id: add_yaxes
    type:
      - 'null'
      - boolean
    doc: Add Y-axes to both marginal histograms.
    inputBinding:
      position: 101
      prefix: --add-yaxes
  - id: dpi
    type:
      - 'null'
      - int
    doc: Change the dpi from the default 600 if you need it higher
    inputBinding:
      position: 101
      prefix: --dpi
  - id: fastq
    type:
      - 'null'
      - File
    doc: The input FASTQ file.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fileform
    type:
      - 'null'
      - type: array
        items: string
    doc: Which output format would you like? Def.=png
    inputBinding:
      position: 101
      prefix: --fileform
  - id: filt_maxlen
    type:
      - 'null'
      - int
    doc: This sets the max read length filter reads.
    inputBinding:
      position: 101
      prefix: --filt_maxlen
  - id: filt_maxqual
    type:
      - 'null'
      - float
    doc: This sets the max mean read quality to filter reads.
    inputBinding:
      position: 101
      prefix: --filt_maxqual
  - id: filt_minlen
    type:
      - 'null'
      - int
    doc: This sets the min read length to filter reads.
    inputBinding:
      position: 101
      prefix: --filt_minlen
  - id: filt_minqual
    type:
      - 'null'
      - float
    doc: This sets the min mean read quality to filter reads.
    inputBinding:
      position: 101
      prefix: --filt_minqual
  - id: kmerdf
    type:
      - 'null'
      - File
    doc: Pass the filename of a data matrix if you would like to plot read length
      versus number of kmers in that read.
    inputBinding:
      position: 101
      prefix: --kmerdf
  - id: lengthbin
    type:
      - 'null'
      - int
    doc: This sets the bin size to use for length.
    inputBinding:
      position: 101
      prefix: --lengthbin
  - id: no_timestamp
    type:
      - 'null'
      - boolean
    doc: Turn off time stamps in the filename output.
    inputBinding:
      position: 101
      prefix: --no_timestamp
  - id: no_transparent
    type:
      - 'null'
      - boolean
    doc: Specify this option if you don't want a transparent background. Default is
      on.
    inputBinding:
      position: 101
      prefix: --no_transparent
  - id: plot_maxlen
    type:
      - 'null'
      - int
    doc: Sets the maximum viewing area in the length dimension.
    inputBinding:
      position: 101
      prefix: --plot_maxlen
  - id: plot_maxqual
    type:
      - 'null'
      - float
    doc: Sets the maximum viewing area in the quality dimension.
    inputBinding:
      position: 101
      prefix: --plot_maxqual
  - id: plot_minlen
    type:
      - 'null'
      - int
    doc: Sets the minimum viewing area in the length dimension.
    inputBinding:
      position: 101
      prefix: --plot_minlen
  - id: plot_minqual
    type:
      - 'null'
      - float
    doc: Sets the minimum viewing area in the quality dimension.
    inputBinding:
      position: 101
      prefix: --plot_minqual
  - id: qualbin
    type:
      - 'null'
      - float
    doc: This sets the bin size to use for quality
    inputBinding:
      position: 101
      prefix: --qualbin
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: title
    type:
      - 'null'
      - string
    doc: This sets the title for the whole plot.
    inputBinding:
      position: 101
      prefix: --title
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
