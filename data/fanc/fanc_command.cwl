cwlVersion: v1.2
class: CommandLineTool
baseCommand: fanc
label: fanc_command
doc: "fanc processing tool for Hi-C data\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: command
    type: string
    doc: Subcommand to run (e.g., auto, map, pairs, hic, cis-trans, expected, 
      pca, compartments, insulation, directionality, boundaries, compare, loops,
      aggregate, fragments, sort-sam, from-juicer, from-txt, to-cooler, 
      to-juicer, dump, overlap-peaks, subset, stats, write-config, downsample, 
      upgrade)
    inputBinding:
      position: 1
  - id: email
    type:
      - 'null'
      - string
    doc: Email address for fanc command summary.
    inputBinding:
      position: 102
      prefix: --email
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print log messages to command line.
    inputBinding:
      position: 102
      prefix: --silent
  - id: smtp_password
    type:
      - 'null'
      - string
    doc: SMTP password.
    inputBinding:
      position: 102
      prefix: --smtp-password
  - id: smtp_sender_address
    type:
      - 'null'
      - string
    doc: SMTP sender email address.
    inputBinding:
      position: 102
      prefix: --smtp-sender-address
  - id: smtp_server
    type:
      - 'null'
      - string
    doc: SMTP server in the form smtp.server.com[:port].
    inputBinding:
      position: 102
      prefix: --smtp-server
  - id: smtp_username
    type:
      - 'null'
      - string
    doc: SMTP username.
    inputBinding:
      position: 102
      prefix: --smtp-username
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: 'Set verbosity level: Can be chained like "-vvv" to increase verbosity. Default
      is to show errors, warnings, and info messages (same as "-vv"). "-v" shows only
      errors and warnings, "-vvv" shows errors, warnings, info, and debug messages.'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to file in which to save log.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
