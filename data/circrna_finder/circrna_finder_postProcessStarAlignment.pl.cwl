cwlVersion: v1.2
class: CommandLineTool
baseCommand: circrna_finder_postProcessStarAlignment.pl
label: circrna_finder_postProcessStarAlignment.pl
doc: "A script to post-process STAR alignment results for circRNA identification.
  Note: The provided help text contained only system error messages regarding container
  extraction and did not list specific command-line arguments.\n\nTool homepage: https://github.com/orzechoj/circRNA_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circrna_finder:1.2--pl5321hdfd78af_1
stdout: circrna_finder_postProcessStarAlignment.pl.out
