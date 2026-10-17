cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - claMLST
  - search
label: pymlst_claMLST_search
doc: "Searches ST number for an assembly GENOME using an mlst DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the claMLST database (SQLite file)"
    inputBinding:
      position: 1
  - id: genomes
    type: File[]
    doc: "Genome assembly FASTA files"
    inputBinding:
      position: 20
  - id: identity
    type: ['null', float]
    doc: "Minimum identity to search gene (default=0.9)."
    inputBinding:
      position: 5
      prefix: --identity
  - id: coverage
    type: ['null', float]
    doc: "Minimum coverage to search gene (default=0.9)."
    inputBinding:
      position: 6
      prefix: --coverage
  - id: fasta_path
    type: ['null', string]
    doc: "Writes fasta file with gene allele."
    inputBinding:
      position: 7
      prefix: --fasta
  - id: output_path
    type: ['null', string]
    doc: "Writes ST search result to (default:stdout)."
    inputBinding:
      position: 8
      prefix: --output
outputs:
  - id: fasta
    type: ['null', File]
    doc: "Fasta file with the gene alleles"
    outputBinding:
      glob: "$(inputs.fasta_path)"
  - id: output
    type: ['null', File]
    doc: "ST search result written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "ST search result (when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_claMLST_search.out
