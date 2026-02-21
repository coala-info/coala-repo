cwlVersion: v1.2
class: CommandLineTool
baseCommand: gqlib
label: gqlib
doc: "The provided text does not contain help information or usage instructions for
  gqlib; it contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the gqlib image due to lack of disk space.\n\nTool homepage: https://github.com/cschu/gqlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqlib:2.14.4--pyhdfd78af_0
stdout: gqlib.out
