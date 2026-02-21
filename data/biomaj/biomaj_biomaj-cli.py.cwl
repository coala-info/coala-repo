cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj-cli.py
label: biomaj_biomaj-cli.py
doc: "BioMAJ command line interface for bank management, updates, and maintenance.\n
  \nTool homepage: https://github.com/genouest/biomaj"
inputs:
  - id: bank
    type:
      - 'null'
      - string
    doc: Name of the bank to perform action on (can be comma separated for updates)
    inputBinding:
      position: 101
      prefix: --bank
  - id: change_dbname
    type:
      - 'null'
      - string
    doc: Change name of the bank to this new name
    inputBinding:
      position: 101
      prefix: --change-dbname
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check bank property file
    inputBinding:
      position: 101
      prefix: --check
  - id: config
    type:
      - 'null'
      - File
    doc: global.properties file path
    inputBinding:
      position: 101
      prefix: --config
  - id: force
    type:
      - 'null'
      - boolean
    doc: remove freezed releases
    inputBinding:
      position: 101
      prefix: --force
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: list of comma separated format
    inputBinding:
      position: 101
      prefix: --formats
  - id: freeze
    type:
      - 'null'
      - boolean
    doc: Freeze bank release (cannot be removed)
    inputBinding:
      position: 101
      prefix: --freeze
  - id: from_scratch
    type:
      - 'null'
      - boolean
    doc: force a new update cycle, even if release is identical, release will be incremented
    inputBinding:
      position: 101
      prefix: --from-scratch
  - id: from_task
    type:
      - 'null'
      - string
    doc: Force an re-update cycle skipping steps up to xx
    inputBinding:
      position: 101
      prefix: --from-task
  - id: log
    type:
      - 'null'
      - string
    doc: set log level in logs for this run (DEBUG|INFO|WARN|ERR), default is set
      in global.properties file
    inputBinding:
      position: 101
      prefix: --log
  - id: maintenance
    type:
      - 'null'
      - string
    doc: (un)set biomaj in maintenance mode (on/off/status)
    inputBinding:
      position: 101
      prefix: --maintenance
  - id: move_production_directories
    type:
      - 'null'
      - Directory
    doc: Change bank production directories location to this new path, path must exists
    inputBinding:
      position: 101
      prefix: --move-production-directories
  - id: owner
    type:
      - 'null'
      - string
    doc: Change owner of the bank (user id)
    inputBinding:
      position: 101
      prefix: --owner
  - id: process
    type:
      - 'null'
      - string
    doc: linked to from-task, optionally specify a block, meta or process name to
      start from
    inputBinding:
      position: 101
      prefix: --process
  - id: publish
    type:
      - 'null'
      - boolean
    doc: after update set as *current* version or Publish bank as current release
      to use
    inputBinding:
      position: 101
      prefix: --publish
  - id: query
    type:
      - 'null'
      - string
    doc: search in index (LUCENE query syntax)
    inputBinding:
      position: 101
      prefix: --query
  - id: release
    type:
      - 'null'
      - string
    doc: release of the bank to act upon (update, publish, remove, freeze, etc.)
    inputBinding:
      position: 101
      prefix: --release
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove bank release (files and database release)
    inputBinding:
      position: 101
      prefix: --remove
  - id: remove_all
    type:
      - 'null'
      - boolean
    doc: Remove all bank releases and database records
    inputBinding:
      position: 101
      prefix: --remove-all
  - id: remove_pending
    type:
      - 'null'
      - boolean
    doc: Remove pending releases
    inputBinding:
      position: 101
      prefix: --remove-pending
  - id: search
    type:
      - 'null'
      - boolean
    doc: basic search in bank production releases, return list of banks
    inputBinding:
      position: 101
      prefix: --search
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show bank files per format
    inputBinding:
      position: 101
      prefix: --show
  - id: status
    type:
      - 'null'
      - boolean
    doc: list of banks with published release
    inputBinding:
      position: 101
      prefix: --status
  - id: status_ko
    type:
      - 'null'
      - boolean
    doc: list of banks in error status (last run)
    inputBinding:
      position: 101
      prefix: --status-ko
  - id: stop_after
    type:
      - 'null'
      - string
    doc: stop update cycle after step xx has completed
    inputBinding:
      position: 101
      prefix: --stop-after
  - id: stop_before
    type:
      - 'null'
      - string
    doc: stop update cycle before the start of step xx
    inputBinding:
      position: 101
      prefix: --stop-before
  - id: types
    type:
      - 'null'
      - type: array
        items: string
    doc: list of comma separated type
    inputBinding:
      position: 101
      prefix: --types
  - id: unfreeze
    type:
      - 'null'
      - boolean
    doc: Unfreeze bank release (can be removed)
    inputBinding:
      position: 101
      prefix: --unfreeze
  - id: unpublish
    type:
      - 'null'
      - boolean
    doc: Unpublish bank (remove current)
    inputBinding:
      position: 101
      prefix: --unpublish
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update bank
    inputBinding:
      position: 101
      prefix: --update
  - id: visibility
    type:
      - 'null'
      - string
    doc: change visibility public/private of a bank
    inputBinding:
      position: 101
      prefix: --visibility
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biomaj:3.0.19--py35_0
stdout: biomaj_biomaj-cli.py.out
