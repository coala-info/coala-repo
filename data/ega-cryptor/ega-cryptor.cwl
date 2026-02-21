cwlVersion: v1.2
class: CommandLineTool
baseCommand: ega-cryptor
label: ega-cryptor
doc: "A tool for encrypting and preparing data for submission to the European Genome-phenome
  Archive (EGA).\n\nTool homepage: https://ega-archive.org/submission/data/file-preparation/egacryptor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ega-cryptor:2.0.0--hdfd78af_0
stdout: ega-cryptor.out
