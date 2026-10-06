cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - pubmlstspecies
label: ariba_pubmlstspecies
doc: "Get a list of species available from PubMLST. Use this to show the possible species that can be used when running pubmlstget\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: List of PubMLST species
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
stdout: ariba_pubmlstspecies.out
