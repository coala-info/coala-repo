cwlVersion: v1.2
class: CommandLineTool
baseCommand: garli
label: garli
doc: "GARLI (Genetic Algorithm for Rapid Likelihood Inference) is a program for phylogenetic
  inference using maximum likelihood.\n\nTool homepage: https://github.com/guillaumepotier/Garlic.js"
inputs:
  - id: config_filename
    type:
      - 'null'
      - File
    doc: Configuration filename. If not provided, 'garli.conf' will be looked 
      for in the current directory.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - boolean
    doc: batch mode (do not expect user input)
    inputBinding:
      position: 102
      prefix: --batch
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: interactive mode (allow and/or expect user feedback)
    inputBinding:
      position: 102
      prefix: --interactive
  - id: run_internal_tests
    type:
      - 'null'
      - boolean
    doc: run internal tests (requires dataset and config file)
    inputBinding:
      position: 102
      prefix: -t
  - id: validate
    type:
      - 'null'
      - boolean
    doc: load config file and data, validate config file, data, starting trees 
      and constraint files, print required memory and selected model, then exit
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/garli:v2.1-3-deb_cv1
stdout: garli.out
