cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dimspy
  - hdf5-pls-to-txt
label: dimspy_hdf5-pls-to-txt
doc: "Converts HDF5 peaklist objects to text files.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Values on each line of the file are separated by this character.
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: input
    type: File
    doc: HDF5 file that contains a list of peaklist objects from one of the 
      processing steps.
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Directory to write to.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
