cwlVersion: v1.2
class: CommandLineTool
baseCommand: konezumiaid batch
label: konezumiaid_batch
doc: "\nTool homepage: https://github.com/aki2274/KOnezumi-AID"
inputs:
  - id: file
    type: File
    doc: Path to the gene CSV or Excel file
    inputBinding:
      position: 101
      prefix: --file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
stdout: konezumiaid_batch.out
