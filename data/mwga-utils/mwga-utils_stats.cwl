cwlVersion: v1.2
class: CommandLineTool
baseCommand: stats
label: mwga-utils_stats
doc: "Compute a series of statistics on a MAF file:\n        - Number of BP aligned
  in each assembly\n\nTool homepage: https://github.com/RomainFeron/mgwa_utils"
inputs:
  - id: maf_file
    type: File
    doc: Path to a MAF file.
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output stats files
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_stats.out
