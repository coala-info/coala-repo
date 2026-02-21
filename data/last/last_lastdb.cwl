cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastdb
label: last_lastdb
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space. It does
  not contain the help text or argument definitions for the 'lastdb' tool.\n\nTool
  homepage: https://gitlab.com/mcfrith/last"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_lastdb.out
