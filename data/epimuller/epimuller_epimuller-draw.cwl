cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller-draw
label: epimuller_epimuller-draw
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log. No arguments could be extracted.\n\nTool
  homepage: https://github.com/jennifer-bio/epimuller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller_epimuller-draw.out
