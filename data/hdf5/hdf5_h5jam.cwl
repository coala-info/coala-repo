cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5jam
label: hdf5_h5jam
doc: "Adds a user block to the front of an HDF5 file and creates a new concatenated file.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: Specifies the input HDF5 file.
    inputBinding:
      position: 101
      prefix: -i
  - id: user_file
    type: File
    doc: Specifies the file to be inserted into the user block. Can be any file format except an HDF5 format.
    inputBinding:
      position: 101
      prefix: -u
  - id: output_file_path
    type: string
    doc: Specifies the output HDF5 file.
    inputBinding:
      position: 101
      prefix: -o
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Wipes out any existing user block before concatenating the given user block.
    inputBinding:
      position: 101
      prefix: --clobber
outputs:
  - id: output_file
    type: File
    doc: HDF5 file with the user block
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5jam.out
