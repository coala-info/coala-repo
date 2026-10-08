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
  - id: outdir
    type: string
    default: gfflu-outdir
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: --prefix
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
  - id: outdir_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfflu:0.0.2--pyhdfd78af_0
stdout: gfflu.out
