cwlVersion: v1.2
class: CommandLineTool
baseCommand: opsin
label: opsin
doc: "Open Parser for Systematic IUPAC Nomenclature (OPSIN). A tool for converting
  chemical names into structure representations (such as SMILES, InChI, or CML).\n
  \nTool homepage: https://bitbucket.org/dan2097/opsin/"
inputs:
  - id: input
    type: string
    doc: Chemical name or input file containing chemical names to be parsed.
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file where the converted structures will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opsin:2.4.0--hdfd78af_3
