cwlVersion: v1.2
class: CommandLineTool
baseCommand: targetscan_targetscan_70.pl
label: targetscan_targetscan_70.pl
doc: "TargetScan predicts biological targets of miRNAs by searching for the presence
  of conserved 8mer, 7mer, and 6mer sites that match the seed region of each miRNA.
  (Note: The provided help text contains container runtime errors and does not list
  command-line arguments).\n\nTool homepage: https://www.targetscan.org/vert_80/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targetscan:7.0--pl5321hdfd78af_0
stdout: targetscan_targetscan_70.pl.out
