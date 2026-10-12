cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_dedup
label: peregrine-2021_pg_dedup
doc: "Perform all contigs to all contigs alignment to remove duplicates (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: ref_fasta
    type: File
    doc: Path to the reference file
    inputBinding:
      position: 110
      prefix: --ref_fasta
  - id: target_fasta
    type: File
    doc: Path to the target file
    inputBinding:
      position: 110
      prefix: --target_fasta
  - id: output_path
    type: string
    doc: Path to the output filename
    inputBinding:
      position: 110
      prefix: --output
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
    doc: Reduction factor (default 4)
    inputBinding:
      position: 110
      prefix: -r
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (default 48)
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
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
