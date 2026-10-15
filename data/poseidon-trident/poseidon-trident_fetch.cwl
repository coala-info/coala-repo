cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_fetch
doc: 'Download data from a remote Poseidon repository


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: fetch
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
    doc: A base directory to search for Poseidon packages. The downloaded packages
      are written into it, so it is staged writable.
    inputBinding:
      position: 100
      prefix: --baseDir
      valueFrom: $(self.basename)
  - id: download_all
    type:
      - 'null'
      - boolean
    doc: Download all packages the server is offering.
    inputBinding:
      position: 100
      prefix: --downloadAll
  - id: fetch_file
    type:
      - 'null'
      - File
    doc: A file with a list of packages. Works as --fetchString, but multiple values
      can also be separated by newline.
    inputBinding:
      position: 100
      prefix: --fetchFile
  - id: fetch_string
    type:
      - 'null'
      - string
    doc: List of packages to be downloaded from the remote server, in the form "*package_1*,
      *package_2*". Groups or individuals select the packages that include them.
    inputBinding:
      position: 100
      prefix: --fetchString
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
    doc: The name of the Poseidon package archive that should be queried. If not given,
      the default archive of the server is used.
    inputBinding:
      position: 100
      prefix: --archive
outputs:
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: base_dir_out
    type: Directory
    doc: The base directory with the downloaded packages.
    outputBinding:
      glob: $(inputs.base_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.base_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stderr: poseidon-trident_fetch.err
