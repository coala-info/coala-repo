cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimmomatic
label: trimmomatic
doc: "The provided text does not contain help information for trimmomatic; it is a
  system error log indicating a failure to build or extract a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://www.plabipd.de/trimmomatic_main.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimmomatic:0.40--hdfd78af_0
stdout: trimmomatic.out
