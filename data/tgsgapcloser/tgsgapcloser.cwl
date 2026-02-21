cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgsgapcloser
label: tgsgapcloser
doc: "TGS-GapCloser is a tool designed to use long reads (PacBio or Nanopore) to close
  gaps in draft assemblies.\n\nTool homepage: https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs:
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum gap length to fill
    default: 50000
    inputBinding:
      position: 101
      prefix: --max_len
  - id: min_id
    type:
      - 'null'
      - float
    doc: Minimum identity
    default: 0.7
    inputBinding:
      position: 101
      prefix: --min_id
  - id: min_match
    type:
      - 'null'
      - int
    doc: Minimum matching length
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_match
  - id: minmap_args
    type:
      - 'null'
      - string
    doc: Arguments for minimap2
    default: -x map-ont
    inputBinding:
      position: 101
      prefix: --minmap_arg
  - id: reads
    type: File
    doc: Long reads (PacBio or Nanopore) used for gap closing
    inputBinding:
      position: 101
      prefix: --reads
  - id: scaffold
    type: File
    doc: Target scaffold file to be gap-filled
    inputBinding:
      position: 101
      prefix: --scaff
  - id: tgs_type
    type:
      - 'null'
      - string
    doc: 'Type of long reads: pb (PacBio) or ont (Nanopore)'
    default: ont
    inputBinding:
      position: 101
      prefix: --tgstype
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output_prefix
    type: File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
