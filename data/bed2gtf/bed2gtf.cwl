cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed2gtf
label: bed2gtf
doc: "A fast and memory efficient BED to GTF converter\n\nTool homepage: https://github.com/alejandrogzi/bed2gtf"
inputs:
  - id: bed_file
    type: File
    doc: Path to BED file
    inputBinding:
      position: 101
      prefix: --bed
  - id: gz
    type:
      - 'null'
      - boolean
    doc: Compress output file
    default: false
    inputBinding:
      position: 101
      prefix: --gz
  - id: isoforms
    type:
      - 'null'
      - File
    doc: Path to isoforms file [gene -> transcript1, transcript2, ...]
    inputBinding:
      position: 101
      prefix: --isoforms
  - id: no_gene
    type:
      - 'null'
      - boolean
    doc: Flag to disable gene_id feature
    default: false
    inputBinding:
      position: 101
      prefix: --no-gene
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bed2gtf:1.9.3--h9948957_2
