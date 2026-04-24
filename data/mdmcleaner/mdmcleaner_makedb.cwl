cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - makedb
label: mdmcleaner_makedb
doc: "Builds the reference database for MDMcleaner.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: "provide a local config file with the target location to store database-files.
      directory. settings in the local config file will override settings in the global
      config file '/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config'"
    inputBinding:
      position: 101
      prefix: --config
  - id: get_pub_data
    type:
      - 'null'
      - boolean
    doc: 'simply download the reference dataset from the MDMcleaner publication from
      zenodo (WARNING: this is outdated and therefore NOT optimal! Only meant for
      testing/verification purposes)'
    inputBinding:
      position: 101
      prefix: --get_pub_data
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: target base directory for reference-data. may not be the current 
      working directory. Needs >100GB space!
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet mode (suppress any status messages except Errors and Warnings)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output (download progress etc)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner_makedb.out
