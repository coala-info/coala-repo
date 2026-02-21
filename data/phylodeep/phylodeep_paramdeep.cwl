cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylodeep_paramdeep
label: phylodeep_paramdeep
doc: "A tool from the phylodeep suite (Note: The provided help text contains only
  container execution logs and an error message, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/evolbioinfo/phylodeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
stdout: phylodeep_paramdeep.out
