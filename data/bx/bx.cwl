cwlVersion: v1.2
class: CommandLineTool
baseCommand: bx
label: bx
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull or run the 'bx' tool due to insufficient
  disk space. It does not contain the actual help text or usage information for the
  tool.\n\nTool homepage: https://github.com/stevenwanderski/bxslider-4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bx:v0.8.2-1-deb-py3_cv1
stdout: bx.out
