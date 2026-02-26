cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - variants
label: gofasta_variants
doc: "Annotate mutations relative to a reference from a multiple sequence alignment
  in fasta format\n\nTool homepage: https://github.com/cov-ert/gofasta"
inputs:
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Report the proportions of each change
    inputBinding:
      position: 101
      prefix: --aggregate
  - id: annotation
    type:
      - 'null'
      - File
    doc: Genbank or GFF3 format annotation file. Must have suffix .gb or .gff
    inputBinding:
      position: 101
      prefix: --annotation
  - id: append_snps
    type:
      - 'null'
      - boolean
    doc: Report the codon's SNPs in parenthesis after each amino acid mutation
    inputBinding:
      position: 101
      prefix: --append-snps
  - id: end
    type:
      - 'null'
      - int
    doc: Only report variants before (and including) this position
    default: -1
    inputBinding:
      position: 101
      prefix: --end
  - id: msa
    type:
      - 'null'
      - File
    doc: Multiple sequence alignment in fasta format
    default: stdin
    inputBinding:
      position: 101
      prefix: --msa
  - id: reference
    type:
      - 'null'
      - string
    doc: The ID of the reference record in the msa
    inputBinding:
      position: 101
      prefix: --reference
  - id: start
    type:
      - 'null'
      - int
    doc: Only report variants after (and including) this position
    default: -1
    inputBinding:
      position: 101
      prefix: --start
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: If --aggregate, only report changes with a freq greater than or equal 
      to this value
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Name of the file of variants to write
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
