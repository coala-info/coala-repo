cwlVersion: v1.2
class: CommandLineTool
baseCommand: tool-generic_filter
label: tool-generic_filter
doc: "A tool for generic filtering. (Note: The provided text appears to be a container
  build log rather than CLI help text, so no arguments could be extracted.)\n\nTool
  homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tool-generic_filter:phenomenal-vphenomenal_2017.12.12_cv0.2.3
stdout: tool-generic_filter.out
