cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5import
label: hdf5_h5import
doc: "Converts data stored in an ASCII or binary file into an HDF5 dataset, following the settings in a configuration file.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: Input file with a single n-dimensional floating point or integer array in ASCII text or binary, or text strings
    inputBinding:
      position: 1
  - id: config_file
    type: File
    doc: Configuration file for the input file (CONFIG-KEYWORD VALUE lines, or the ddl produced by h5dump)
    inputBinding:
      position: 2
      prefix: -c
  - id: output_file_path
    type: string
    doc: Name of the HDF5 output file. It may be an existing file or a new one.
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: HDF5 file with the new dataset
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5import.out
