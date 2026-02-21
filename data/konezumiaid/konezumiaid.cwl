cwlVersion: v1.2
class: CommandLineTool
baseCommand: konezumiaid
label: konezumiaid
doc: "A tool for processing genomic data (description not provided in help text)\n
  \nTool homepage: https://github.com/aki2274/KOnezumi-AID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
stdout: konezumiaid.out
