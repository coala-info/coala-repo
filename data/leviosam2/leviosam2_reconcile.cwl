cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam2
  - reconcile
label: leviosam2_reconcile
doc: "Reconcile alignments to select the one with higher confidence\n\nTool homepage:
  https://github.com/milkschen/leviosam2"
inputs:
  - id: conservative_mapq
    type:
      - 'null'
      - boolean
    doc: Set to use conservative MAPQ
    default: false
    inputBinding:
      position: 101
      prefix: -c
  - id: input_sources
    type:
      type: array
      items: string
    doc: Input label and file; separated by a colon, e.g. -s foo:foo.bam -s 
      bar:bar.bam
    inputBinding:
      position: 101
      prefix: -s
  - id: merge_pairs
    type:
      - 'null'
      - boolean
    doc: Set to perform merging in pairs
    default: false
    inputBinding:
      position: 101
      prefix: -m
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed used by the program
    default: 0
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_file
    type: File
    doc: Path to the output SAM/BAM file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
