cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.SetReferences
label: met4j_setreferences
doc: "Add references to network objects in a SBML file from a tabulated file containing the metabolite ids and the references Reference name given as parameter (-ref) must correspond to an existing id in the registry of identifiers.org (https://registry.identifiers.org/registry) The corresponding key:value pair will be written as metabolite or reaction MIRIAM annotation (see https://pubmed.ncbi.nlm.nih.gov/16333295/)\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
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
  - id: col_ref
    type: ['null', int]
    doc: '[2] number of the column where are the references (default: 2)'
    inputBinding:
      position: 3
      prefix: -cr
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
  - id: ref_name
    type: string
    doc: Name of the reference. Must exist in identifiers.org (https://registry.iden tifiers.org/registry)
    inputBinding:
      position: 8
      prefix: -ref
  - id: suffix
    type: ['null', boolean]
    doc: '[deactivated] To match the objects in the sbml file, adds the suffix _comparmentID to metabolites (default: false)'
    inputBinding:
      position: 9
      prefix: -s
  - id: object_type
    type: ['null', string]
    doc: '[REACTION] Object type in the column id : REACTION;METABOLITE;GENE;PATHWAY (default: REACTION) Choices: REACTION, METABOLITE, GENE, PROTEIN, PATHWAY, COMPARTMENT'
    inputBinding:
      position: 10
      prefix: -t
  - id: input_tab
    type: File
    doc: Input Tabulated file
    inputBinding:
      position: 11
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
