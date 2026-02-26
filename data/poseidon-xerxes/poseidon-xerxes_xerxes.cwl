cwlVersion: v1.2
class: CommandLineTool
baseCommand: xerxes
label: poseidon-xerxes_xerxes
doc: "xerxes is an analysis tool for Poseidon packages. Report issues here:\n  https://github.com/poseidon-framework/poseidon-analysis-hs/issues\n\
  \nTool homepage: https://poseidon-framework.github.io/#/"
inputs:
  - id: command
    type: string
    doc: Analysis command or artificial genotype generator
    inputBinding:
      position: 1
  - id: err_length
    type:
      - 'null'
      - string
    doc: "After how many characters should a potential error\n                   \
      \        message be truncated. \"Inf\" for no truncation."
    default: CharCount 1500
    inputBinding:
      position: 102
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: "Where to read the population/group name from the FAM\n                 \
      \          file in Plink-format. Three options are possible:\n             \
      \              asFamily (default) | asPhenotype | asBoth."
    default: asFamily
    inputBinding:
      position: 102
      prefix: --inPlinkPopName
  - id: log_mode
    type:
      - 'null'
      - string
    doc: "How information should be reported: NoLog, SimpleLog,\n                \
      \           DefaultLog, ServerLog or VerboseLog."
    default: DefaultLog
    inputBinding:
      position: 102
      prefix: --logMode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
stdout: poseidon-xerxes_xerxes.out
