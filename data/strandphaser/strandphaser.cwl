cwlVersion: v1.2
class: CommandLineTool
baseCommand: strandphaser
label: strandphaser
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or documentation for the tool 'strandphaser'.\n
  \nTool homepage: https://github.com/daewoooo/StrandPhaseR/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strandphaser:1.0.2--r44hdfd78af_2
stdout: strandphaser.out
