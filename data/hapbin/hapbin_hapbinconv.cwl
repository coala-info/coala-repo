cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapbinconv
label: hapbin_hapbinconv
doc: "A tool for converting files for use with hapbin. (Note: The provided help text
  contains only system error messages and does not list specific arguments.)\n\nTool
  homepage: https://github.com/evotools/hapbin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
stdout: hapbin_hapbinconv.out
