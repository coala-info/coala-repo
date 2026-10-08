cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -nifti-information
label: connectome-workbench_wb_command_nifti-information
doc: 'You must specify at least one -print-* option.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: print_header_rec
        type: record
        fields:
          - name: allow_truncated
            type:
              - 'null'
              - boolean
            doc: print the header even if the data is truncated
            inputBinding:
              position: 1
              prefix: -allow-truncated
      - name: print_xml_rec
        type: record
        fields:
          - name: version
            type:
              - 'null'
              - string
            doc: convert the XML to a specific CIFTI version (default is the file's
              cifti version)
            inputBinding:
              position: 1
              prefix: -version
inputs:
  - id: nifti_file
    type: File
    doc: the nifti/cifti file to examine
    inputBinding:
      position: 1
  - id: print_header
    type:
      - 'null'
      - print_header_rec
    doc: display the header contents
    inputBinding:
      position: 2
      prefix: -print-header
  - id: print_matrix
    type:
      - 'null'
      - boolean
    doc: output the values in the matrix (cifti only)
    inputBinding:
      position: 2
      prefix: -print-matrix
  - id: print_xml
    type:
      - 'null'
      - print_xml_rec
    doc: print the cifti XML (cifti only)
    inputBinding:
      position: 2
      prefix: -print-xml
  - id: output_name
    type: string
    default: nifti-information.txt
    doc: name of the file that receives the printed output
outputs:
  - id: output
    type: File
    doc: the printed output
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
