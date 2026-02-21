cwlVersion: v1.2
class: CommandLineTool
baseCommand: yass_yass2blast.pl
label: yass_yass2blast.pl
doc: "A script to convert YASS genomic alignment results to BLAST format. (Note: The
  provided help text contained only container runtime error messages and no usage
  information.)\n\nTool homepage: https://bioinfo.lifl.fr/yass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yass:1.16--h7b50bb2_0
stdout: yass_yass2blast.pl.out
