cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam reconcile
label: leviosam_reconcile
doc: "Reconcile multiple BAM files into a single BAM file.\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs:
  - id: input_label_file
    type:
      type: array
      items: string
    doc: Input label and file; separated by a colon, e.g. -s foo:foo.bam -s 
      bar:bar.bam
    inputBinding:
      position: 101
      prefix: -s
  - id: perform_merging_in_pairs
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
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
