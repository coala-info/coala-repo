cwlVersion: v1.2
class: CommandLineTool
baseCommand: vep
label: variant-effect-predictor_vep
doc: "Variant Effect Predictor (VEP) determines the effect of your variants on genes,
  transcripts, and protein sequence, as well as regulatory regions.\n\nTool homepage:
  https://github.com/Ensembl/ensembl-vep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant-effect-predictor:87--pl5.22.0_1
stdout: variant-effect-predictor_vep.out
