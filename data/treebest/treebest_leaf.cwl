cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - leaf
label: treebest_leaf
doc: "TreeBest leaf command (Note: The provided help text indicates the tool failed
  to recognize the --help flag and instead attempted to open it as a file).\n\nTool
  homepage: https://github.com/lh3/treebest"
inputs:
  - id: input_file
    type: File
    doc: Input file (inferred from error message attempting to open positional argument)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_leaf.out
