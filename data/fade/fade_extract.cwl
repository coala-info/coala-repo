cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fade
  - extract
label: fade_extract
doc: "extracts artifacts into a mapped SAM/BAM (used after annotate)\n\nThe alignments are written to standard output as SAM, or as BAM with --bam or uncompressed BAM with --ubam.\n\nTool homepage: https://github.com/blachlylab/fade"
inputs:
  - id: annotated_bam_sam
    type: File
    doc: Annotated BAM/SAM file (output of fade annotate)
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: extra threads for parsing the bam file
    inputBinding:
      position: 102
      prefix: --threads
  - id: bam
    type:
      - 'null'
      - boolean
    doc: output bam
    inputBinding:
      position: 103
      prefix: --bam
  - id: ubam
    type:
      - 'null'
      - boolean
    doc: output uncompressed bam
    inputBinding:
      position: 104
      prefix: --ubam
  - id: output_name
    type: string
    default: extracted.sam
    doc: File name for the extracted artifact alignments (standard output); use
      a .bam name with --bam or --ubam
outputs:
  - id: extracted
    type: stdout
    doc: Extracted artifact alignments (standard output)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
