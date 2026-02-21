cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmer_caller
label: genometester_gmer_caller
doc: "The provided help text contains only system error messages related to a container
  runtime failure (no space left on device) and does not contain usage information
  for the tool.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_gmer_caller.out
