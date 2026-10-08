cwlVersion: v1.2
class: CommandLineTool
baseCommand: FLAMS
label: flams
doc: "Find Lysine Acylations & other Modification Sites (FLAMS). Searches whether
  a modification at a protein position is known in similar proteins.\n\nTool homepage:
  https://github.com/hannelorelongin/FLAMS"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Path to input .fasta file.
    inputBinding:
      position: 1
      prefix: --in
  - id: uniprot_id
    type:
      - 'null'
      - string
    doc: UniProt ID of input protein.
    inputBinding:
      position: 2
      prefix: --id
  - id: batch_file
    type:
      - 'null'
      - File
    doc: Path to tab separated input file for batch processing (1st column UniProt
      ID, 2nd column position). One query (UniProtID + position) per line.
    inputBinding:
      position: 3
      prefix: --batch
  - id: position
    type:
      - 'null'
      - int
    doc: Position in input protein that will be searched for conserved modifications.
    inputBinding:
      position: 4
      prefix: --pos
  - id: error_range
    type:
      - 'null'
      - int
    doc: Allowed error range for position. [default 0]
    inputBinding:
      position: 5
      prefix: --range
  - id: output_file
    type:
      - 'null'
      - string
    doc: Path to output .tsv file. [default out.tsv] If FLAMS is run with --batch,
      the specified -o/--output is used as preposition, followed by '_$UniProtID_$position.tsv'.
    inputBinding:
      position: 6
      prefix: --output
  - id: data_dir
    type:
      - 'null'
      - string
    doc: Path to directory where intermediate files should be saved. [default $PWD/data]
    inputBinding:
      position: 7
      prefix: --data_dir
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to run BLAST with. [default 1]
    inputBinding:
      position: 8
      prefix: --num_threads
  - id: evalue
    type:
      - 'null'
      - double
    doc: Desired E-value of BLAST run. [default 0.01]
    inputBinding:
      position: 9
      prefix: --evalue
  - id: modification
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-separated list of modifications (all lower case) to search for at the
      given position, for example acetylation or CPLM-Acylations. [default K-All]
    inputBinding:
      position: 10
      prefix: --modification
outputs:
  - id: output
    type:
      - 'null'
      - type: array
        items: File
    doc: Result tables (.tsv). One file per query when run with --batch.
    outputBinding:
      glob: "*.tsv"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flams:1.1.7--pyhdfd78af_0
