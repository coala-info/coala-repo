cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysam_bcftools
label: pysam_bcftools
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of log messages and a fatal error related to a container build
  process.\n\nTool homepage: https://github.com/pysam-developers/pysam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysam:0.23.3--py39hdd5828d_1
stdout: pysam_bcftools.out
