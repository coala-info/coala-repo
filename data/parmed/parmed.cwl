cwlVersion: v1.2
class: CommandLineTool
baseCommand: parmed
label: parmed
doc: "ParmEd is a package designed to facilitate aiding investigations of biomolecular
  systems by providing a unified interface to many common topology and coordinate
  file formats.\n\nTool homepage: https://github.com/ParmEd/ParmEd"
inputs:
  - id: prmtop_positional
    type:
      - 'null'
      - File
    doc: Topology file to analyze.
    inputBinding:
      position: 1
  - id: script_positional
    type:
      - 'null'
      - File
    doc: File with a series of ParmEd commands to execute.
    inputBinding:
      position: 2
  - id: enable_interpreter
    type:
      - 'null'
      - boolean
    doc: Allow arbitrary single Python commands or blocks of Python code to be run.
    inputBinding:
      position: 103
      prefix: --enable-interpreter
  - id: inpcrd
    type:
      - 'null'
      - type: array
        items: File
    doc: List of inpcrd files to load into ParmEd. They are paired with the topology
      files in the same order that each set of files is specified on the command-line.
    inputBinding:
      position: 103
      prefix: --inpcrd
  - id: input_script
    type:
      - 'null'
      - type: array
        items: File
    doc: Script with ParmEd commands to execute. Default reads from stdin. Can be
      specified multiple times to process multiple input files.
    inputBinding:
      position: 103
      prefix: --input
  - id: no_splash
    type:
      - 'null'
      - boolean
    doc: Prevent printing the greeting logo.
    inputBinding:
      position: 103
      prefix: --no-splash
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow ParmEd to overwrite existing files.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: parm
    type:
      - 'null'
      - type: array
        items: File
    doc: List of topology files to load into ParmEd. Can be specified multiple times
      to process multiple topologies.
    inputBinding:
      position: 103
      prefix: --parm
  - id: prompt
    type:
      - 'null'
      - string
    doc: String to use as a command prompt.
    inputBinding:
      position: 103
      prefix: --prompt
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: Scripts ignore unrecognized input and simply skip over failed actions, executing
      the rest of the script.
    inputBinding:
      position: 103
      prefix: --relaxed
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Prevent scripts from running past unrecognized input and actions that end
      with an error. This is the default behavior.
    inputBinding:
      position: 103
      prefix: --strict
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: Log file with every command executed during an interactive ParmEd session.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parmed:3.4.3
