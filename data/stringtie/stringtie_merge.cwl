cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stringtie
  - --merge
label: stringtie_merge
doc: "Assemble transcripts from multiple input files generating a unified non-redundant
  set of isoforms.\n\nTool homepage: https://ccb.jhu.edu/software/stringtie"
inputs:
  - id: input_gtf_list
    type:
      type: array
      items: File
    doc: List of GTF files or stringtie output files to merge
    inputBinding:
      position: 1
  - id: gap_len
    type:
      - 'null'
      - int
    doc: Gap between transcripts to merge together
    default: 250
    inputBinding:
      position: 102
      prefix: -g
  - id: guide_gff
    type:
      - 'null'
      - File
    doc: Reference annotation to include in the merging (GTF/GFF3)
    inputBinding:
      position: 102
      prefix: -G
  - id: keep_retained_introns
    type:
      - 'null'
      - boolean
    doc: Keep merged transcripts with retained introns; by default these are not
      kept unless there is strong evidence for them
    inputBinding:
      position: 102
      prefix: -i
  - id: label
    type:
      - 'null'
      - string
    doc: Name prefix for output transcripts
    default: MSTRG
    inputBinding:
      position: 102
      prefix: -l
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum input transcript coverage to include in the merge
    default: 0
    inputBinding:
      position: 102
      prefix: -c
  - id: min_fpkm
    type:
      - 'null'
      - float
    doc: Minimum input transcript FPKM to include in the merge
    default: 1.0
    inputBinding:
      position: 102
      prefix: -F
  - id: min_isoform_fraction
    type:
      - 'null'
      - float
    doc: Minimum isoform fraction
    default: 0.01
    inputBinding:
      position: 102
      prefix: -f
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum input transcript length to include in the merge
    default: 50
    inputBinding:
      position: 102
      prefix: -m
  - id: min_tpm
    type:
      - 'null'
      - float
    doc: Minimum input transcript TPM to include in the merge
    default: 1.0
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: output_gtf
    type:
      - 'null'
      - File
    doc: Output file name for the merged transcripts GTF
    outputBinding:
      glob: $(inputs.output_gtf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringtie:3.0.3--h29c0135_0
