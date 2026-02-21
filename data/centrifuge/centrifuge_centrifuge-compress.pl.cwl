cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-compress.pl
label: centrifuge_centrifuge-compress.pl
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to extract the image due to lack of disk space.\n\nTool homepage: https://github.com/DaehwanKimLab/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
stdout: centrifuge_centrifuge-compress.pl.out
