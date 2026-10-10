cwlVersion: v1.2
class: CommandLineTool
baseCommand: single_cov
label: mwga-utils_single_cov
doc: "Check that the each sequence in the reference species is only covered once in
  a MAF. The output is a table of counts for each coverage value in each contig from
  the reference assembly.\n\nTool homepage: https://github.com/RomainFeron/mgwa_utils"
inputs:
  - id: maf_file
    type: File
    doc: Path to a MAF file.
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Table of counts (Contig, Coverage, Count)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_single_cov.out
