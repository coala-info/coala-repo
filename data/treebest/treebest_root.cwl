cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - root
label: treebest_root
doc: "Root a phylogenetic tree. (Note: The provided help text was an error message
  indicating the tool does not support --help and instead expected a file path.)\n
  \nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: input_file
    type: File
    doc: Input tree file (inferred from error message)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_root.out
