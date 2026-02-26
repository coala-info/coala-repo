cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript qualitymetrics_wrapper.R
label: qualitymetrics
doc: "Wrapper script for quality metrics calculation.\n\nTool homepage: https://github.com/SteinmetzLab/qualityMetrics"
inputs:
  - id: CV
    type: boolean
    doc: set the "Coefficient of Variation" option
    inputBinding:
      position: 101
  - id: Compa
    type: string
    doc: set the Compa option
    inputBinding:
      position: 101
  - id: batchColName
    type: string
    doc: the name of the column containing batch information
    inputBinding:
      position: 101
  - id: dataMatrix_in
    type: File
    doc: set the input data matrix file
    inputBinding:
      position: 101
  - id: injectionOrderColName
    type: string
    doc: the name of the column containing injection order information
    inputBinding:
      position: 101
  - id: poolAsPool1L
    type:
      - 'null'
      - string
    doc: set the poolAsPool1L option
    inputBinding:
      position: 101
  - id: sampleMetadata_in
    type: File
    doc: set the input sample metadata file
    inputBinding:
      position: 101
  - id: sampleTypeColName
    type: string
    doc: the name of the column containing sample type information
    inputBinding:
      position: 101
  - id: sampleTypeTags
    type: string
    doc: 'the tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample)'
    inputBinding:
      position: 101
  - id: seuil
    type: string
    doc: set the seuil option
    inputBinding:
      position: 101
  - id: variableMetadata_in
    type: File
    doc: set the input variable metadata_in file
    inputBinding:
      position: 101
outputs:
  - id: sampleMetadata_out
    type: File
    doc: set the output sample metadata file
    outputBinding:
      glob: $(inputs.sampleMetadata_out)
  - id: variableMetadata_out
    type: File
    doc: set the outputvariable metadata file
    outputBinding:
      glob: $(inputs.variableMetadata_out)
  - id: figure
    type: File
    doc: set the output figure file
    outputBinding:
      glob: $(inputs.figure)
  - id: information
    type: File
    doc: set the output information file
    outputBinding:
      glob: $(inputs.information)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qualitymetrics:phenomenal-v2.2.11_cv1.0.11
