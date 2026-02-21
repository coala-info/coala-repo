cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_vep
label: variant-effect-predictor_filter_vep
doc: "Filter results from the Variant Effect Predictor (VEP).\n\nTool homepage: https://github.com/Ensembl/ensembl-vep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant-effect-predictor:87--pl5.22.0_1
stdout: variant-effect-predictor_filter_vep.out
