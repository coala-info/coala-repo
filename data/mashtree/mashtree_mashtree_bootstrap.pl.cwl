cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashtree_bootstrap.pl
label: mashtree_mashtree_bootstrap.pl
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to build a Singularity/Apptainer container
  due to lack of disk space.\n\nTool homepage: https://github.com/lskatz/mashtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashtree:1.4.6--pl5321h7b50bb2_3
stdout: mashtree_mashtree_bootstrap.pl.out
