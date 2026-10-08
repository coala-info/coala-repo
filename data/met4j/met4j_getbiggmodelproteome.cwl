cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - met4j
  - bigg.GetBiggModelProteome
label: met4j_getbiggmodelproteome
doc: "Get proteome in fasta format of a model present in the BIGG database\n\nTool homepage: https://forgemia.inra.fr/metexplore/met4j/-/blob/master/met4j-toolbox/README.md"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: model_id
    type: string
    doc: '[ex: iMM904] id of the BIGG model'
    inputBinding:
      position: 1
      prefix: -m
  - id: output
    type: string
    default: proteome.fas
    doc: '[proteome.fas] path of the output file (default: proteome.fas)'
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output file written by -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/met4j:2.2.2--hdfd78af_0
