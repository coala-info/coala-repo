cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqc
label: fastqc
doc: "The provided text does not contain help information for FastQC; it is an error
  log indicating a failure to build or run the container due to insufficient disk
  space ('no space left on device').\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0
stdout: fastqc.out
