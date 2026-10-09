cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5copy
label: hdf5_h5copy
doc: "Copies an HDF5 object (dataset, group or named datatype) from one file to another.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: Input HDF5 file name
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file_path
    type: string
    doc: Output HDF5 file name (created if it does not exist)
    inputBinding:
      position: 2
      prefix: -o
  - id: source_object
    type: string
    doc: Source object name
    inputBinding:
      position: 3
      prefix: -s
  - id: destination_object
    type: string
    doc: Destination object name
    inputBinding:
      position: 4
      prefix: -d
  - id: parents
    type:
      - 'null'
      - boolean
    doc: No error if existing, make parent groups as needed
    inputBinding:
      position: 5
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information about OBJECTS and OPTIONS
    inputBinding:
      position: 5
      prefix: -v
  - id: enable_error_stack
    type:
      - 'null'
      - boolean
    doc: Prints messages from the HDF5 error stack as they occur.
    inputBinding:
      position: 5
      prefix: --enable-error-stack
  - id: flag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -f
    doc: 'Flag type: shallow, soft, ext, ref, noattr or allflags. Repeat to give several flags.'
    inputBinding:
      position: 5
outputs:
  - id: output_file
    type: File
    doc: Output HDF5 file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5copy.out
