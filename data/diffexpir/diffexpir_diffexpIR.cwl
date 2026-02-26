cwlVersion: v1.2
class: CommandLineTool
baseCommand: diffexpIR
label: diffexpir_diffexpIR
doc: "Performs differential expression analysis.\n\nTool homepage: https://github.com/r78v10a07/DiffExpIR"
inputs:
  - id: fdr_correction
    type:
      - 'null'
      - boolean
    doc: FRD Correction on the P-Values
    inputBinding:
      position: 101
      prefix: --fdr
  - id: gene_key
    type:
      - 'null'
      - string
    doc: Gene key to use from GTF file.
    default: gene_id
    inputBinding:
      position: 101
      prefix: -k
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: GTF file
    inputBinding:
      position: 101
      prefix: -g
  - id: min_fold_change
    type:
      - 'null'
      - float
    doc: Minimum fold change to filter out
    default: 2.0
    inputBinding:
      position: 101
      prefix: -f
  - id: min_intron_exon_fold_change
    type:
      - 'null'
      - float
    doc: Minimum fold change between intron and neighboring exons
    default: -1.0
    inputBinding:
      position: 101
      prefix: -r
  - id: min_intron_size
    type:
      - 'null'
      - int
    doc: Smaller size allowed for an intron created for genes. We recommend to 
      use the reads length
    default: 16
    inputBinding:
      position: 101
      prefix: -c
  - id: min_p_value
    type:
      - 'null'
      - float
    doc: Minimum P-Value to filter out
    default: '1.0E-6'
    inputBinding:
      position: 101
      prefix: -v
  - id: sample_prefix
    type:
      - 'null'
      - string
    doc: Prefix for grouping samples. (sample_1,sample_2)
    inputBinding:
      position: 101
      prefix: -p
  - id: stat_method
    type:
      - 'null'
      - string
    doc: 'Stat method: ttest (default), wilcox'
    default: ttest
    inputBinding:
      position: 101
      prefix: -s
  - id: tpm_output_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the TPM output files
    inputBinding:
      position: 101
      prefix: -d
  - id: transcript_key
    type:
      - 'null'
      - string
    doc: Transcript key to use from GTF file.
    default: transcript_id
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/diffexpir:v0.0.1_cv5
