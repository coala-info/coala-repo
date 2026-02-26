cwlVersion: v1.2
class: CommandLineTool
baseCommand: geno2phenotb test
label: geno2phenotb_test
doc: "Test the installation of geno2phenoTB.\n\nTool homepage: https://github.com/msmdev/geno2phenoTB"
inputs:
  - id: complete
    type:
      - 'null'
      - boolean
    doc: Complete test of installation. This will download ~ 170mb from the ENA 
      and start a complete run. Depending on your bandwith / hardware this may 
      take a few (5-30) minutes.
    inputBinding:
      position: 101
      prefix: --complete
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast test of installation. This will not test the preprocessing / 
      MTBSeq steps.
    inputBinding:
      position: 101
      prefix: --fast
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geno2phenotb:1.0.1--pyhdfd78af_1
stdout: geno2phenotb_test.out
