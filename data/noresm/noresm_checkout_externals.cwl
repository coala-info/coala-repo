cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_checkout_externals
label: noresm_checkout_externals
doc: "Checkout external components for the Norwegian Earth System Model (NorESM).
  Note: The provided text contains execution logs and a fatal error regarding disk
  space rather than help documentation.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_checkout_externals.out
