cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_survey
doc: 'Survey the degree of context information completeness for Poseidon packages


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: survey
inputs:
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'How information should be reported: NoLog, SimpleLog, DefaultLog, ServerLog
      or VerboseLog. (default: DefaultLog)'
    inputBinding:
      position: 1
      prefix: --logMode
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Short for --logMode VerboseLog.
    inputBinding:
      position: 2
      prefix: --debug
  - id: err_length
    type:
      - 'null'
      - string
    doc: 'After how many characters should a potential genotype data parsing error
      message be truncated. "Inf" for no truncation. (default: CharCount 1500)'
    inputBinding:
      position: 3
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to read the population/group name from the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 4
      prefix: --inPlinkPopName
  - id: base_dir
    type: Directory
    doc: A base directory to search for Poseidon packages.
    inputBinding:
      position: 100
      prefix: --baseDir
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Return the output table as tab-separated values without header.
    inputBinding:
      position: 100
      prefix: --raw
  - id: only_latest
    type:
      - 'null'
      - boolean
    doc: Consider only the latest versions of packages, or the groups and individuals
      within them.
    inputBinding:
      position: 100
      prefix: --onlyLatest
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stdout: poseidon-trident_survey.out
