cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/FASTSTEP3R
label: genera_FASTSTEP3R
doc: "FASTSTEP3R tool for processing gene lists and diamond output.\n\nTool homepage:
  https://github.com/josuebarrera/GenEra"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --cores
  - id: genelist
    type:
      - 'null'
      - File
    doc: Name of input tmp_genelist
    inputBinding:
      position: 101
      prefix: --genelist
  - id: pattern
    type:
      - 'null'
      - string
    doc: Default pattern used to search ${DIAMONDOUT} splitted files in tmp 
      directory
    inputBinding:
      position: 101
      prefix: --pattern
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: ${TMP_PATH} directory to import and export results
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
stdout: genera_FASTSTEP3R.out
