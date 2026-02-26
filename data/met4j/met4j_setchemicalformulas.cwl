cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
label: met4j_setchemicalformulas
doc: "Set Formula to network metabolites from a tabulated file containing the metabolite
  ids and the formulas\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: input_file
    type: File
    doc: tabulated file containing the metabolite ids and the formulas
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output SBML file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
