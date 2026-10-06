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
    doc: Experiment root directory (Group/Subject/Session/Episode.edf tree). 
      It is staged writable because Aghermann saves settings and computed 
      profiles inside it.
    inputBinding:
      position: 1
  - id: no_gui
    type:
      - 'null'
      - boolean
    doc: Initialise the experiment session in exp_root_dir and exit at once; 
      no windows are opened. Needs exp_root_dir.
    inputBinding:
      position: 102
      prefix: -n
  - id: log_file_path
    type: string
    doc: Write a log of Aghermann's inner workings to this file.
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to the log file
    outputBinding:
      glob: $(inputs.log_file_path)
  - id: exp_root_dir_out
    type:
      - 'null'
      - Directory
    doc: The experiment root directory with the settings and profiles Aghermann
      saved in it.
    outputBinding:
      glob: '$(inputs.exp_root_dir ? inputs.exp_root_dir.basename : "_no_exp_root_dir_")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.exp_root_dir ? [{"entry": inputs.exp_root_dir, "writable":
      true}] : []; }'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aghermann:v1.1.2-2-deb_cv1
