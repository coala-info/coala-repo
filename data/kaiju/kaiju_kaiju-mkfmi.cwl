cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-mkfmi
label: kaiju_kaiju-mkfmi
doc: "Calculate the FM index from the BWT and suffix array made by kaiju-mkbwt and write the kaiju database (.fmi) file. It looks for <name>.bwt and <name>.sa.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bwt_file)
        writable: true
      - entry: $(inputs.sa_file)
        writable: true
inputs:
  - id: bwt_file
    type: File
    doc: BWT file made by kaiju-mkbwt (<name>.bwt)
  - id: sa_file
    type: File
    doc: Suffix array file made by kaiju-mkbwt (<name>.sa); it must have the same base name as the BWT file
  - id: remove_command
    type:
      - 'null'
      - string
    doc: Command for deleting .bwt and .sa files (e.g. rm)
    inputBinding:
      position: 1
      prefix: -r
arguments:
  - position: 2
    valueFrom: $(inputs.bwt_file.nameroot)
outputs:
  - id: fmi_file
    type: File
    doc: Kaiju database file with the BWT, suffix array and FM index
    outputBinding:
      glob: $(inputs.bwt_file.nameroot).fmi
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-mkfmi.out
