cwlVersion: v1.2
class: CommandLineTool
baseCommand: met4j
label: met4j_getmetaboliteattributes
doc: "The applications are classified by package. The complete class name must be
  provided (e.g. fr.inrae.toulouse.metexplore.met4j_toolbox.attributes.SbmlSetChargesFromFile)
  to launch the app Launch the application with the -h parameter to get the list of
  the parameters and a complete description.\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: package_function
    type: string
    doc: Package and function to execute (e.g., convert.Sbml2Graph)
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 102
      prefix: -i
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
