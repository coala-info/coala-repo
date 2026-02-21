cwlVersion: v1.2
class: CommandLineTool
baseCommand: BaitFisher
label: baitfisher_BaitFisher
doc: "BaitFisher program for designing bait sets for phylogenomics and other applications.\n
  \nTool homepage: https://github.com/cmayer/BaitFisher-package"
inputs:
  - id: parameter_file
    type: File
    doc: The parameter file containing the configuration for the BaitFisher run.
    inputBinding:
      position: 1
  - id: gff_file_test
    type:
      - 'null'
      - File
    doc: Optional GFF file for testing.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/baitfisher:v1.2.7git20180107.e92dbf2dfsg-1-deb_cv1
stdout: baitfisher_BaitFisher.out
