cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa-pgsc
label: fraposa-pgsc
doc: "Fast Robust Ancestry Prediction of Samples with Arbitrary ancestry (PGS Catalog
  version). Note: The provided text appears to be a container execution error log
  rather than help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc.out
