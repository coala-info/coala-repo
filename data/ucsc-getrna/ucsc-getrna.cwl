cwlVersion: v1.2
class: CommandLineTool
baseCommand: getRna
label: ucsc-getrna
doc: "Get mrna for GenBank or RefSeq sequences found in a UCSC database. Gets the mrna for all accessions in accFile and writes a fasta file. If an accession has a version, that version is returned or an error is generated. The program reads a UCSC MySQL server named in ~/.hg.conf (give it as hg_conf).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
inputs:
  - id: hg_conf
    type: File
    doc: "hg.conf file with db.host, db.user and db.password of the UCSC MySQL server (staged as ~/.hg.conf)"
  - id: cds_upper
    type: ['null', boolean]
    doc: Look up the CDS and output it as upper case. If the CDS annotation cannot be obtained, the sequence is skipped with a warning
    inputBinding:
      prefix: -cdsUpper
      position: 1
  - id: cds_upper_all
    type: ['null', boolean]
    doc: Like -cdsUpper, except keep sequences without CDS
    inputBinding:
      prefix: -cdsUpperAll
      position: 2
  - id: incl_ver
    type: ['null', boolean]
    doc: Include the version with the sequence id
    inputBinding:
      prefix: -inclVer
      position: 3
  - id: peptides
    type: ['null', boolean]
    doc: Translate mRNAs to peptides
    inputBinding:
      prefix: -peptides
      position: 4
  - id: seq_tbl
    type: ['null', string]
    doc: Use this table instead of gbSeq and seq (many other options do not work if this is used)
    inputBinding:
      prefix: -seqTbl=
      separate: false
      position: 5
  - id: ext_file_tbl
    type: ['null', string]
    doc: Use this table instead of gbExtFile and extFile
    inputBinding:
      prefix: -extFileTbl=
      separate: false
      position: 6
  - id: database
    type: string
    doc: UCSC database name (for example hg19)
    inputBinding:
      position: 10
  - id: acc_file
    type: File
    doc: File with one GenBank or RefSeq accession per line
    inputBinding:
      position: 11
  - id: outfa
    type: string
    doc: Output fasta file name
    inputBinding:
      position: 12
outputs:
  - id: output_fasta
    type: File
    doc: Output fasta file with the mrna sequences
    outputBinding:
      glob: $(inputs.outfa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-getrna:482--h0b57e2e_0
