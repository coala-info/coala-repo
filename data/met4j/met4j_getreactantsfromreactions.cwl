cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
label: met4j_getreactantsfromreactions
doc: "Get reactant lists from a list of reactions and a SBML file.\n\nTool homepage:
  https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: package_function
    type: string
    doc: Package and function name (e.g., attributes.GetReactantsFromReactions)
    inputBinding:
      position: 1
  - id: input_sbml_file
    type: File
    doc: Input SBML file
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
