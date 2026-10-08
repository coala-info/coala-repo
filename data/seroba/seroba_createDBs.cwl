cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seroba
  - createDBs
label: seroba_createDBs
doc: "Creates a Database for kmc and ariba\n\nTool homepage: https://github.com/sanger-pathogens/seroba"
inputs:
  - id: database_dir
    type: Directory
    doc: database directory holding reference.fasta, meta.tsv and
      streptococcus-pneumoniae-ctvdb (as made by getPneumocat); the kmc and
      ariba databases are written into a copy of it
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: kmer_size
    type: int
    doc: kmer_size zou want to use for kmc , recommanded = 71
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_dir_dir
    type: Directory
    doc: database directory with the kmc and ariba databases
    outputBinding:
      glob: $(inputs.database_dir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba_createDBs.out
