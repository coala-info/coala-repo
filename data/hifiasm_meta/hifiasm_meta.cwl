cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifiasm_meta
label: hifiasm_meta
doc: "The provided text does not contain help information for hifiasm_meta. It contains
  system error logs related to a container runtime (Singularity/Apptainer) failing
  to pull a docker image due to insufficient disk space.\n\nTool homepage: https://github.com/xfengnefx/hifiasm-meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifiasm:0.25.0--h5ca1c30_0
stdout: hifiasm_meta.out
