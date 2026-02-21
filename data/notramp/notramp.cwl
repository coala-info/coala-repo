cwlVersion: v1.2
class: CommandLineTool
baseCommand: notramp
label: notramp
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'notramp'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/simakro/NoTrAmp.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/notramp:1.1.9--pyh7e72e81_0
stdout: notramp.out
