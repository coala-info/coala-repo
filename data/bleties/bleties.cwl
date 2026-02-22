cwlVersion: v1.2
class: CommandLineTool
baseCommand: bleties
label: bleties
doc: "The provided text contains error messages related to a container environment
  (Singularity/Docker) and does not contain the help text or usage information for
  the 'bleties' tool. As a result, no arguments could be extracted.\n\nTool homepage:
  https://github.com/Swart-lab/bleties"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_1
stdout: bleties.out
