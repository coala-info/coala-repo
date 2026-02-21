cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes-merge
label: tandem-genotypes_tandem-genotypes-merge
doc: "The provided text does not contain help information for the tool. It contains
  Apptainer/Singularity runtime logs and a fatal error message regarding image fetching.\n
  \nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes_tandem-genotypes-merge.out
