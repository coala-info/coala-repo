cwlVersion: v1.2
class: CommandLineTool
baseCommand: variant_recoder
label: variant-effect-predictor_variant_recoder
doc: "The provided text is an error log from a container execution environment (Singularity/Apptainer)
  and does not contain the help text or usage information for the tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/Ensembl/ensembl-vep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant-effect-predictor:87--pl5.22.0_1
stdout: variant-effect-predictor_variant_recoder.out
