cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5unjam
label: hdf5_h5unjam
doc: "Splits an HDF5 file with a user block into a user block file and an HDF5 file without a user block.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: Specifies the HDF5 as input. If the input HDF5 file contains no user block, exit with an error message.
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Specifies output HDF5 file without a user block.
    inputBinding:
      position: 101
      prefix: -o
  - id: user_file_path
    type:
      - 'null'
      - string
    doc: Specifies the output file containing the data from the user block. Cannot be used with the delete option.
    inputBinding:
      position: 101
      prefix: -u
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Remove the user block from the input HDF5 file. The content of the user block is discarded. Cannot be used with the user_file_path option.
    inputBinding:
      position: 101
      prefix: --delete
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: HDF5 file without the user block
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: user_file
    type:
      - 'null'
      - File
    doc: File with the user block data
    outputBinding:
      glob: $(inputs.user_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (the user block, when neither delete nor user_file_path is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5unjam.out
