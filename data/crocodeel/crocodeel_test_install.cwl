cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crocodeel
  - test_install
label: crocodeel_test_install
doc: "Test the installation of crocodeel\n\nTool homepage: https://github.com/metagenopolis/crocodeel"
inputs:
  - id: keep_results
    type:
      - 'null'
      - boolean
    doc: Keep all temporary results files.
    inputBinding:
      position: 101
      prefix: --keep-results
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
stdout: crocodeel_test_install.out
