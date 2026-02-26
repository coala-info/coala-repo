cwlVersion: v1.2
class: CommandLineTool
baseCommand: seroba createDBs
label: seroba_createDBs
doc: "Creates a Database for kmc and ariba\n\nTool homepage: https://github.com/sanger-pathogens/seroba"
inputs:
  - id: database_dir
    type: Directory
    doc: output directory for kmc and ariba Database
    inputBinding:
      position: 1
  - id: kmer_size
    type: int
    doc: kmer_size zou want to use for kmc , recommanded = 71
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba_createDBs.out
