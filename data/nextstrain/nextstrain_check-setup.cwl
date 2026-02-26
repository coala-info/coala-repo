cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain check-setup
label: nextstrain_check-setup
doc: "Checks your local setup to see if you have a supported build environment.\n\n\
  Tool homepage: https://nextstrain.org"
inputs:
  - id: set_default
    type:
      - 'null'
      - boolean
    doc: 'Set the default environment to the first which passes check-setup. Checks
      run in the order: docker, native, aws-batch.'
    default: false
    inputBinding:
      position: 101
      prefix: --set-default
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
stdout: nextstrain_check-setup.out
