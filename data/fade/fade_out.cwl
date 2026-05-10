cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fade
  - out
label: fade_out
doc: "Fragmentase Artifact Detection and Elimination. Removes all reads and mates
  for reads containing the artifact (used after annotate) or hard clips out artifact
  sequence from reads.\n\nTool homepage: https://github.com/blachlylab/fade"
inputs:
  - id: input_bam_sam
    type: File
    doc: Input BAM/SAM file
    inputBinding:
      position: 1
  - id: clip
    type:
      - 'null'
      - boolean
    doc: clip reads instead of filtering them
    inputBinding:
      position: 102
      prefix: --clip
  - id: threads
    type:
      - 'null'
      - int
    doc: extra threads for parsing the bam file
    inputBinding:
      position: 102
      prefix: --threads
  - id: bam_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `bam_path`
    inputBinding:
      position: 103
      prefix: --bam
  - id: ubam_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ubam_path`
    inputBinding:
      position: 104
      prefix: --ubam
outputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: output bam
    outputBinding:
      glob: $(inputs.bam_path)
  - id: ubam
    type:
      - 'null'
      - File
    doc: output uncompressed bam
    outputBinding:
      glob: $(inputs.ubam_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
