cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - convert.Sbml2CarbonSkeletonNet
label: met4j_sbml2carbonskeletonnet
doc: "Create a carbon skeleton graph representation of a SBML file content, using
  GSAM atom-mapping file (see https://forgemia.inra.fr/metexplore/gsam)\n\nTool homepage:
  https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: input_sbml
    type: File
    doc: Input SBML file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_file
    type: File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
