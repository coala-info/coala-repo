cwlVersion: v1.2
class: CommandLineTool
baseCommand: aghermann
label: aghermann
doc: "Aghermann: A sleep-research experiment manager\n\nTool homepage: https://github.com/BackupTheBerlios/aghermann"
inputs:
  - id: exp_root_dir
    type:
      - 'null'
      - Directory
    doc: Experiment root directory
    inputBinding:
      position: 1
  - id: no_gui
    type:
      - 'null'
      - boolean
    doc: Run without GUI (implied by common CLI patterns for -n in this context)
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to the log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aghermann:v1.1.2-2-deb_cv1
