cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfflu
label: gfflu
doc: "Annotate Influenza A virus sequences using Miniprot and BLASTX The Miniprot
  GFF for a particular reference sequence gene segment will have multiple annotations
  for the same gene. This script will select the top scoring annotation for each gene
  and write out a new GFF file that can be used with SnpEff.\n\nTool homepage: https://github.com/CFIA-NCFAD/gfflu"
inputs:
  - id: fasta
    type: File
    doc: Influenza virus nucleotide sequence FASTA file
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    inputBinding:
      position: 102
      prefix: --force
  - id: install_completion
    type:
      - 'null'
      - boolean
    doc: Install completion for the current shell.
    inputBinding:
      position: 102
      prefix: --install-completion
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: gfflu-outdir
    inputBinding:
      position: 102
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    default: None
    inputBinding:
      position: 102
      prefix: --prefix
  - id: show_completion
    type:
      - 'null'
      - boolean
    doc: Show completion for the current shell, to copy it or customize the 
      installation.
    inputBinding:
      position: 102
      prefix: --show-completion
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfflu:0.0.2--pyhdfd78af_0
stdout: gfflu.out
