cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller-define
label: epimuller_epimuller-define
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller_epimuller-define.out
