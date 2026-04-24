cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - consensus
label: alfred_consensus
doc: "Generate consensus sequences from BAM or FASTA files\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: input_file
    type: File
    doc: Input BAM or gzipped FASTA file
    inputBinding:
      position: 1
  - id: called
    type:
      - 'null'
      - float
    doc: fraction of reads required for consensus
    inputBinding:
      position: 102
      prefix: --called
  - id: format
    type:
      - 'null'
      - string
    doc: input format [bam|fasta]
    inputBinding:
      position: 102
      prefix: --format
  - id: gapext
    type:
      - 'null'
      - int
    doc: gap extension
    inputBinding:
      position: 102
      prefix: --gapext
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open
    inputBinding:
      position: 102
      prefix: --gapopen
  - id: genome
    type:
      - 'null'
      - File
    doc: genome [req. for CRAM decoding]
    inputBinding:
      position: 102
      prefix: --genome
  - id: mapqual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    inputBinding:
      position: 102
      prefix: --mapqual
  - id: match
    type:
      - 'null'
      - int
    doc: match
    inputBinding:
      position: 102
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: outformat
    type:
      - 'null'
      - string
    doc: output format [v|h]
    inputBinding:
      position: 102
      prefix: --outformat
  - id: position
    type:
      - 'null'
      - string
    doc: position to generate consensus
    inputBinding:
      position: 102
      prefix: --position
  - id: secondary
    type:
      - 'null'
      - boolean
    doc: consider secondary alignments
    inputBinding:
      position: 102
      prefix: --secondary
  - id: seqtype
    type:
      - 'null'
      - string
    doc: seq. type [ill|ont|pacbio|custom]
    inputBinding:
      position: 102
      prefix: --seqtype
  - id: trimreads
    type:
      - 'null'
      - boolean
    doc: trim reads to window
    inputBinding:
      position: 102
      prefix: --trimreads
  - id: window
    type:
      - 'null'
      - int
    doc: window around pos that reads need to span
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: vertical/horizontal alignment
    outputBinding:
      glob: $(inputs.alignment)
  - id: consensus
    type:
      - 'null'
      - File
    doc: consensus
    outputBinding:
      glob: $(inputs.consensus)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
