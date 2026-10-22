cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tttrlib
  - image
  - export
label: tttrlib_image_export
doc: "Export image from LSM file. The image is written as a TIFF file next to the input file.\n\nTool homepage: https://github.com/fluorescence-tools/tttrlib"
inputs:
  - id: input
    type: File
    doc: Input photon file of a laser scanning microscope measurement (for example a PicoQuant PTU file)
    inputBinding:
      position: 2
  - id: channels
    type:
      - 'null'
      - string
    doc: List of routing channel numbers considered. Photons in detection channels separated by commas are integrated/combined in groups. Groups are separated by colons. The input "0,3:1,2" outputs two images where photons of channel 0,3 and 1,2 are combined. By default all photons of all channels are combined.
    inputBinding:
      position: 1
      prefix: --channels
outputs:
  - id: images
    type:
      type: array
      items: File
    doc: Exported TIFF images
    outputBinding:
      glob: "*.tif"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
