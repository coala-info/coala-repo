cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fade
  - annotate
label: fade_annotate
doc: "performs re-alignment of soft-clips and annotates bam records with bitflag (rs) and realignment tags (am)\n\nThe alignments are written to standard output as SAM, or as BAM with --bam or uncompressed BAM with --ubam.\n\nTool homepage: https://github.com/blachlylab/fade"
inputs:
  - id: input_bam_sam
    type: File
    doc: Input BAM/SAM file
    inputBinding:
      position: 1
  - id: indexed_fasta_reference
    type: File
    doc: Indexed fasta reference
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 2
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum number of bases for a soft-clip to be considered for artifact 
      detection
    inputBinding:
      position: 103
      prefix: --min-length
  - id: threads
    type:
      - 'null'
      - int
    doc: extra threads for parsing the bam file
    inputBinding:
      position: 103
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Number of bases considered outside of read or mate region for 
      re-alignment
    inputBinding:
      position: 103
      prefix: --window-size
  - id: bam
    type:
      - 'null'
      - boolean
    doc: output bam
    inputBinding:
      position: 104
      prefix: --bam
  - id: ubam
    type:
      - 'null'
      - boolean
    doc: output uncompressed bam
    inputBinding:
      position: 105
      prefix: --ubam
  - id: output_name
    type: string
    default: annotated.sam
    doc: File name for the annotated alignments (standard output); use a .bam 
      name with --bam or --ubam
outputs:
  - id: annotated
    type: stdout
    doc: Annotated alignments (standard output)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
