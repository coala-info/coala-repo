cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinkit_blastgendb
label: metabinkit_metabinkit_blastgendb
doc: "Create a taxonomy-aware BLAST nucleotide database from a fasta file.\n\nTool homepage: https://github.com/envmetagen/metabinkit"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fasta_file
    type: File
    doc: "Reference sequences in fasta format"
    inputBinding:
      position: 100
      prefix: -f
  - id: seqid_taxid_map
    type: 
      - 'null'
      - File
    doc: "mapping between the sequence id and the taxid (tab separated); if none is given, taxid=xxxx; in the fasta header after the first space is used"
    inputBinding:
      position: 100
      prefix: -T
  - id: outfile
    type: string
    doc: "Output database name (prefix)"
    inputBinding:
      position: 100
      prefix: -o
  - id: check_db
    type: 
      - 'null'
      - boolean
    doc: "check database after creating it"
    inputBinding:
      position: 100
      prefix: -c
  - id: threads
    type: 
      - 'null'
      - int
    doc: "maximum number of threads (default: 2)"
    inputBinding:
      position: 100
      prefix: -t
outputs:
  - id: db_files
    type: File[]
    doc: "BLAST database files and the taxid map written with the output prefix"
    outputBinding:
      glob: $(inputs.outfile)*
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
stdout: metabinkit_blastgendb.out
stderr: metabinkit_blastgendb.log
