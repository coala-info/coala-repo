cwlVersion: v1.2
class: CommandLineTool
baseCommand: subjunc
label: subread-data_subjunc
doc: "The provided text contains container runtime errors and does not include the
  help documentation for the tool. Subjunc is an RNA-seq aligner that is part of the
  Subread suite, used for mapping reads and detecting exon-exon junctions.\n\nTool
  homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1
stdout: subread-data_subjunc.out
