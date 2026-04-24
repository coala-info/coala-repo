cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfsort
label: gtfsort
doc: "An optimized chr/pos/feature GTF2.5-3 sorter using a lexicographic-based index
  ordering algorithm written in Rust.\n\nTool homepage: https://github.com/alejandrogzi/gtfsort"
inputs:
  - id: input
    type: File
    doc: Path to unsorted GTF file
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Path to output sorted GTF file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtfsort:0.2.2--ha6fb395_2
