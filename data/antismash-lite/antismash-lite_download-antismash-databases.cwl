cwlVersion: v1.2
class: CommandLineTool
baseCommand: download-antismash-databases
label: antismash-lite_download-antismash-databases
doc: "Download antiSMASH databases\n\nTool homepage: https://docs.antismash.secondarymetabolites.org/intro/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antismash-lite:8.0.1--pyhdfd78af_0
stdout: antismash-lite_download-antismash-databases.out
