cwlVersion: v1.2
class: CommandLineTool
baseCommand: hla-la_HLA-LA.pl
label: hla-la_HLA-LA.pl
doc: "Please specify a working directory via --workingDir.\n\nOutput for sample with
  ID $sampleID will go a correspondingly named sub-directory of the working directory.\n\
  \nFor example, if --workingDir is /path/working, and --sampleID is mySample, then
  the output will go into directory /path/working/mySample.\n\nTool homepage: https://github.com/DiltheyLab/HLA-LA"
inputs:
  - id: sample_id
    type:
      - 'null'
      - string
    doc: sample ID
    inputBinding:
      position: 101
      prefix: --sampleID
  - id: working_dir
    type: Directory
    doc: working directory
    inputBinding:
      position: 101
      prefix: --workingDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-la:1.0.4--h077b44d_1
stdout: hla-la_HLA-LA.pl.out
