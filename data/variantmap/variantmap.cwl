cwlVersion: v1.2
class: CommandLineTool
baseCommand: variantmap
label: variantmap
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool 'variantmap'.\n
  \nTool homepage: https://github.com/cytham/variantmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantmap:1.0.2--py_0
stdout: variantmap.out
