cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - attributes.ExtractAnnotations
label: met4j_extractannotations
doc: "Extract databases' references from SBML annotations or notes. The references are exported as a tabulated file with one column with the SBML compound, reaction or gene identifiers, and one column with the corresponding database identifier.The name of the targeted database need to be provided under the same form than the one used in the notes field or the identifiers.org uri.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: database
    type: string
    doc: name of the referenced database to export annotations from, as listed in notes or identifiers.org base uri
    inputBinding:
      position: 1
      prefix: -db
  - id: export_type
    type: string
    doc: 'the type of entity to extract annotation, either metabolite, reaction, or gene Choices: METABOLITE, REACTION, GENE'
    inputBinding:
      position: 2
      prefix: -export
  - id: input_sbml
    type: File
    doc: input SBML file
    inputBinding:
      position: 3
      prefix: -i
  - id: output
    type: string
    doc: output file path
    inputBinding:
      position: 4
      prefix: -o
  - id: skip_missing
    type: ['null', boolean]
    doc: 'Skip entities without the selected annotations, by default output them with NA value (default: false)'
    inputBinding:
      position: 5
      prefix: -skip
  - id: uniq
    type: ['null', boolean]
    doc: 'keep only one identifier if multiple are referenced for the same entity (default: false)'
    inputBinding:
      position: 6
      prefix: -uniq
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
