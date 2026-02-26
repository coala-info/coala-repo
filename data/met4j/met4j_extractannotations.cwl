cwlVersion: v1.2
class: CommandLineTool
baseCommand: met4j
label: met4j_extractannotations
doc: "Extract databases' references from SBML annotations or notes.\n\nTool homepage:
  https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: package_function
    type: string
    doc: Package and function to execute (e.g., attributes.ExtractAnnotations)
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input SBML file
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
