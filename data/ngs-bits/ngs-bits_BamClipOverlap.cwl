cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamClipOverlap
label: ngs-bits_BamClipOverlap
doc: "Softclipping of overlapping reads.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: Turn off indel detection in overlap.
    inputBinding:
      position: 101
      prefix: --ignore_indels
  - id: input_file
    type: File
    doc: Input BAM/CRAM file. Needs to be sorted by name.
    inputBinding:
      position: 101
      prefix: -in
  - id: overlap_mismatch_basen
    type:
      - 'null'
      - boolean
    doc: Set base to N if mismatch is found in overlapping reads.
    inputBinding:
      position: 101
      prefix: --overlap_mismatch_basen
  - id: overlap_mismatch_baseq
    type:
      - 'null'
      - boolean
    doc: Reduce base quality if mismatch is found in overlapping reads.
    inputBinding:
      position: 101
      prefix: --overlap_mismatch_baseq
  - id: overlap_mismatch_mapq
    type:
      - 'null'
      - boolean
    doc: Set mapping quality of pair to 0 if mismatch is found in overlapping 
      reads.
    inputBinding:
      position: 101
      prefix: --overlap_mismatch_mapq
  - id: overlap_mismatch_remove
    type:
      - 'null'
      - boolean
    doc: Remove pair if mismatch is found in overlapping reads.
    inputBinding:
      position: 101
      prefix: --overlap_mismatch_remove
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
