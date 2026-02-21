cwlVersion: v1.2
class: CommandLineTool
baseCommand: genotypy
label: genotypy
doc: "A tool for genotyping (description not available in provided text due to execution
  error).\n\nTool homepage: https://gitbio.ens-lyon.fr/LBMC/yvertlab/vortex/plasticity_mutation/colony_rnaseq_bioinformatics/genotypy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genotypy:0.3.4--pyhdfd78af_0
stdout: genotypy.out
