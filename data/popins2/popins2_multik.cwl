cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, multik]
label: popins2_multik
doc: "Multi-k framework for a colored and compacted de Bruijn graph (CCDBG).\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: sample_path
    type: Directory
    doc: "Source directory with FASTA/Q files"
    inputBinding:
      position: 1
      prefix: --sample-path
  - id: temp_path
    type:
      - 'null'
      - string
    doc: "Auxiliary directory for temporary files. Default: auxMultik"
    inputBinding:
      position: 1
      prefix: --temp-path
  - id: outputfile_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the output files. Default: ccdbg"
    inputBinding:
      position: 1
      prefix: --outputfile-prefix
  - id: k_init
    type:
      - 'null'
      - int
    doc: "Initial kmer length to start the multi-k iteration. Default: 27"
    inputBinding:
      position: 1
      prefix: --k-init
  - id: k_max
    type:
      - 'null'
      - int
    doc: "Maximal kmer length to build a dBG with. Default: 127"
    inputBinding:
      position: 1
      prefix: --k-max
  - id: delta_k
    type:
      - 'null'
      - int
    doc: "Step size to increase k. Default: 20"
    inputBinding:
      position: 1
      prefix: --delta-k
outputs:
  - id: ccdbg_files
    type:
      type: array
      items: File
    doc: "Graph and color files"
    outputBinding:
      glob: "${return (inputs.outputfile_prefix || 'ccdbg') + '*';}"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_multik.log
