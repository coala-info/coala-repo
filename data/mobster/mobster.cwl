cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobster
label: mobster
doc: "Predict non-reference Mobile Element Insertion (MEI) events using one properties
  file.\n\nTool homepage: https://github.com/jyhehir/mobster"
inputs:
  - id: input_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: input .bam file. This value will override corresponding value in 
      properties file. Multiple BAM files may be specified if seperated by a 
      comma
    inputBinding:
      position: 101
      prefix: -in
  - id: properties
    type:
      - 'null'
      - File
    doc: properties file
    inputBinding:
      position: 101
      prefix: -properties
  - id: sample_name
    type:
      - 'null'
      - type: array
        items: string
    doc: sample name. This value will override corresponding value in properties
      file. Multiple sample names may be specified if seperated by a comma
    inputBinding:
      position: 101
      prefix: -sn
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: output prefix. This value will override corresponding value in 
      properties file.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobster:0.2.4.1--py36_0
