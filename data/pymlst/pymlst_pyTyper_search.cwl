cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyTyper
  - search
label: pymlst_pyTyper_search
doc: "Searches strain type using specified METHOD for an assembly GENOME. fim: fimH typing for Escherichia coli; spa: spa typing for Staphylococcus aureus; clmt: Phylogouping using ClermontTyping method for Escherichia coli.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: method
    type: string
    doc: "Typing method: fim, spa or clmt"
    inputBinding:
      position: 1
  - id: genomes
    type: File[]
    doc: "Genome assembly FASTA files"
    inputBinding:
      position: 20
  - id: identity
    type: ['null', float]
    doc: "Minimum identity to search gene."
    inputBinding:
      position: 5
      prefix: --identity
  - id: coverage
    type: ['null', float]
    doc: "Minimum coverage to search gene."
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
    doc: "Writes search result to (default:stdout)."
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
    doc: "Search result written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Search result (when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_pyTyper_search.out
