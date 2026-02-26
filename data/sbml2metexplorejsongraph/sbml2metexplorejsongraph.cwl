cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbml2metexplorejsongraph
label: sbml2metexplorejsongraph
doc: "Convert Flux data contained in the SBML as mapping data\n\nTool homepage: https://github.com/bmerlet90/tool-SBML2MetexploreJsonGraph"
inputs:
  - id: flux2mapp
    type:
      - 'null'
      - boolean
    doc: Convert Flux data contained in the SBML as mapping data
    default: false
    inputBinding:
      position: 101
      prefix: -flux2Mapp
  - id: input_sbml_file
    type: File
    doc: Input SBML file.
    inputBinding:
      position: 101
      prefix: -inFile
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Validate input SBML file.
    default: false
    inputBinding:
      position: 101
      prefix: -validate
outputs:
  - id: output_json_file
    type: File
    doc: Output json file name.
    outputBinding:
      glob: $(inputs.output_json_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sbml2metexplorejsongraph:phenomenal-v1.2_cv1.1.7
