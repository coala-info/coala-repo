cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.SetCharges
label: met4j_setcharges
doc: "Set charge to metabolites in a SBML file from a tabulated file containing the metabolite ids and the charges The charge must be a number. The ids must correspond between the tabulated file and the SBML file. If prefix or suffix is different in the SBML file, use the -p or the -s options. The charge will be written in the SBML file in two locations:+ - in the reaction notes (e.g. charge: -1) - as fbc attribute (e.g. fbc:charge=\"1\")\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: comment
    type: ['null', string]
    doc: '[#] Comment String in the tabulated file. The lines beginning by this string won''t be read (default: #)'
    inputBinding:
      position: 1
      prefix: -c
  - id: col_charge
    type: ['null', int]
    doc: '[2] number of the column where are the charges (default: 2)'
    inputBinding:
      position: 2
      prefix: -cc
  - id: col_id
    type: ['null', int]
    doc: '[1] number of the column where are the metabolite ids (default: 1)'
    inputBinding:
      position: 3
      prefix: -ci
  - id: input_sbml
    type: File
    doc: Original SBML file
    inputBinding:
      position: 4
      prefix: -i
  - id: skip_lines
    type: ['null', int]
    doc: '[0] Number of lines to skip at the beginning of the tabulated file (default: 0)'
    inputBinding:
      position: 5
      prefix: -n
  - id: output
    type: string
    default: out.sbml
    doc: '[out.sbml] SBML output file (default: out.sbml)'
    inputBinding:
      position: 6
      prefix: -o
  - id: prefix
    type: ['null', boolean]
    doc: '[deactivated] To match the objects in the sbml file, adds the prefix M_ to metabolite ids (default: false)'
    inputBinding:
      position: 7
      prefix: -p
  - id: suffix
    type: ['null', boolean]
    doc: '[deactivated] To match the objects in the sbml file, adds the suffix _comparmentID to metabolites (default: false)'
    inputBinding:
      position: 8
      prefix: -s
  - id: input_tab
    type: File
    doc: Input Tabulated file
    inputBinding:
      position: 9
      prefix: -tab
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
