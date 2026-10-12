cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_resolve
label: peregrine-2021_pg_resolve
doc: "Align all contigs to themselves to identify haplotype-related contigs (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: fasta_file
    type: File
    doc: Path to the contig fasta file
    inputBinding:
      position: 110
      prefix: --fasta_file
  - id: out_prefix
    type: string
    doc: Path to the output prefix
    inputBinding:
      position: 110
      prefix: --out_prefix
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size (default 56)
    inputBinding:
      position: 110
      prefix: -k
  - id: reduction_factor
    type:
      - 'null'
      - int
    doc: Reduction factor (default 6)
    inputBinding:
      position: 110
      prefix: -r
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (default 80)
    inputBinding:
      position: 110
      prefix: -w
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: resolve_files
    type:
      type: array
      items: File
    doc: Output files
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
