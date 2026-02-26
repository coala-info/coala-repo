cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamb bin
label: vamb_bin
doc: "Binning module of VAMB\n\nTool homepage: https://github.com/RasmussenLab/vamb"
inputs:
  - id: binner_mode
    type: string
    doc: default binner based on a variational autoencoder. See the paper 
      'Improved metagenome binning and assembly using deep variational 
      autoencoders'
    inputBinding:
      position: 1
  - id: binner_mode_description_avamb
    type:
      - 'null'
      - string
    doc: ==SUPPRESS==
    inputBinding:
      position: 2
  - id: binner_mode_description_default
    type:
      - 'null'
      - string
    doc: default binner based on a variational autoencoder. See the paper 
      'Improved metagenome binning and assembly using deep variational 
      autoencoders'
    inputBinding:
      position: 3
  - id: binner_mode_description_taxvamb
    type:
      - 'null'
      - string
    doc: "taxonomy informed binner based on a bi-modal variational autoencoder. See
      the paper 'TaxVAMB: taxonomic annotations improve metagenome binning'"
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
stdout: vamb_bin.out
