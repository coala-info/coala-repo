cwlVersion: v1.2
class: CommandLineTool
baseCommand: hera_build
label: hera_hera_build
doc: "Builds a Hera index (transcript sequences and genome index) from a reference genome FASTA file and a GTF annotation file.\n\nTool homepage: https://github.com/bioturing/hera"
inputs:
  - id: fasta
    type: File
    doc: Input reference genome fasta file
    inputBinding:
      position: 1
      prefix: --fasta
  - id: gtf
    type: File
    doc: Input reference annotation gtf file
    inputBinding:
      position: 2
      prefix: --gtf
  - id: full_index
    type:
      - 'null'
      - int
    doc: '0: none, 1: index full genome'
    inputBinding:
      position: 4
      prefix: --full_index
  - id: grch38
    type:
      - 'null'
      - int
    doc: 'Is input fasta GRCh38? 0: No, 1: Yes'
    inputBinding:
      position: 5
      prefix: --grch38
  - id: outdir
    type: string
    doc: Output directory
    inputBinding:
      position: 3
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_directory
    type: Directory
    doc: Output directory with the Hera index
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hera:1.1--h8121788_3
stdout: hera_hera_build.out
