cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_nbconvert
label: jupyter_nbconvert
doc: "This application is used to convert notebook files (*.ipynb) to various other\n\
  formats.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: notebooks
    type:
      - 'null'
      - type: array
        items: File
    doc: Notebook files to convert
    inputBinding:
      position: 1
  - id: allow_errors
    type:
      - 'null'
      - boolean
    doc: Continue notebook execution even if one of the cells throws an error 
      and include the error message in the cell output (the default behaviour is
      to abort conversion). This flag is only relevant if '--execute' was 
      specified, too.
    inputBinding:
      position: 102
      prefix: --allow-errors
  - id: config
    type:
      - 'null'
      - string
    doc: Full path of a config file.
    inputBinding:
      position: 102
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 102
      prefix: --debug
  - id: execute
    type:
      - 'null'
      - boolean
    doc: Execute the notebook prior to export.
    inputBinding:
      position: 102
      prefix: --execute
  - id: generate_config
    type:
      - 'null'
      - boolean
    doc: generate default config file
    inputBinding:
      position: 102
      prefix: --generate-config
  - id: inplace
    type:
      - 'null'
      - boolean
    doc: "Run nbconvert in place, overwriting the existing notebook (only \n    relevant
      when converting to notebook format)"
    inputBinding:
      position: 102
      prefix: --inplace
  - id: log_level
    type:
      - 'null'
      - int
    doc: Set the log level by value or name.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: nbformat
    type:
      - 'null'
      - int
    doc: The nbformat version to write. Use this to downgrade notebooks.
    inputBinding:
      position: 102
      prefix: --nbformat
  - id: output
    type:
      - 'null'
      - string
    doc: "overwrite base name use for output files. can only be used when converting\n\
      \    one notebook at a time."
    inputBinding:
      position: 102
      prefix: --output
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Directory to write output to.  Leave blank to output to the current\n  \
      \  directory"
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: post
    type:
      - 'null'
      - string
    doc: PostProcessor class used to write the results of the conversion
    inputBinding:
      position: 102
      prefix: --post
  - id: reveal_prefix
    type:
      - 'null'
      - string
    doc: "The URL prefix for reveal.js. This can be a a relative URL for a local copy\n\
      \    of reveal.js, or point to a CDN.\n    For speaker notes to work, a local
      reveal.js prefix must be used."
    inputBinding:
      position: 102
      prefix: --reveal-prefix
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: read a single notebook file from stdin. Write the resulting notebook 
      with default basename 'notebook.*'
    inputBinding:
      position: 102
      prefix: --stdin
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write notebook output to stdout instead of files.
    inputBinding:
      position: 102
      prefix: --stdout
  - id: template
    type:
      - 'null'
      - string
    doc: Name of the template file to use
    inputBinding:
      position: 102
      prefix: --template
  - id: to
    type:
      - 'null'
      - string
    doc: "The export format to be used, either one of the built-in formats, or a\n\
      \    dotted object name that represents the import path for an `Exporter` class"
    inputBinding:
      position: 102
      prefix: --to
  - id: writer
    type:
      - 'null'
      - string
    doc: Writer class used to write the  results of the conversion
    inputBinding:
      position: 102
      prefix: --writer
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any questions instead of prompting.
    inputBinding:
      position: 102
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_nbconvert.out
