cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5clear
label: hdf5_h5clear
doc: "Clears the status flags in the superblock of an HDF5 file, removes the metadata cache image, or sets the end-of-allocation address.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: HDF5 file to change (copied to the working directory and modified there)
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
  - id: status
    type:
      - 'null'
      - boolean
    doc: Clear the status_flags field in the file's superblock
    inputBinding:
      position: 101
      prefix: -s
  - id: image
    type:
      - 'null'
      - boolean
    doc: Remove the metadata cache image from the file
    inputBinding:
      position: 101
      prefix: -m
  - id: filesize
    type:
      - 'null'
      - boolean
    doc: Print the file's EOA and EOF
    inputBinding:
      position: 101
      prefix: --filesize
  - id: increment
    type:
      - 'null'
      - int
    doc: Set the file's EOA to the maximum of (EOA, EOF) + C for the file. C is >= 0.
    inputBinding:
      position: 101
      prefix: '--increment='
      separate: false
outputs:
  - id: output_file
    type: File
    doc: HDF5 file after the change
    outputBinding:
      glob: $(inputs.input_file.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5clear.out
