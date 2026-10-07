cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-mem2
  - index
label: bwa-mem2_index
doc: "Build index for BWA-MEM2\n\nTool homepage: https://github.com/bwa-mem2/bwa-mem2"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for index files
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: index_files
    type: File[]
    doc: Index files (.0123, .amb, .ann, .bwt.2bit.64, .pac) named by the prefix
    outputBinding:
      glob:
        - '*.0123'
        - '*.amb'
        - '*.ann'
        - '*.bwt.2bit.64'
        - '*.pac'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-mem2:2.3--he70b90d_0
stdout: bwa-mem2_index.out
