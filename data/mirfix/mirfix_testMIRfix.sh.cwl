cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirfix_testMIRfix.sh
label: mirfix_testMIRfix.sh
doc: "Running MIRfix with 1 cores, 10nt extension\n\nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
  - id: extension
    type:
      - 'null'
      - int
    doc: extension length in nt
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
stdout: mirfix_testMIRfix.sh.out
