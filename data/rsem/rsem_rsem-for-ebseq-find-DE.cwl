cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-for-ebseq-find-DE
label: rsem_rsem-for-ebseq-find-DE
doc: "Find differentially expressed genes or isoforms with EBSeq from a data
  matrix of expected counts (made by rsem-generate-data-matrix). With two
  conditions it runs EBTest, with more it runs EBMultiTest. It also writes the
  normalized data matrix (output_file.normalized_data_matrix).\n\nTool
  homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: path
    type: string
    doc: Directory added to the R library paths, to find the EBSeq package. Use 
      '.' when EBSeq is installed in the default R library.
    inputBinding:
      position: 1
  - id: ngvector_file
    type:
      - 'null'
      - File
    doc: The NgVector file made by 
      rsem-for-ebseq-generate-ngvector-from-clustering-info. When it is not
      given, '#' is passed and EBSeq runs without an NgVector.
  - id: data_matrix_file
    type: File
    doc: The data matrix of expected counts, one column for each sample.
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: The name of the output file. 
      output_file.normalized_data_matrix is written too.
    inputBinding:
      position: 4
  - id: number_of_replicates
    type:
      type: array
      items: int
    doc: The number of replicates of condition 1, condition 2, ... (one number 
      for each condition; their sum must equal the number of matrix columns).
    inputBinding:
      position: 5
outputs:
  - id: de_results
    type: File
    outputBinding:
      glob: $(inputs.output_file)
    doc: The differential expression results.
  - id: normalized_data_matrix
    type: File
    outputBinding:
      glob: $(inputs.output_file).normalized_data_matrix
    doc: The normalized data matrix.
  - id: multi_condition_files
    type:
      type: array
      items: File
    outputBinding:
      glob:
        - $(inputs.output_file).condmeans
        - $(inputs.output_file).pattern
    doc: The condition means and the pattern table (written only when there are more
      than two conditions).
arguments:
  - position: 2
    valueFrom: '$(inputs.ngvector_file ? inputs.ngvector_file.path : "#")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
