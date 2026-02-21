cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboseqc
label: riboseqc
doc: "A tool for Ribo-seq quality control and analysis. (Note: The provided text contains
  system logs and error messages rather than command-line usage instructions; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/ohlerlab/RiboseQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseqc:1.1--r36_1
stdout: riboseqc.out
