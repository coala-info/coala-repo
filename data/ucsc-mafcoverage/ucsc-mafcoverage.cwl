cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafCoverage
label: ucsc-mafcoverage
doc: "Analyse coverage by maf files - chromosome by chromosome and genome-wide. The
  maf file must be sorted by chromosome, tStart. The program reads the chromosome
  sizes and gaps of the database from a UCSC MySQL server given in hg_conf.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg19).
    inputBinding:
      position: 1
  - id: maf_file
    type: File
    doc: The input MAF file to process, sorted by chromosome and start.
    inputBinding:
      position: 2
  - id: hg_conf
    type: File
    doc: hg.conf file (mode 600) with the db.host, db.user and db.password of the
      UCSC MySQL server that holds the database. It is staged as .hg.conf in the
      working directory, where the program looks for it.
  - id: restrict
    type:
      - 'null'
      - File
    doc: Restrict to parts in restrict.bed
    inputBinding:
      position: 101
      prefix: -restrict=
      separate: false
  - id: count
    type:
      - 'null'
      - int
    doc: Number of matching species to count coverage. Default = 3
    inputBinding:
      position: 101
      prefix: -count=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafcoverage:482--h0b57e2e_0
stdout: ucsc-mafcoverage.out
