cwlVersion: v1.2
class: CommandLineTool
baseCommand: meningotype
label: meningotype
doc: "In silico typing for Neisseria meningitidis\n\nTool homepage: https://github.com/MDU-PHL/meningotype"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: input FASTA files eg. fasta1, fasta2, fasta3 ... fastaN
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: perform MLST, porA, fetA, porB, BAST typing
    default: false
    inputBinding:
      position: 102
      prefix: --all
  - id: bast
    type:
      - 'null'
      - boolean
    doc: perform Bexsero antigen sequence typing (BAST)
    default: false
    inputBinding:
      position: 102
      prefix: --bast
  - id: checkdeps
    type:
      - 'null'
      - boolean
    doc: check dependencies are installed and exit
    inputBinding:
      position: 102
      prefix: --checkdeps
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of cpus to use in BLAST search
    default: 1
    inputBinding:
      position: 102
      prefix: --cpus
  - id: db
    type:
      - 'null'
      - Directory
    doc: specify custom directory containing allele databases for porA/fetA 
      typing
    inputBinding:
      position: 102
      prefix: --db
  - id: finetype
    type:
      - 'null'
      - boolean
    doc: perform porA and fetA fine typing
    default: false
    inputBinding:
      position: 102
      prefix: --finetype
  - id: mlst
    type:
      - 'null'
      - boolean
    doc: perform MLST
    default: false
    inputBinding:
      position: 102
      prefix: --mlst
  - id: porb
    type:
      - 'null'
      - boolean
    doc: perform porB sequence typing (NEIS2020)
    default: false
    inputBinding:
      position: 102
      prefix: --porB
  - id: printseq
    type:
      - 'null'
      - Directory
    doc: specify directory to save extracted porA/fetA/porB or BAST allele 
      sequences
    inputBinding:
      position: 102
      prefix: --printseq
  - id: test
    type:
      - 'null'
      - boolean
    doc: run test example
    inputBinding:
      position: 102
      prefix: --test
  - id: updatedb
    type:
      - 'null'
      - boolean
    doc: update allele database from <pubmlst.org>
    inputBinding:
      position: 102
      prefix: --updatedb
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meningotype:0.8.5--pyhdfd78af_1
stdout: meningotype.out
