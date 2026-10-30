cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_fill_unaligned.py
label: wub_bam_fill_unaligned.py
doc: 'Generate SAM records for the reads present in the input fastq but missing from
  the input SAM/BAM.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_file
    type: File
    doc: Input file.
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output SAM file.
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: Input/output format (SAM).
    inputBinding:
      position: 101
      prefix: -f
  - id: fastq
    type: File
    doc: Input fastq.
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: output_sam
    type: File
    doc: SAM records including the reads missing from the input alignment file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
