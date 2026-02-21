cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa-assembly
label: jaffa_jaffa-assembly
doc: "JAFFA (Just Another Fusion Finder) is a pipeline for identifying fusion genes
  from RNA-seq data. The assembly mode is designed for high sensitivity and to identify
  novel fusions.\n\nTool homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_jaffa-assembly.out
