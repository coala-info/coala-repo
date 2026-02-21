cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa_bpipe
label: jaffa_bpipe
doc: "JAFFA is a pipeline for identifying fusion genes from RNA-seq data.\n\nTool
  homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_bpipe.out
