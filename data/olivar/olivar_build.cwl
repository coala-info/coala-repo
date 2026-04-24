cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar_build
label: olivar_build
doc: "Build an Olivar reference file from a FASTA sequence and/or an MSA.\n\nTool
  homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: align
    type:
      - 'null'
      - boolean
    doc: Control whether do alignment or not.
    inputBinding:
      position: 101
      prefix: --align
  - id: db
    type:
      - 'null'
      - string
    doc: Optional, path to the BLAST database. Note that this path should end 
      with the name of the BLAST database (e.g., 
      "example_input/Human/GRCh38_primary").
    inputBinding:
      position: 101
      prefix: --db
  - id: deg
    type:
      - 'null'
      - boolean
    doc: Control whether use degenerate mode or not. This mode only works with 
      MSA input (--msa).
    inputBinding:
      position: 101
      prefix: --deg
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Optional, Path to the FASTA reference sequence. The sequence should be 
      high-quality and contain no degenerate bases
    inputBinding:
      position: 101
      prefix: --fasta
  - id: min_var
    type:
      - 'null'
      - float
    doc: Minimum frequency threshold for sequence variations generated from the 
      input MSA.
    inputBinding:
      position: 101
      prefix: --min-var
  - id: msa_fasta
    type:
      - 'null'
      - File
    doc: Optional, Path to the MSA file in FASTA format.
    inputBinding:
      position: 101
      prefix: --msa
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory (output to current directory by default).
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [1].
    inputBinding:
      position: 101
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Name of the Olivar reference file [FASTA record ID].
    inputBinding:
      position: 101
      prefix: --title
  - id: var
    type:
      - 'null'
      - string
    doc: 'Optional, path to the csv file of SNP coordinates and frequencies. Required
      columns: "START", "STOP", "FREQ". "FREQ" is considered as 1.0 if empty. Coordinates
      are 1-based.'
    inputBinding:
      position: 101
      prefix: --var
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
stdout: olivar_build.out
