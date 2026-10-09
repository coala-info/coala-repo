cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.filter_tig
label: knot-asm-analysis_knot.filter_tig
doc: "Filter contigs by length: only sequences longer than the threshold are written\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: input
    type: File
    doc: input fasta
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output fasta
    inputBinding:
      position: 3
  - id: threshold
    type:
      - 'null'
      - int
    doc: Only sequence with size upper than threshold are write in output default 100.000
    inputBinding:
      position: 1
      prefix: --threshold
outputs:
  - id: filtered_fasta
    type: File
    doc: filtered contigs
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
