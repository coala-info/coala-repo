cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.SetGprs
label: met4j_setgprs
doc: "Create a new SBML file from an original sbml file and a tabulated file containing reaction ids and Gene association written in a cobra way The ids must correspond between the tabulated file and the SBML file. If prefix R_ is present in the ids in the SBML file and not in the tabulated file, use the -p option. GPR must be written in a cobra way in the tabulated file as described in Schellenberger et al 2011 Nature Protocols 6(9):1290-307 (The GPR will be written in the SBML file in two locations: - in the reaction html notes (GENE_ASSOCIATION: ( XC_0401 ) OR ( XC_3282 )) - as fbc gene product association (see FBC package specifications: https://doi.org/10.1515/jib-2017-0082)\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: comment
    type: ['null', string]
    doc: '[#] Comment String in the tabulated file. The lines beginning by this string won''t be read (default: #)'
    inputBinding:
      position: 1
      prefix: -c
  - id: col_gpr
    type: ['null', int]
    doc: '[2] number of the column where are the gprs (default: 2)'
    inputBinding:
      position: 2
      prefix: -cgpr
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
