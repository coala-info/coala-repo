cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam-stats
label: ea-utils_sam-stats
doc: "Produces lots of easily digested statistics for the files listed\n\nTool homepage:
  https://expressionanalysis.github.io/ea-utils/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: ascii_signature_size
    type:
      - 'null'
      - int
    doc: Size of ascii-signature
    default: 30
    inputBinding:
      position: 102
      prefix: -S
  - id: coverage_rna_output
    type:
      - 'null'
      - File
    doc: Coverage/RNA output (coverage, 3' bias, etc, implies -A)
    inputBinding:
      position: 102
      prefix: -R
  - id: file_extension_multiple_files
    type:
      - 'null'
      - string
    doc: File extension for handling multiple files
    default: stats
    inputBinding:
      position: 102
      prefix: -x
  - id: input_is_bam
    type:
      - 'null'
      - boolean
    doc: Input is bam, don't bother looking at magic
    inputBinding:
      position: 102
      prefix: -B
  - id: keep_multiple_alignments
    type:
      - 'null'
      - boolean
    doc: Keep track of multiple alignments
    inputBinding:
      position: 102
      prefix: -D
  - id: no_fail_zero_entries
    type:
      - 'null'
      - boolean
    doc: Don't fail when zero entries in sam
    inputBinding:
      position: 102
      prefix: -z
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix enabling extended output (see below)
    inputBinding:
      position: 102
      prefix: -O
  - id: overwrite_if_newer
    type:
      - 'null'
      - boolean
    doc: Only overwrite if newer (requires -x, or multiple files)
    inputBinding:
      position: 102
      prefix: -M
  - id: report_all_chr_sigs
    type:
      - 'null'
      - boolean
    doc: Report all chr sigs, even if there are more than 1000
    inputBinding:
      position: 102
      prefix: -A
  - id: sample_reads_per_base_stats
    type:
      - 'null'
      - int
    doc: Number of reads to sample for per-base stats
    default: 1M
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_sam-stats.out
