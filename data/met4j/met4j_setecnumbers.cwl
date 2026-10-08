cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.SetEcNumbers
label: met4j_setecnumbers
doc: "Set EC numbers to reactions in a SBML file from a tabulated file containing the reaction ids and the EC numbers The ids must correspond between the tabulated file and the SBML file. If prefix R_ is present in the ids in the SBML file and not in the tabulated file, use the -p option. The EC will be written in the SBML file in two locations: - in the reaction HTML notes (e.g. EC_NUMBER: 2.4.2.14) - as a reaction MIRIAM annotation (see https://pubmed.ncbi.nlm.nih.gov/16333295/) with ec-code identifiers link (https://registry.identifiers.org/registry/ec-code)\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: comment
    type: ['null', string]
    doc: '[#] Comment String in the tabulated file. The lines beginning by this string won''t be read (default: #)'
    inputBinding:
      position: 1
      prefix: -c
  - id: col_ec
    type: ['null', int]
    doc: '[2] number of the column where are the ecs (default: 2)'
    inputBinding:
      position: 2
      prefix: -cec
  - id: col_id
    type: ['null', int]
    doc: '[1] number of the column where are the reaction ids (default: 1)'
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
    doc: '[deactivated] To match the objects in the sbml file, adds the prefix R_ to reactions (default: false)'
    inputBinding:
      position: 7
      prefix: -p
  - id: input_tab
    type: File
    doc: Input Tabulated file
    inputBinding:
      position: 8
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
