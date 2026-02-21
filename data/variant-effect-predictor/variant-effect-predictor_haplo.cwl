cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplo
label: variant-effect-predictor_haplo
doc: "Haplotype tool for Variant Effect Predictor (Note: The provided text contains
  container build errors and no help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/Ensembl/ensembl-vep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant-effect-predictor:87--pl5.22.0_1
stdout: variant-effect-predictor_haplo.out
