cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm
label: checkm-genome_checkm
doc: "CheckM is a tool for assessing the quality of microbial genome bins.\n\nTool
  homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., tree, qa, lineage_wf)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_checkm.out
