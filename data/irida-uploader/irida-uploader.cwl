cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-uploader
label: irida-uploader
doc: "This program parses sequencing runs and uploads them to IRIDA.\n\nTool homepage:
  https://github.com/phac-nml/irida-uploader"
inputs:
  - id: batch
    type:
      - 'null'
      - boolean
    doc: "Uploader will expect a directory containing a\n                        sequencing
      run directories, and upload in batch. The\n                        list of runs
      is generated at start time (Runs added to\n                        directory
      mid upload will not be uploaded)."
    inputBinding:
      position: 101
      prefix: --batch
  - id: config
    type:
      - 'null'
      - File
    doc: "Path to an alternative configuration file. This\n                      \
      \  overrides the default config file in the config\n                       \
      \ directory"
    inputBinding:
      position: 101
      prefix: --config
  - id: config_base_url
    type:
      - 'null'
      - string
    doc: "Override \"base_url\" in config file. The api url for\n                \
      \        your irida instance (example:\n                        https://my.irida.server/api/)"
    inputBinding:
      position: 101
      prefix: --config_base_url
  - id: config_client_id
    type:
      - 'null'
      - string
    doc: "Override the \"client_id\" field in config file. This is\n             \
      \           for the uploader client created in IRIDA, used to\n            \
      \            handle the data upload"
    inputBinding:
      position: 101
      prefix: --config_client_id
  - id: config_client_secret
    type:
      - 'null'
      - string
    doc: "Override \"client_secret\" in config file. This is for\n               \
      \         the uploader client created in IRIDA, used to handle\n           \
      \             the data upload"
    inputBinding:
      position: 101
      prefix: --config_client_secret
  - id: config_parser
    type:
      - 'null'
      - string
    doc: "Override \"parser\" in config file. Choose the type of\n               \
      \         sequencer data that is being uploaded. Supported\n               \
      \         parsers: ['miseq', 'miseq_v26', 'miseq_v31',\n                   \
      \     'miseq_win10_jun2021', 'miniseq', 'nextseq',\n                       \
      \ 'nextseq2k_nml', 'iseq', 'directory',\n                        'nanopore_assemblies',
      'seqfu']"
    inputBinding:
      position: 101
      prefix: --config_parser
  - id: config_password
    type:
      - 'null'
      - string
    doc: "Override \"password\" in config file. This corresponds\n               \
      \         to your IRIDA account."
    inputBinding:
      position: 101
      prefix: --config_password
  - id: config_timeout
    type:
      - 'null'
      - int
    doc: "Accepts an Integer for the expected transfer time in\n                 \
      \       seconds per MB. Default is 10 second for every MB of\n             \
      \           data to transfer (100kb/s). Increasing this number can\n       \
      \                 reduce timeout errors when your transfer speed is very\n \
      \                       slow."
    default: 10 second for every MB of data to transfer (100kb/s)
    inputBinding:
      position: 101
      prefix: --config_timeout
  - id: config_username
    type:
      - 'null'
      - string
    doc: "Override \"username\" in config file. This is your IRIDA\n             \
      \           account username."
    inputBinding:
      position: 101
      prefix: --config_username
  - id: continue_partial
    type:
      - 'null'
      - boolean
    doc: "Uploader will continue an existing upload run when\n                   \
      \     upload status is partial."
    inputBinding:
      position: 101
      prefix: --continue_partial
  - id: delay
    type:
      - 'null'
      - int
    doc: "Accepts an Integer for minutes to delay. When set, new\n               \
      \         runs will have their status set to delayed. When\n               \
      \         uploading a run with the delayed status, the run will\n          \
      \              only upload if the given amount of minutes has passes\n     \
      \                   since it was set to delayed. Default = 0: When set to\n\
      \                        0, runs will not be given delayed status."
    default: 0
    inputBinding:
      position: 101
      prefix: --delay
  - id: directory
    type: Directory
    doc: "Location of sequencing run to upload.\n                        Directory
      must be writable."
    inputBinding:
      position: 101
      prefix: --directory
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Uploader will ignore the status file, and try to\n                     \
      \   upload even when a run is in non new status."
    inputBinding:
      position: 101
      prefix: --force
  - id: minimum_file_size
    type:
      - 'null'
      - int
    doc: "Accepts an Integer for the minimum file size in KB.\n                  \
      \      Default is 0 KB. Files that are too small will appear\n             \
      \           as an error during run validation."
    default: 0
    inputBinding:
      position: 101
      prefix: --minimum_file_size
  - id: readonly
    type:
      - 'null'
      - boolean
    doc: "Upload in Read Only mode, does not write status or log\n               \
      \         file to run directory."
    inputBinding:
      position: 101
      prefix: --readonly
  - id: upload_mode
    type:
      - 'null'
      - string
    doc: "Choose which upload mode to use. Supported modes:\n                    \
      \    ['default', 'assemblies', 'fast5']"
    inputBinding:
      position: 101
      prefix: --upload_mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-uploader:0.9.5--pyhdfd78af_0
stdout: irida-uploader.out
