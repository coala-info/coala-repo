cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller-parse
label: epimuller_epimuller-parse
doc: "A tool from the epimuller suite (description not available in the provided text).\n
  \nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller_epimuller-parse.out
