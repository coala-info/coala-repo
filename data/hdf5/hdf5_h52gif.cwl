cwlVersion: v1.2
class: CommandLineTool
baseCommand: h52gif
label: hdf5_h52gif
doc: "Converts an HDF5 image dataset (with an optional palette) into a GIF file.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: h5_file
    type: File
    doc: Input HDF5 file
    inputBinding:
      position: 1
  - id: gif_file
    type: string
    doc: Output GIF file name
    inputBinding:
      position: 2
  - id: h5_image
    type: string
    doc: Name of the HDF5 image dataset (its palette is taken from the image's PALETTE attribute)
    inputBinding:
      position: 3
      prefix: -i
outputs:
  - id: output_gif
    type: File
    doc: GIF file
    outputBinding:
      glob: $(inputs.gif_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h52gif.out
