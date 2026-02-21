cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge
label: centrifuge-core_centrifuge
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the Apptainer/Singularity container due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/infphilo/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge.out
