cwlVersion: v1.2
class: CommandLineTool
baseCommand: mudskipper bulk
label: mudskipper_bulk
doc: "Convert alignment of bulk RNA-Seq reads against genome to alignment against
  transcriptome.\n\nTool homepage: https://github.com/OceanGenomics/mudskipper"
inputs:
  - id: alignment
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
      prefix: --alignment
  - id: gtf
    type:
      - 'null'
      - File
    doc: Input GTF/GFF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: index
    type:
      - 'null'
      - Directory
    doc: Index directory containing parsed GTF files
    inputBinding:
      position: 101
      prefix: --index
  - id: max_softclip
    type: int
    doc: Max allowed softclip length
    inputBinding:
      position: 101
      prefix: --max-softclip
  - id: rad
    type:
      - 'null'
      - boolean
    doc: Output in RAD format instead of BAM
    inputBinding:
      position: 101
      prefix: --rad
  - id: threads
    type: int
    doc: Number of threads for processing bam files
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mudskipper:0.1.0--h7d875b9_0
