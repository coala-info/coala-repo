cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bamclip2insertion
label: jvarkit_bamclip2insertion
doc: "Clip reads to a given insertion point and output them as BAM.\n\nTool homepage:
  https://github.com/lindenb/jvarkit"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: clip_after
    type:
      - 'null'
      - boolean
    doc: Clip reads that end after the insertion point
    inputBinding:
      position: 102
      prefix: --clip-after
  - id: clip_before
    type:
      - 'null'
      - boolean
    doc: Clip reads that start before the insertion point
    inputBinding:
      position: 102
      prefix: --clip-before
  - id: pos
    type:
      - 'null'
      - int
    doc: Position (1-based)
    inputBinding:
      position: 102
      prefix: --pos
  - id: ref
    type:
      - 'null'
      - string
    doc: Reference name
    inputBinding:
      position: 102
      prefix: --ref
  - id: reference_dict
    type:
      - 'null'
      - File
    doc: Reference dictionary file (.dict)
    inputBinding:
      position: 102
      prefix: --reference-dict
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
