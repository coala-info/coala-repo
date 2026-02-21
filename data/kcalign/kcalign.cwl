cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcalign
label: kcalign
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space. It does not contain help text or argument definitions for the kcalign tool.\n
  \nTool homepage: https://github.com/davebx/kc-align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcalign:1.0.2--py_0
stdout: kcalign.out
