cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - /files/qualitymetrics/qualitymetrics_wrapper.R
label: qualitymetrics
doc: "Wrapper script for quality metrics calculation.\n\nTool homepage: https://github.com/SteinmetzLab/qualityMetrics"
inputs:
  - id: CV
    type: boolean
    doc: set the "Coefficient of Variation" option
    inputBinding:
      position: 101
      prefix: CV
      valueFrom: "$(self ? 'TRUE' : 'FALSE')"
  - id: Compa
    type: string
    doc: set the Compa option
    inputBinding:
      position: 101
      prefix: Compa
  - id: batchColName
    type: string
    doc: the name of the column containing batch information
    inputBinding:
      position: 101
      prefix: batchColName
  - id: dataMatrix_in
    type: File
    doc: set the input data matrix file
    inputBinding:
      position: 101
      prefix: dataMatrix_in
  - id: injectionOrderColName
    type: string
    doc: the name of the column containing injection order information
    inputBinding:
      position: 101
      prefix: injectionOrderColName
  - id: poolAsPool1L
    type:
      - 'null'
      - string
    doc: set the poolAsPool1L option
    inputBinding:
      position: 101
      prefix: poolAsPool1L
  - id: sampleMetadata_in
    type: File
    doc: set the input sample metadata file
    inputBinding:
      position: 101
      prefix: sampleMetadata_in
  - id: sampleTypeColName
    type: string
    doc: the name of the column containing sample type information
    inputBinding:
      position: 101
      prefix: sampleTypeColName
  - id: sampleTypeTags
    type: string
    doc: 'the tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample)'
    inputBinding:
      position: 101
      prefix: sampleTypeTags
  - id: seuil
    type: string
    doc: set the seuil option
    inputBinding:
      position: 101
      prefix: seuil
  - id: variableMetadata_in
    type: File
    doc: set the input variable metadata_in file
    inputBinding:
      position: 101
      prefix: variableMetadata_in
  - id: figure_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `figure_path`
    inputBinding:
      position: 102
      prefix: figure
  - id: information_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `information_path`
    inputBinding:
      position: 103
      prefix: information
  - id: sampleMetadata_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `sampleMetadata_out_path`
    inputBinding:
      position: 104
      prefix: sampleMetadata_out
  - id: variableMetadata_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `variableMetadata_out_path`
    inputBinding:
      position: 105
      prefix: variableMetadata_out
outputs:
  - id: sampleMetadata_out
    type: File
    doc: set the output sample metadata file
    outputBinding:
      glob: $(inputs.sampleMetadata_out_path)
  - id: variableMetadata_out
    type: File
    doc: set the outputvariable metadata file
    outputBinding:
      glob: $(inputs.variableMetadata_out_path)
  - id: figure
    type: File
    doc: set the output figure file
    outputBinding:
      glob: $(inputs.figure_path)
  - id: information
    type: File
    doc: set the output information file
    outputBinding:
      glob: $(inputs.information_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qualitymetrics:phenomenal-v2.2.11_cv1.0.11
