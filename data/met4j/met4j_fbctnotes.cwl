cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.FbcToNotes
label: met4j_fbctnotes
doc: "Convert FBC package annotations to sbml html notes\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
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
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
