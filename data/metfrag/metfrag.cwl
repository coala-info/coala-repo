cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - MetFragCL.jar
label: metfrag
doc: "MetFrag command line tool for metabolite identification using MS/MS data\n\n\
  Tool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs:
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: Path to the MetFrag parameter file
    inputBinding:
      position: 101
      prefix: ParameterFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metfrag:2.4.5--3
stdout: metfrag.out
