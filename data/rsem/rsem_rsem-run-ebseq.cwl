cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-run-ebseq]
label: rsem_rsem-run-ebseq
doc: "Wrapper for EBSeq to perform differential expression analysis on two or more conditions.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: ngvector
    type: ['null', File]
    doc: Grouping information required by EBSeq for isoform-level differential expression analysis (made by rsem-generate-ngvector). Recommended for isoform-level analysis.
    inputBinding:
      position: 1
      prefix: --ngvector
  - id: data_matrix_file
    type: File
    doc: m by n matrix of expected counts (m genes/transcripts, n samples), e.g. from rsem-generate-data-matrix.
    inputBinding:
      position: 2
  - id: conditions
    type: string
    doc: Comma-separated number of replicates of each condition, e.g. "3,3" or "2,3,3".
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: Output file name.
    inputBinding:
      position: 4
outputs:
  - id: results
    type: File
    doc: Statistics for all genes/transcripts, in descending order of PPDE.
    outputBinding:
      glob: $(inputs.output_file)
  - id: normalized_data_matrix
    type: File
    doc: Median normalized version of the input data matrix.
    outputBinding:
      glob: $(inputs.output_file).normalized_data_matrix
  - id: pattern
    type: ['null', File]
    doc: Expression patterns over the conditions (only with more than 2 conditions).
    outputBinding:
      glob: $(inputs.output_file).pattern
  - id: condmeans
    type: ['null', File]
    doc: Normalized mean count of each gene/transcript at each condition (only with more than 2 conditions).
    outputBinding:
      glob: $(inputs.output_file).condmeans
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
