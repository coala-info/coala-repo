cwlVersion: v1.2
class: CommandLineTool
baseCommand: gif2h5
label: hdf5_gif2h5
doc: "Converts a GIF file into an HDF5 file with an image dataset and a palette.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: gif_file
    type: File
    doc: Input GIF file
    inputBinding:
      position: 1
  - id: hdf_file
    type: string
    doc: Output HDF5 file name
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: HDF5 file
    outputBinding:
      glob: $(inputs.hdf_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_gif2h5.out
