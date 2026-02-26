cwlVersion: v1.2
class: CommandLineTool
baseCommand: sidr_runfile
label: sidr_runfile
doc: "Runs a custom analysis using pre-computed data from BBMap or other\nsources.\n\
  \nInput data will be read for all variables which will be used to construct\na Decision
  Tree model.\n\nTool homepage: https://github.com/damurdock/SIDR"
inputs:
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Use binary target/nontarget classification.
    inputBinding:
      position: 101
      prefix: --binary
  - id: infile
    type: File
    doc: Comma-delimited input file.
    inputBinding:
      position: 101
      prefix: --infile
  - id: level
    type:
      - 'null'
      - string
    doc: "The classification level to use when constructing the\nmodel."
    default: phylum
    inputBinding:
      position: 101
      prefix: --level
  - id: target
    type:
      - 'null'
      - string
    doc: "The identity of the target organism at the chosen\nclassification level.
      It is recommended to use the\norganism's phylum."
    inputBinding:
      position: 101
      prefix: --target
  - id: taxdump
    type:
      - 'null'
      - Directory
    doc: Location of the NCBI Taxonomy dump.
    default: $BLASTDB
    inputBinding:
      position: 101
      prefix: --taxdump
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output)
  - id: tokeep
    type:
      - 'null'
      - File
    doc: "Location to save the contigs identified as the target\norganism(optional)."
    outputBinding:
      glob: $(inputs.tokeep)
  - id: toremove
    type:
      - 'null'
      - File
    doc: "Location to save the contigs identified as not\nbelonging to the target
      organism (optional)."
    outputBinding:
      glob: $(inputs.toremove)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sidr:0.0.2a2--pyh3252c3a_0
