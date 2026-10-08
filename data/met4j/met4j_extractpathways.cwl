cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.ExtractPathways
label: met4j_extractpathways
doc: "Extract pathway(s) from a SBML file and create a sub-network SBML file\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 1
      prefix: -i
  - id: output
    type: string
    doc: output SBML file
    inputBinding:
      position: 2
      prefix: -o
  - id: pathway_ids
    type: string
    doc: pathway identifiers, separated by "+" sign if more than one
    inputBinding:
      position: 3
      prefix: -p
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
