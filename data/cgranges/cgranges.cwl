cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgranges
label: cgranges
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' failure during image extraction.\n\nTool
  homepage: https://github.com/lh3/cgranges"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgranges:0.1.1--py39hbcbf7aa_3
stdout: cgranges.out
