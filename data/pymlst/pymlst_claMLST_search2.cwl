cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - claMLST
  - search2
label: pymlst_claMLST_search2
doc: "Searches ST number from FASTQS(.gz) raw reads using an mlst DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the claMLST database (SQLite file); the KMA index is written next to it, so a writable copy is staged"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: fastqs
    type: File[]
    doc: "FASTQ files (optionally gzip-compressed); two files for paired reads"
    inputBinding:
      position: 2
  - id: identity
    type: ['null', float]
    doc: "Minimum identity to search gene (default=0.9)."
    inputBinding:
      position: 10
      prefix: --identity
  - id: coverage
    type: ['null', float]
    doc: "Minimum coverage to search gene (default=0.95)."
    inputBinding:
      position: 10
      prefix: --coverage
  - id: reads
    type: ['null', int]
    doc: "Minimum reads coverage to search gene (default=10)."
    inputBinding:
      position: 10
      prefix: --reads
  - id: paired
    type: ['null', boolean]
    doc: "Defines type of fastqs files as paired reads."
    inputBinding:
      position: 10
      prefix: --paired
  - id: single
    type: ['null', boolean]
    doc: "Defines type of fastqs files as single reads."
    inputBinding:
      position: 10
      prefix: --single
  - id: fasta_path
    type: ['null', string]
    doc: "Writes fasta file with gene allele."
    inputBinding:
      position: 10
      prefix: --fasta
  - id: output_path
    type: ['null', string]
    doc: "Writes ST search result to (default:stdout)."
    inputBinding:
      position: 10
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
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_claMLST_search2.out
