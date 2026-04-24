cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_dc
label: metaxa_metaxa2_dc
doc: "Metaxa2 tool for combining multiple Metaxa2 results into a single data matrix.\n\
  \nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files to be processed
    inputBinding:
      position: 1
  - id: count_column
    type:
      - 'null'
      - int
    doc: Column containing count data
    inputBinding:
      position: 102
      prefix: -c
  - id: remove_string
    type:
      - 'null'
      - string
    doc: String to be removed from the file name for use as sample name. Regular
      expressions can be used.
    inputBinding:
      position: 102
      prefix: -r
  - id: sample_name_pattern
    type:
      - 'null'
      - string
    doc: Regular expression pattern for selecting the sample name from the file 
      name.
    inputBinding:
      position: 102
      prefix: -p
  - id: taxon_column
    type:
      - 'null'
      - int
    doc: Column containing taxon data
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
