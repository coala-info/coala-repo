cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.SetPathways
label: met4j_setpathways
doc: "Set pathway to reactions in a network from a tabulated file containing the reaction ids and the pathways The ids must correspond between the tabulated file and the SBML file. If prefix R_ is present in the ids in the SBML file and not in the tabulated file, use the -p option. Pathways will be written in the SBML file in two ways:- as reaction note (e.g. SUBSYSTEM: purine_biosynthesis)- as SBML group (see Group package specifications: https://pmc.ncbi.nlm.nih.gov/articles/PMC5451322/)\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
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
    doc: '[1] number of the column where are the reaction ids (default: 1)'
    inputBinding:
      position: 2
      prefix: -ci
  - id: col_pathway
    type: ['null', int]
    doc: '[2] number of the column where are the pathways (default: 2)'
    inputBinding:
      position: 3
      prefix: -cp
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
  - id: separator
    type: ['null', string]
    doc: '[|] Separator of pathways in the tabulated file (default: |)'
    inputBinding:
      position: 8
      prefix: -sep
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
