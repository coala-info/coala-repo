cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2CompoundGraph
label: met4j_sbml2compoundgraph
doc: "Advanced creation of a compound graph representation of a SBML file content\n\
  \nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: input_sbml
    type: File
    doc: Input SBML file
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
