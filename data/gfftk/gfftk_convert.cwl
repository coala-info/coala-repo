cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk_convert
label: gfftk_convert
doc: "convert GFF3/tbl format into another format [output gff3, gtf, tbl, gbff, fasta,
  combined]\n\nTool homepage: https://github.com/nextgenusfs/gfftk"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'write parsing errors to stderr (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type:
      - 'null'
      - File
    doc: genome in FASTA format (optional for combined GFF3+FASTA files)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: grep
    type:
      - 'null'
      - string
    doc: 'Filter gene models, keep matches. [key:value] (default: [])'
    inputBinding:
      position: 101
      prefix: --grep
  - id: grepv
    type:
      - 'null'
      - string
    doc: 'Filter gene models, remove matches [key:value] (default: [])'
    inputBinding:
      position: 101
      prefix: --grepv
  - id: input
    type: File
    doc: annotation in GFF3 or TBL format
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'format of input file [gff3, gtf, tbl]. (default: auto)'
    inputBinding:
      position: 101
      prefix: --input-format
  - id: no_stop
    type:
      - 'null'
      - boolean
    doc: 'for proteins output, do not write stop codons (*) (default: False)'
    inputBinding:
      position: 101
      prefix: --no-stop
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism name, eg. 'Aspergillus fumigatus'
    inputBinding:
      position: 101
      prefix: --organism
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'format of output file [gff3, gtf, tbl, gbff, proteins, transcripts, cds-transcripts,
      combined]. (default: auto)'
    inputBinding:
      position: 101
      prefix: --output-format
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain name, eg. CBS1001
    inputBinding:
      position: 101
      prefix: --strain
  - id: table
    type:
      - 'null'
      - int
    doc: 'Codon table. Default: 1 [1,11]'
    inputBinding:
      position: 101
      prefix: --table
  - id: url_encode
    type:
      - 'null'
      - boolean
    doc: 'URL encode attribute values in GFF3 output for downstream tool compatibility
      (default: False)'
    inputBinding:
      position: 101
      prefix: --url-encode
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: 'write converted output to file (default: stdout)'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
