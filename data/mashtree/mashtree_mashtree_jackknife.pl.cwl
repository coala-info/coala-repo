cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashtree_jackknife.pl
label: mashtree_mashtree_jackknife.pl
doc: "A tool for jackknifing with Mashtree. Note: The provided help text contains
  only system error messages regarding container execution and no usage information
  was available to parse.\n\nTool homepage: https://github.com/lskatz/mashtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashtree:1.4.6--pl5321h7b50bb2_3
stdout: mashtree_mashtree_jackknife.pl.out
