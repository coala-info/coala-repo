cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_stats_from_bam
label: pomoxis_stats_from_bam
doc: "A tool to calculate statistics from BAM files. (Note: The provided help text
  contains container runtime errors and does not list specific arguments.)\n\nTool
  homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_stats_from_bam.out
