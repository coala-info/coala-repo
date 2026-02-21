cwlVersion: v1.2
class: CommandLineTool
baseCommand: gget
label: gget
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the 'gget' tool.\n
  \nTool homepage: https://github.com/pachterlab/gget"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
stdout: gget.out
