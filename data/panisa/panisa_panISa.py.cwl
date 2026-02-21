cwlVersion: v1.2
class: CommandLineTool
baseCommand: panISa.py
label: panisa_panISa.py
doc: "Search integrative element (IS) insertion on a genome using BAM alignment\n\n
  Tool homepage: https://github.com/bvalot/panISa"
inputs:
  - id: bam
    type: File
    doc: Alignment on BAM/SAM format
    inputBinding:
      position: 1
  - id: minimum
    type:
      - 'null'
      - int
    doc: Min number of clipped reads to look at IS on a position
    default: 10
    inputBinding:
      position: 102
      prefix: --minimun
  - id: percentage
    type:
      - 'null'
      - float
    doc: Minimum percentage of same base to create consensus
    default: 0.8
    inputBinding:
      position: 102
      prefix: --percentage
  - id: quality
    type:
      - 'null'
      - int
    doc: Min alignment quality value to conserve a clipped read
    default: 20
    inputBinding:
      position: 102
      prefix: --quality
  - id: size
    type:
      - 'null'
      - int
    doc: Maximun size of direct repeat region
    default: 20
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Return list of IS insertion by alignment, default=stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panisa:0.1.7--pyhdfd78af_0
