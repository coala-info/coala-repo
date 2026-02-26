cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicorn
label: enhjoerning_unicorn
doc: "Compute per reference statistics.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: command
    type: string
    doc: Command to execute (refstats, bamstats, taxstats, reassign, alnfilt)
    inputBinding:
      position: 1
  - id: input_bam_sam
    type: File
    doc: Input BAM or SAM file
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn.out
