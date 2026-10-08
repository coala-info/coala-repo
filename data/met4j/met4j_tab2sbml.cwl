cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Tab2Sbml
label: met4j_tab2sbml
doc: "Create a Sbml File from a tabulated file that contains the reaction ids and the formulas\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: palsson_convention
    type: ['null', boolean]
    doc: '[false] Use Palsson et al. convention: compartment suffix in metabolite ids with _ separator (default: false)'
    inputBinding:
      position: 1
      prefix: -M_c
  - id: boundary
    type: ['null', string]
    doc: set a compartment as the system boundary. All metabolites in this compartment will have the attribute `boundaryCondition` set to true in the sbml.
    inputBinding:
      position: 2
      prefix: -b
  - id: col_formula
    type: ['null', int]
    doc: '[2] number of the column where are the reaction formulas (default: 2)'
    inputBinding:
      position: 3
      prefix: -cf
  - id: col_id
    type: ['null', int]
    doc: '[1] number of the column where are the reaction ids (default: 1)'
    inputBinding:
      position: 4
      prefix: -ci
  - id: default_compartment
    type: ['null', string]
    doc: '[c] Default compartment (default: c)'
    inputBinding:
      position: 5
      prefix: -dcpt
  - id: input_tab
    type: File
    doc: Tabulated file
    inputBinding:
      position: 6
      prefix: -i
  - id: model_id
    type: ['null', string]
    doc: '[NA] Model id written in the SBML file (default: NA)'
    inputBinding:
      position: 7
      prefix: -id
  - id: ignore_failed_read
    type: ['null', boolean]
    doc: 'skip lines with parsing errors instead of stopping the process (default: false)'
    inputBinding:
      position: 8
      prefix: -ign
  - id: irreversible_string
    type: ['null', string]
    doc: '[-->] String for irreversible reaction (default: -->)'
    inputBinding:
      position: 9
      prefix: -irr
  - id: skip_lines
    type: ['null', int]
    doc: '[0] Number of lines to skip at the beginning of the tabulated file (default: 0)'
    inputBinding:
      position: 10
      prefix: -n
  - id: output
    type: string
    default: out.sbml
    doc: '[out.sbml] Out sbml file (default: out.sbml)'
    inputBinding:
      position: 11
      prefix: -o
  - id: reversible_string
    type: ['null', string]
    doc: '[<==>] String for reversible reaction (default: <==>)'
    inputBinding:
      position: 12
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
