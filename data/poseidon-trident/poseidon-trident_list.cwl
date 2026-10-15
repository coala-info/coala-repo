cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_list
doc: 'List packages, groups or individuals from local or remote Poseidon repositories


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: list
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
    type:
      - 'null'
      - Directory
    doc: A base directory to search for Poseidon packages.
    inputBinding:
      position: 100
      prefix: --baseDir
  - id: remote
    type:
      - 'null'
      - boolean
    doc: List packages from a remote server instead of the local file system.
    inputBinding:
      position: 100
      prefix: --remote
  - id: remote_url
    type:
      - 'null'
      - string
    doc: 'URL of the remote Poseidon server. (default: "https://server.poseidon-adna.org")'
    inputBinding:
      position: 100
      prefix: --remoteURL
  - id: archive
    type:
      - 'null'
      - string
    doc: The name of the Poseidon package archive that should be queried.
    inputBinding:
      position: 100
      prefix: --archive
  - id: packages
    type:
      - 'null'
      - boolean
    doc: List all packages.
    inputBinding:
      position: 100
      prefix: --packages
  - id: full_output
    type:
      - 'null'
      - boolean
    doc: Extend the package output to include information in the POSEIDON.yml file.
    inputBinding:
      position: 100
      prefix: --fullOutput
  - id: groups
    type:
      - 'null'
      - boolean
    doc: List all groups, ignoring any group names after the first in the .janno file.
    inputBinding:
      position: 100
      prefix: --groups
  - id: individuals
    type:
      - 'null'
      - boolean
    doc: List all individuals/samples.
    inputBinding:
      position: 100
      prefix: --individuals
  - id: full_janno
    type:
      - 'null'
      - boolean
    doc: Output all .janno columns.
    inputBinding:
      position: 100
      prefix: --fullJanno
  - id: janno_column
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --jannoColumn
    doc: List additional fields from the .janno files by column heading, such as "Country"
      or "Site". Can be given multiple times.
    inputBinding:
      position: 100
  - id: bibliography
    type:
      - 'null'
      - boolean
    doc: Output bibliography information for packages.
    inputBinding:
      position: 100
      prefix: --bibliography
  - id: full_bib
    type:
      - 'null'
      - boolean
    doc: Output all bibliography fields found in any bibliography item.
    inputBinding:
      position: 100
      prefix: --fullBib
  - id: bib_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --bibField
    doc: List information from the given bibliography field, such as "abstract" or
      "publisher". Can be given multiple times.
    inputBinding:
      position: 100
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
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stdout: poseidon-trident_list.out
