cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint-cut
label: tigmint_tigmint-cut
doc: "Find misassembled regions in assembly using Chromium molecule extents\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: fasta
    type: File
    doc: "Reference genome fasta file (must have FAI index generated)"
    inputBinding:
      position: 1
    secondaryFiles:
      - .fai
  - id: bed
    type: File
    doc: "Sorted bed file of molecule extents"
    inputBinding:
      position: 2
  - id: fastaout
    type: string
    doc: "The output FASTA file."
    inputBinding:
      position: 100
      prefix: --fastaout
  - id: bedout
    type:
      - 'null'
      - string
    doc: "The output BED file. Default is the output FASTA filename plus .bed"
    inputBinding:
      position: 101
      prefix: --bedout
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of parallel processes to launch [8]"
    inputBinding:
      position: 102
      prefix: --processes
  - id: window
    type:
      - 'null'
      - int
    doc: "Window size used to check for spanning molecules (bp) [1000]"
    inputBinding:
      position: 103
      prefix: --window
  - id: spanning
    type:
      - 'null'
      - int
    doc: "Spanning molecules threshold (no misassembly in window if num. spanning molecules >= n) [2]."
    inputBinding:
      position: 104
      prefix: --spanning
  - id: trim
    type:
      - 'null'
      - int
    doc: "Number of base pairs to trim at contig cuts (bp) [0]"
    inputBinding:
      position: 105
      prefix: --trim
  - id: param_file
    type:
      - 'null'
      - File
    doc: "File containing calculated parameters for tigmint-long"
    inputBinding:
      position: 106
      prefix: --param_file
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum contig length for tallying attempted corrections (bp) [3000]"
    inputBinding:
      position: 107
      prefix: --min_length
outputs:
  - id: output_fasta
    type: File
    doc: "The output FASTA file."
    outputBinding:
      glob: $(inputs.fastaout)
  - id: output_bed
    type: File
    doc: "The output BED file of cut points."
    outputBinding:
      glob: $(inputs.bedout || inputs.fastaout + '.bed')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
