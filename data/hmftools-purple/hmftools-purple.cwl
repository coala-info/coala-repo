cwlVersion: v1.2
class: CommandLineTool
baseCommand: purple
label: hmftools-purple
doc: "PURPLE (Purity and Ploidy Estimator) is a somatic copy number caller for human
  whole genome sequencing data.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/purity-ploidy-estimator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-purple:4.3--hdfd78af_0
stdout: hmftools-purple.out
