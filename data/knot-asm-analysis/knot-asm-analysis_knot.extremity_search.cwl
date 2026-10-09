cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.extremity_search
label: knot-asm-analysis_knot.extremity_search
doc: "Search the reads that lie at the contig extremities\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: read2tig
    type: File
    doc: read mapped against asm
    inputBinding:
      position: 1
  - id: read2read
    type: File
    doc: SG graph
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: file where extremity are writed
    inputBinding:
      position: 3
outputs:
  - id: extremities
    type: File
    doc: extremity table
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
