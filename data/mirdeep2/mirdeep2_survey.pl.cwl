cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - survey.pl
label: mirdeep2_survey.pl
doc: "Survey the prediction accuracy of miRDeep2 for all score cut-offs between -10 and 10\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: mrd_file
    type: File
    doc: Result of the miRDeep2 core algorithm in mrd format (output.mrd of a miRDeep2 run)
    inputBinding:
      position: 1
  - id: controls_file
    type:
      - 'null'
      - File
    doc: File produced by perform_controls.pl (permuted run output)
    inputBinding:
      position: 101
      prefix: -a
  - id: mature_ref
    type:
      - 'null'
      - File
    doc: Mature miRNA fasta reference file of the species; must be used together with the signature file
    inputBinding:
      position: 101
      prefix: -b
  - id: signature_file
    type:
      - 'null'
      - File
    doc: Signature file; must be used together with the mature miRNA reference file
    inputBinding:
      position: 101
      prefix: -c
  - id: stack_height
    type:
      - 'null'
      - int
    doc: Read stack height necessary for triggering excision
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Survey table (csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: survey.csv
