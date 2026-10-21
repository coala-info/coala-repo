cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- index
label: samtools_index
doc: 'Index a coordinate-sorted BAM or CRAM file for fast random access


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - '$(inputs.input_files ? inputs.input_files : [])'
  - '$(inputs.input_file ? inputs.input_file : [])'
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
arguments:
- position: 3
  prefix: -o
  valueFrom: '$(inputs.multiple_files ? null : (inputs.output || (inputs.input_file.basename + (/[.]cram$/i.test(inputs.input_file.basename) ? ''.crai'' : (inputs.csi ? ''.csi'' : ''.bai'')))))'
inputs:
- id: input_file
  type:
  - 'null'
  - File
  doc: Alignment file to index (single-file mode; staged so the index can be written).
  inputBinding:
    position: 5
- id: input_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Alignment files to index with multiple_files (-M); each index is written next to the staged copy.
  inputBinding:
    position: 6
- id: output
  type:
  - 'null'
  - string
  doc: Name of the index file (-o); default is the input name plus .bai, .csi or .crai.
- id: bai
  type:
  - 'null'
  - boolean
  doc: Generate BAI-format index for BAM files [default].
  inputBinding:
    position: 2
    prefix: --bai
- id: csi
  type:
  - 'null'
  - boolean
  doc: Generate CSI-format index for BAM files.
  inputBinding:
    position: 2
    prefix: --csi
- id: min_shift
  type:
  - 'null'
  - int
  doc: Set minimum interval size for CSI indices to 2^INT [14].
  inputBinding:
    position: 2
    prefix: --min-shift
- id: multiple_files
  type:
  - 'null'
  - boolean
  doc: Interpret all filename arguments as files to be indexed (-M).
  inputBinding:
    position: 2
    prefix: -M
- id: threads
  type:
  - 'null'
  - int
  doc: Sets the number of additional threads [0].
  inputBinding:
    position: 2
    prefix: --threads
outputs:
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the single input file.
  outputBinding:
    glob:
    - '$(inputs.output || (inputs.input_file ? inputs.input_file.basename + (/[.]cram$/i.test(inputs.input_file.basename) ? ''.crai'' : (inputs.csi ? ''.csi'' : ''.bai'')) : ''none''))'
- id: output_indexes
  type:
  - 'null'
  - type: array
    items: File
  doc: Indexes written in multiple_files mode.
  outputBinding:
    glob:
    - '*.bai'
    - '*.csi'
    - '*.crai'
    outputEval: '$(inputs.multiple_files ? self : null)'
