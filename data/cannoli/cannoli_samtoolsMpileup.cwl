cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - samtoolsMpileup
label: cannoli_samtoolsMpileup
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_samtoolsMpileup.out
