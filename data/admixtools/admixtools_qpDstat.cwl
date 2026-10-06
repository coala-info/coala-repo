cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpDstat
label: admixtools_qpDstat
doc: "Compute D-statistics for population genetics analysis\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: high_value
    type:
      - 'null'
      - float
    doc: use <val> as high value
    inputBinding:
      position: 102
      prefix: -H
  - id: low_value
    type:
      - 'null'
      - float
    doc: use <val> as low value
    inputBinding:
      position: 102
      prefix: -L
  - id: parameter_file
    type: File
    doc: use parameters from <file>
    inputBinding:
      position: 102
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: toggle verbose mode ON
    inputBinding:
      position: 102
      prefix: -V
  - id: data_files
    type:
      type: array
      items: File
    doc: Genotype, SNP, individual and population list files that the 
      parameter file names. They are staged into the working directory, so 
      the parameter file must refer to them by file name only.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpDstat.out
