cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2Tab
label: met4j_sbml2tab
doc: "Create a tabulated file listing reaction attributes from a SBML file\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sbml
    type: File
    doc: Sbml file
    inputBinding:
      position: 1
      prefix: -i
  - id: irreversible_string
    type: ['null', string]
    doc: '[-->] String for irreversible reaction (default: -->)'
    inputBinding:
      position: 2
      prefix: -irr
  - id: output
    type: string
    default: out.tsv
    doc: '[out.tsv] Tabulated file (default: out.tsv)'
    inputBinding:
      position: 3
      prefix: -o
  - id: reversible_string
    type: ['null', string]
    doc: '[<==>] String for reversible reaction (default: <==>)'
    inputBinding:
      position: 4
      prefix: -rev
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
