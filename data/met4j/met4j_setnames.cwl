cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.SetNames
label: met4j_setnames
doc: "Set names to network objects in a SBML file from a tabulated file containing the object ids and the names The ids must correspond between the tabulated file and the SBML file. If prefix or suffix is different in the SBML file, use the -p or the -s options.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: comment
    type: ['null', string]
    doc: '[#] Comment String in the tabulated file. The lines beginning by this string won''t be read (default: #)'
    inputBinding:
      position: 1
      prefix: -c
  - id: col_id
    type: ['null', int]
    doc: '[1] number of the column where are the object ids (default: 1)'
    inputBinding:
      position: 2
      prefix: -ci
  - id: col_name
    type: ['null', int]
    doc: '[2] number of the column where are the names (default: 2)'
    inputBinding:
      position: 3
      prefix: -cname
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
    doc: '[deactivated] To match the objects in the sbml file, adds the prefix R_ to reactions and M_ to metabolites (default: false)'
    inputBinding:
      position: 7
      prefix: -p
  - id: suffix
    type: ['null', boolean]
    doc: '[deactivated] To match the objects in the sbml file, adds the suffix _comparmentID to metabolites (default: false)'
    inputBinding:
      position: 8
      prefix: -s
  - id: object_type
    type: ['null', string]
    doc: '[REACTION] Object type in the column id : REACTION;METABOLITE;GENE;PATHWAY (default: REACTION) Choices: REACTION, METABOLITE, GENE, PROTEIN, PATHWAY, COMPARTMENT'
    inputBinding:
      position: 9
      prefix: -t
  - id: input_tab
    type: File
    doc: Input Tabulated file
    inputBinding:
      position: 10
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
