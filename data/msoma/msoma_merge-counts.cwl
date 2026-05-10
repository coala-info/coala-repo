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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to write merged counts file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
