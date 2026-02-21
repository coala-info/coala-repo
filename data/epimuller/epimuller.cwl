cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller
label: epimuller
doc: "epimuller\n\nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller.out
