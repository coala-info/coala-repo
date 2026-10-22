cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtmer
label: smartdenovo_wtmer
doc: "WTMER: K-mer analysis of long reads (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: long_reads
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
    doc: "Long reads sequences file, +, *"
    inputBinding:
      position: 101
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite"
    inputBinding:
      position: 101
      prefix: -f
  - id: no_homopolymer_compression
    type:
      - 'null'
      - boolean
    doc: "Disable homopolymer compression"
    inputBinding:
      position: 101
      prefix: -H
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "Kmer size, 5 <= <-k> <= 16, [16]"
    inputBinding:
      position: 101
      prefix: -k
  - id: output_path
    type: string
    doc: "Output file of kmer_frequency, *"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "K-mer frequency table"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
