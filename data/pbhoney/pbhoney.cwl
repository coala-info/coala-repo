cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbhoney
label: pbhoney
doc: "The provided text contains system error messages related to a Singularity/Docker
  container execution failure ('no space left on device') and does not contain the
  actual help text or usage information for the pbhoney tool.\n\nTool homepage: https://github.com/shokrof/pbhoney"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbhoney:v15.8.24dfsg-3-deb_cv1
stdout: pbhoney.out
