cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-3n
label: hisat2_hisat-3n
doc: "The provided text does not contain help information. It is an error log indicating
  a failure to build or run the container (no space left on device).\n\nTool homepage:
  http://daehwankimlab.github.io/hisat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2_hisat-3n.out
