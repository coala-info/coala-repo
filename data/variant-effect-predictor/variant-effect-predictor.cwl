cwlVersion: v1.2
class: CommandLineTool
baseCommand: variant-effect-predictor
label: variant-effect-predictor
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container image build/fetch process.\n\nTool homepage: https://github.com/Ensembl/ensembl-vep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant-effect-predictor:87--pl5.22.0_1
stdout: variant-effect-predictor.out
