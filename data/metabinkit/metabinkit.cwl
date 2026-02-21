cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinkit
label: metabinkit
doc: "A tool for metagenomic binning (Note: The provided text contains container execution
  errors rather than help documentation, so no arguments could be extracted).\n\n
  Tool homepage: https://github.com/envmetagen/metabinkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
stdout: metabinkit.out
