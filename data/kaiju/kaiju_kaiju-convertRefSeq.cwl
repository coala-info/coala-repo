cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-convertRefSeq
label: kaiju_kaiju-convertRefSeq
doc: "Convert RefSeq protein FASTA records (read from standard input) into the FASTA format used to build a kaiju database (headers carry the taxon ID).\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: refseq_faa
    type: File
    doc: RefSeq protein FASTA file, passed on standard input
  - id: nodes_file
    type: File
    doc: Name of nodes.dmp file.
    inputBinding:
      position: 1
      prefix: -t
  - id: merged_file
    type: File
    doc: Name of merged.dmp file.
    inputBinding:
      position: 2
      prefix: -m
  - id: accession2taxid_file
    type: File
    doc: Name of prot.accession2taxid.FULL.gz file.
    inputBinding:
      position: 3
      prefix: -g
  - id: output_file_path
    type: string
    doc: Name of output file.
    inputBinding:
      position: 4
      prefix: -o
  - id: prefix_accession
    type:
      - 'null'
      - boolean
    doc: Prefix taxon ID with the accession number.
    inputBinding:
      position: 5
      prefix: -a
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 6
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 7
      prefix: -d
outputs:
  - id: output_file
    type: File
    doc: FASTA file for building a kaiju database
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdin: $(inputs.refseq_faa.path)
stdout: kaiju_kaiju-convertRefSeq.out
