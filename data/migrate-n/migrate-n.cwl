cwlVersion: v1.2
class: CommandLineTool
baseCommand: migrate-n
label: migrate-n
doc: "Migrate-n estimates population sizes and migration rates (and other population parameters) from\
  \ genetic data using maximum likelihood or Bayesian inference with coalescent MCMC.\n\nTool homepage:\
  \ http://popgen.sc.fsu.edu/Migrate/Migrate-n.html"
inputs:
  - id: nomenu
    type:
      - 'null'
      - boolean
    doc: Does not display menu, use this for batch jobs.
    inputBinding:
      position: 101
      prefix: -nomenu
  - id: menu
    type:
      - 'null'
      - boolean
    doc: Forces the display of the menu.
    inputBinding:
      position: 101
      prefix: -menu
  - id: parmfile
    type:
      - 'null'
      - File
    doc: Migrate-n parameter file (parmfile) that names the input data file and all run options.
    inputBinding:
      position: 1
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the parmfile (infile, usertree, geofile, ...); they are staged in the working
      directory so the relative names resolve.
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: Result files written to the working directory (outfile, PDF, summary, Bayesian and histogram
      files).
    outputBinding:
      glob:
        - outfile*
        - sumfile*
        - mathfile*
        - bayesfile*
        - bayesallfile*
        - mighistfile*
        - skylinefile*
        - treefile*
        - logfile*
  - id: stdout_log
    type: stdout
    doc: Progress messages (standard output).
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.data_files ? inputs.data_files : [])'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migrate-n:3.6.11--haf0c795_7
stdout: migrate-n.out
