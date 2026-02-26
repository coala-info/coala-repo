cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bohra
  - test
label: bohra_test
doc: "Check that bohra is installed correctly and runs as expected.\n\nTool homepage:
  https://github.com/kristyhoran/bohra"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use for testing Bohra installation.
    inputBinding:
      position: 101
      prefix: --cpus
  - id: shovill_ram
    type:
      - 'null'
      - int
    doc: Amount of RAM to allocate to shovill assembler.
    inputBinding:
      position: 101
      prefix: --shovill_ram
  - id: wdir
    type:
      - 'null'
      - Directory
    doc: Working directory for the test run.
    default: current working directory
    inputBinding:
      position: 101
      prefix: --wdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
stdout: bohra_test.out
