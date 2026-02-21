cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybran
label: hybran
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool 'hybran'.\n
  \nTool homepage: https://lpcdrp.gitlab.io/hybran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybran:1.9--pyhdfd78af_0
stdout: hybran.out
