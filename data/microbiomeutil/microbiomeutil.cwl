cwlVersion: v1.2
class: CommandLineTool
baseCommand: microbiomeutil
label: microbiomeutil
doc: "Microbiome Analysis Utilities (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/microsud/microbiomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/microbiomeutil:v20101212dfsg1-2-deb_cv1
stdout: microbiomeutil.out
