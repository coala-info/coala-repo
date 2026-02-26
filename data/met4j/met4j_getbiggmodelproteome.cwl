cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - bigg.GetBiggModelProteome
label: met4j_getbiggmodelproteome
doc: "Get proteome in fasta format of a model present in the BIGG database\n\nTool
  homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
inputs:
  - id: input_file
    type: File
    doc: Input SBML file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
