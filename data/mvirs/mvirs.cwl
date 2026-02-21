cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvirs
label: mvirs
doc: "The provided text contains container runtime error logs (Apptainer/Singularity)
  rather than the help documentation for the mvirs tool. As a result, no arguments
  or tool descriptions could be extracted.\n\nTool homepage: https://github.com/SushiLab/mVIRs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
stdout: mvirs.out
