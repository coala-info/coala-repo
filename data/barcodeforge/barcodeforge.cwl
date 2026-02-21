cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcodeforge
label: barcodeforge
doc: "The provided text does not contain help information or usage instructions for
  barcodeforge. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/andersen-lab/BarcodeForge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcodeforge:1.1.2--pyhdfd78af_0
stdout: barcodeforge.out
