cwlVersion: v1.2
class: CommandLineTool
baseCommand: metanovo
label: metanovo
doc: "Metanovo is a pipeline for the automated discovery of novel peptides from metaproteomic
  data.\n\nTool homepage: https://github.com/uct-cbio/proteomics-pipelines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metanovo:1.9.4--py39hdfd78af_10
stdout: metanovo.out
