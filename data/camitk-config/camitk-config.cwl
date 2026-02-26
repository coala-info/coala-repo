cwlVersion: v1.2
class: CommandLineTool
baseCommand: camitk-config
label: camitk-config
doc: Build using CamiTK 4.1.2
inputs:
  - id: bug_report_info
    type:
      - 'null'
      - boolean
    doc: Generate a report bug template with the CamiTK diagnosis in it
    inputBinding:
      position: 101
      prefix: --bug-report-info
  - id: camitk_dir
    type:
      - 'null'
      - boolean
    doc: Print CAMITK_DIR (the installation directory) and exit
    inputBinding:
      position: 101
      prefix: --camitk-dir
  - id: complete_version
    type:
      - 'null'
      - boolean
    doc: Print CamiTK complete version number (including patch number)
    inputBinding:
      position: 101
      prefix: --complete-version
  - id: config
    type:
      - 'null'
      - boolean
    doc: Print all information for a complete CamiTK diagnosis and exit
    inputBinding:
      position: 101
      prefix: --config
  - id: print_paths
    type:
      - 'null'
      - boolean
    doc: Print CamiTK paths on the standard output and exit
    inputBinding:
      position: 101
      prefix: --print-paths
  - id: short_version
    type:
      - 'null'
      - boolean
    doc: Print CamiTK short version string
    inputBinding:
      position: 101
      prefix: --short-version
  - id: time_stamp
    type:
      - 'null'
      - boolean
    doc: Generate a time stamp in format YYYY-MM-DDTHH:mm:ss from current system
      date and time
    inputBinding:
      position: 101
      prefix: --time-stamp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/camitk-config:v4.1.2-3-deb_cv1
stdout: camitk-config.out
