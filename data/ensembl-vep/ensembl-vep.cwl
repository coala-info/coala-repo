cwlVersion: v1.2
class: CommandLineTool
baseCommand: vep
label: ensembl-vep
doc: "The Ensembl Variant Effect Predictor (VEP) determines the effect of your variants
  on genes, transcripts, and protein sequence, as well as regulatory regions.\n\n
  Tool homepage: https://www.ensembl.org/info/docs/tools/vep/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_0
stdout: ensembl-vep.out
