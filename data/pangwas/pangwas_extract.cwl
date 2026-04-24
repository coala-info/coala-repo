cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas_extract
label: pangwas_extract
doc: "Extract sequences and annotations from GFF files.\n\nTakes as input a GFF annotations
  file. If sequences are not included, a FASTA\nof genomic contigs must also be provided.
  Both annotated and unannotated regions \nwill be extracted. Outputs a TSV table
  of extracted sequence regions.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input FASTA sequences, if not provided at the end of the GFF.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff
    type: File
    doc: Input GFF annotations.
    inputBinding:
      position: 101
      prefix: --gff
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of sequences to extract
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of sequences to extract
    inputBinding:
      position: 101
      prefix: --min-len
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. If not provided, will be parsed from the gff file 
      name.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: regex
    type:
      - 'null'
      - string
    doc: Only extract gff lines that match this regular expression.
    inputBinding:
      position: 101
      prefix: --regex
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample identifier to use. If not provided, is parsed from the gff file 
      name.
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_extract.out
