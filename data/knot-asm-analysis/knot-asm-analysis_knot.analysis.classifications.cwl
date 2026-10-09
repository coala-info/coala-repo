cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.analysis.classifications
label: knot-asm-analysis_knot.analysis.classifications
doc: "Classify the paths between contig extremities of an assembly-assembly graph (AAG)\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: input
    type: File
    doc: path to the AAG
    inputBinding:
      position: 101
      prefix: --input
  - id: threshold
    type:
      - 'null'
      - int
    doc: path length threshold
    inputBinding:
      position: 101
      prefix: --threshold
  - id: output_path
    type: string
    doc: path where classification report was write
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: classification report
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
