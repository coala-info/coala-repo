cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - rsync-cluster
label: toil_rsync-cluster
doc: "Rsync files to or from a Toil cluster leader node.\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: cluster_name
    type: string
    doc: The name that the cluster will be identifiable by. Must be lowercase 
      and may not contain the '_' character.
    inputBinding:
      position: 1
  - id: args
    type:
      type: array
      items: string
    doc: Arguments to pass to `rsync`. Takes any arguments that rsync accepts. 
      Specify the remote with a colon.
    inputBinding:
      position: 2
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: Temporarily disable strict host key checking.
    default: false
    inputBinding:
      position: 103
      prefix: --insecure
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    default: true
    inputBinding:
      position: 103
      prefix: --logColors
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Critical.
    inputBinding:
      position: 103
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Debug.
    inputBinding:
      position: 103
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Error.
    inputBinding:
      position: 103
      prefix: --logError
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    inputBinding:
      position: 103
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Info.
    inputBinding:
      position: 103
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level.
    default: INFO
    inputBinding:
      position: 103
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Same as --logCRITICAL.
    inputBinding:
      position: 103
      prefix: --logOff
  - id: log_warning
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Warning.
    inputBinding:
      position: 103
      prefix: --logWarning
  - id: provisioner
    type:
      - 'null'
      - string
    doc: "The provisioner for cluster auto-scaling. Choices: ['aws', 'gce']."
    inputBinding:
      position: 103
      prefix: --provisioner
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    default: false
    inputBinding:
      position: 103
      prefix: --rotatingLogging
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created.
    default: /tmp
    inputBinding:
      position: 103
      prefix: --tempDirRoot
  - id: zone
    type:
      - 'null'
      - string
    doc: The availability zone of the leader.
    inputBinding:
      position: 103
      prefix: --zone
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil_rsync-cluster.out
