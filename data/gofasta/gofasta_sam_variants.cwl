cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - sam
  - variants
label: gofasta_sam_variants
doc: "Annotate mutations relative to a reference from an alignment in sam format

Tool homepage: https://github.com/virus-evolution/gofasta"
inputs:
  - id: reference
    type: File
    doc: "Reference fasta file used to generate the sam file"
    inputBinding:
      position: 101
      prefix: --reference
  - id: samfile
    type: File
    doc: "Samfile to read. If none is specified, will read from stdin"
    inputBinding:
      position: 101
      prefix: --samfile
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: annotation
    type: File
    doc: "Genbank or GFF3 format annotation file. Must have suffix .gb or .gff"
    inputBinding:
      position: 101
      prefix: --annotation
  - id: start
    type:
      - 'null'
      - int
    doc: "Only report variants after (and including) this position"
    inputBinding:
      position: 101
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: "Only report variants before (and including) this position"
    inputBinding:
      position: 101
      prefix: --end
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: "Report the proportions of each change"
    inputBinding:
      position: 101
      prefix: --aggregate
  - id: threshold
    type:
      - 'null'
      - float
    doc: "If --aggregate, only report changes with a freq greater than or equal to this value"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: append_snps
    type:
      - 'null'
      - boolean
    doc: "Report the codon's SNPs in parenthesis after each amino acid mutation"
    inputBinding:
      position: 101
      prefix: --append-snps
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: "Where to write the variants (default stdout)"
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Variants file"
    outputBinding:
      glob: "$(inputs.outfile_path ? inputs.outfile_path : 'no_outfile')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_sam_variants.out
