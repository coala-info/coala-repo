cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa
label: fraposa-pgsc_fraposa
doc: "Fast Robust Ancestry Prediction of Samples with Arbitrary ancestry. (Note: The
  provided text contains container runtime error messages and does not include help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa.out
