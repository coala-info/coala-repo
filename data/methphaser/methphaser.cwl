cwlVersion: v1.2
class: CommandLineTool
baseCommand: methphaser
label: methphaser
doc: "Note: The provided text is a container runtime error log (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space. It does not contain
  the tool's help text or argument definitions.\n\nTool homepage: https://github.com/treangenlab/methphaser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
stdout: methphaser.out
