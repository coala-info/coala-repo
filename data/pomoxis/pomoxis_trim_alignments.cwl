cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trim_alignments
label: pomoxis_trim_alignments
doc: "Trim alignments in multiple bams to a common overlap window.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: 'Input bam files (indexed): one bam with several reads, or several bams with one read each.'
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: ref_name
    type:
      - 'null'
      - string
    doc: Reference to process, only needed if the bams contain multiple references.
    inputBinding:
      position: 102
      prefix: --ref_name
  - id: output_prefix
    type:
      - 'null'
      - string
    default: trimmed
    doc: Prefix for outputs.
    inputBinding:
      position: 102
      prefix: --output_prefix
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Reference fasta to trim to the alignment window.
    inputBinding:
      position: 102
      prefix: --reference_fasta
outputs:
  - id: trimmed_queries
    type: File
    doc: Queries trimmed to the common window.
    outputBinding:
      glob: $(inputs.output_prefix)_queries.fasta
  - id: trimmed_reference
    type:
      - 'null'
      - File
    doc: Reference trimmed to the common window.
    outputBinding:
      glob: $(inputs.output_prefix)_reference.fasta
  - id: log
    type: stdout
    doc: Alignment windows printed by the tool.
stdout: trim_alignments.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
