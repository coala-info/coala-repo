cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minute
  - download
label: minute_download
doc: "Downloads libraries from a TSV file.\n\nTool homepage: https://github.com/NBISweden/minute/"
inputs:
  - id: libraries_file
    type: File
    doc: Path to the TSV file containing library information.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
stdout: minute_download.out
