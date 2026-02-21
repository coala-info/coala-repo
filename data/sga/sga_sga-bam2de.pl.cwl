cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga-bam2de.pl
label: sga_sga-bam2de.pl
doc: "The provided text is a system error log regarding a container build failure
  ('no space left on device') and does not contain the help documentation for the
  tool. Based on the tool name, this script is part of the SGA (String Graph Assembler)
  suite used for converting BAM files to distance estimates.\n\nTool homepage: https://github.com/jts/sga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_sga-bam2de.pl.out
