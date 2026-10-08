cwlVersion: v1.2
class: CommandLineTool
baseCommand: Histex
label: fastk_Histex
doc: "Shows a k-mer count histogram made by FastK.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: $(inputs.histogram.basename)
inputs:
  - id: histogram
    type: File
    doc: Histogram file (.hist) made by FastK.
  - id: range
    type:
      - 'null'
      - string
    doc: 'Output histogram of counts in range given: [<int>:]<int>.'
    inputBinding:
      position: 50
      prefix: '-h'
      separate: false
  - id: kmer_instances
    type:
      - 'null'
      - boolean
    doc: Output histogram of k-mer instance counts (vs. unique k-mers).
    inputBinding:
      position: 50
      prefix: '-k'
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Output in simple tab-delimited ASCII format.
    inputBinding:
      position: 50
      prefix: '-A'
  - id: genescope
    type:
      - 'null'
      - boolean
    doc: Output an ASCII format histogram especially for GeneScope.FK.
    inputBinding:
      position: 50
      prefix: '-G'
  - id: one_code
    type:
      - 'null'
      - boolean
    doc: Output in 1-code.
    inputBinding:
      position: 50
      prefix: '-1'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.histogram)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Histex.out
