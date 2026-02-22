cwlVersion: v1.2
class: CommandLineTool
baseCommand: patchwork
label: patchwork_ssb-patchwork
doc: "The provided help text indicates a fatal error while attempting to run the tool
  via a container URI and does not contain usage information or argument definitions.
  No arguments could be extracted.\n\nTool homepage: https://github.com/ssbc/patchwork"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/patchwork:0.5.0_cv1
stdout: patchwork_ssb-patchwork.out
