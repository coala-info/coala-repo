cwlVersion: v1.2
class: CommandLineTool
baseCommand: dadaist2
label: dadaist2
doc: "DADAist2 is a wrapper for the DADA2 pipeline for analyzing ribosomal amplicons.\n
  \nTool homepage: https://github.com/quadram-institute-bioscience/dadaist2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dadaist2:1.3.1--hdfd78af_2
stdout: dadaist2.out
