cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-plus
  - index
label: hmftools-bwa-plus_index
doc: "Create the bwa-plus index of a reference FASTA.\n\nTool homepage: https://github.com/hartwigmedical/bwa-plus"
inputs:
  - id: reference
    type: File
    doc: Reference sequences in FASTA format (staged in the working directory
      because the index is written beside it)
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix of the index files (default: the FASTA file name)"
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files (.0123, .amb, .ann, .bwt.2bit.64, .pac)
    outputBinding:
      glob: $((inputs.prefix || inputs.reference.basename) + '.*')
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
stdout: hmftools-bwa-plus_index.out
