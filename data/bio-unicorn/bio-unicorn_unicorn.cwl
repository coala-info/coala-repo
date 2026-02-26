cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicorn
label: bio-unicorn_unicorn
doc: "Compute per reference statistics such as # alignments, # reads, mean read length,
  etc.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: command
    type: string
    doc: Command to execute (refstats, bamstats, tidstats)
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
stdout: bio-unicorn_unicorn.out
