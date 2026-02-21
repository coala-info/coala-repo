cwlVersion: v1.2
class: CommandLineTool
baseCommand: cvlr
label: cvlr
doc: "The provided text does not contain help information for the tool 'cvlr'. It
  is a log of a failed container build process (Apptainer/Singularity) that terminated
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/EmanueleRaineri/releases/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvlr:1.0--h61e1b1b_6
stdout: cvlr.out
