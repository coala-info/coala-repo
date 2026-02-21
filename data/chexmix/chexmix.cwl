cwlVersion: v1.2
class: CommandLineTool
baseCommand: chexmix
label: chexmix
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: http://mahonylab.org/software/chexmix/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chexmix:0.52--hdfd78af_0
stdout: chexmix.out
