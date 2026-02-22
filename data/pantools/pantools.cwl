cwlVersion: v1.2
class: CommandLineTool
baseCommand: pantools
label: pantools
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools.out
