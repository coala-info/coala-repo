cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv
label: checkv
doc: "CheckV is a tool for assessing the quality of metagenome-assembled viral genomes
  (Note: The provided help text contains only system error logs and no usage information).\n
  \nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
stdout: checkv.out
