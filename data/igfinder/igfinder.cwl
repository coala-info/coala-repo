cwlVersion: v1.2
class: CommandLineTool
baseCommand: igfinder
label: igfinder
doc: "The provided text does not contain help documentation for igfinder; it is an
  error log indicating a failure to build a Singularity/Apptainer container due to
  insufficient disk space.\n\nTool homepage: https://tx.bioreg.kyushu-u.ac.jp/igfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igfinder:1.0--pyhdfd78af_0
stdout: igfinder.out
