cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_trident
doc: "trident is a management and analysis tool for Poseidon packages. Report issues\n\
  here: https://github.com/poseidon-framework/poseidon-hs/issues\n\nTool homepage:
  https://poseidon-framework.github.io/#/"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Short for --logMode VerboseLog.
    inputBinding:
      position: 102
      prefix: --debug
  - id: err_length
    type:
      - 'null'
      - string
    doc: "After how many characters should a potential genotype\ndata parsing error
      message be truncated. \"Inf\" for no\ntruncation."
    default: CharCount 1500
    inputBinding:
      position: 102
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: "Where to read the population/group name from the FAM\nfile in Plink-format.
      Three options are possible:\nasFamily (default) | asPhenotype | asBoth."
    default: asFamily
    inputBinding:
      position: 102
      prefix: --inPlinkPopName
  - id: log_mode
    type:
      - 'null'
      - string
    doc: "How information should be reported: NoLog, SimpleLog,\nDefaultLog, ServerLog
      or VerboseLog."
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
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stdout: poseidon-trident_trident.out
