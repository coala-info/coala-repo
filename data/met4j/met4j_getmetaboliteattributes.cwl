cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.GetMetaboliteAttributes
label: met4j_getmetaboliteattributes
doc: "Create a tabulated file with metabolite attributes from a SBML file\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sbml
    type: File
    doc: Input SBML file
    inputBinding:
      position: 1
      prefix: -i
  - id: output
    type: string
    doc: Output file
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
