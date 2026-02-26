cwlVersion: v1.2
class: CommandLineTool
baseCommand: lusstr snps
label: lusstr_snps
doc: "Running the SNP pipeline\n\nTool homepage: https://www.github.com/bioforensics/lusSTR"
inputs:
  - id: steps
    type: string
    doc: Steps to run. Specifying 'format' will run only 'format'. Specifying 
      'all' will run all steps of the SNP workflow ('format' and 'convert').
    inputBinding:
      position: 1
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: working directory
    inputBinding:
      position: 102
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
stdout: lusstr_snps.out
