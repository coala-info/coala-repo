cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msoma
  - merge-counts
label: msoma_merge-counts
doc: "Merge count files into a single count file\n\nTool homepage: https://github.com/AkeyLab/mSOMA"
inputs:
  - id: count_paths
    type:
      type: array
      items: File
    doc: Paths to count files to merge
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to write merged counts file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
