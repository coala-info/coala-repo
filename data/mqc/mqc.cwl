cwlVersion: v1.2
class: CommandLineTool
baseCommand: mqc
label: mqc
doc: "The provided text does not contain help information for the tool 'mqc'. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/Biobix/mQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mqc:1.10--py27pl5.22.0r3.4.1_0
stdout: mqc.out
