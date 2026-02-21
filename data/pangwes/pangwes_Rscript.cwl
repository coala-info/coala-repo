cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript
label: pangwes_Rscript
doc: "A binary front-end to R, for use in scripting applications.\n\nTool homepage:
  https://github.com/jurikuronen/PANGWES"
inputs:
  - id: script_file
    type:
      - 'null'
      - File
    doc: R script file to execute. Used if -e is not provided.
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments passed to the R script, accessible via commandArgs(TRUE).
    inputBinding:
      position: 2
  - id: default_packages
    type:
      - 'null'
      - string
    doc: Attach these packages on startup; a comma-separated LIST of package names,
      or 'NULL'
    inputBinding:
      position: 103
      prefix: --default-packages
  - id: expression
    type:
      - 'null'
      - type: array
        items: string
    doc: R expression(s) to execute. May be used instead of 'file'.
    inputBinding:
      position: 103
      prefix: -e
  - id: no_environ
    type:
      - 'null'
      - boolean
    doc: Don't read the site and user environment files
    inputBinding:
      position: 103
      prefix: --no-environ
  - id: no_init_file
    type:
      - 'null'
      - boolean
    doc: Don't read the user R profile
    inputBinding:
      position: 103
      prefix: --no-init-file
  - id: no_site_file
    type:
      - 'null'
      - boolean
    doc: Don't read the site-wide Rprofile
    inputBinding:
      position: 103
      prefix: --no-site-file
  - id: restore
    type:
      - 'null'
      - boolean
    doc: Do restore previously saved objects at startup
    inputBinding:
      position: 103
      prefix: --restore
  - id: save
    type:
      - 'null'
      - boolean
    doc: Do save workspace at the end of the session
    inputBinding:
      position: 103
      prefix: --save
  - id: vanilla
    type:
      - 'null'
      - boolean
    doc: Combine --no-save, --no-restore, --no-site-file, --no-init-file and --no-environ
    inputBinding:
      position: 103
      prefix: --vanilla
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information on progress
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
stdout: pangwes_Rscript.out
