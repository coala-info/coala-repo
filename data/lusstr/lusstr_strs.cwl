cwlVersion: v1.2
class: CommandLineTool
baseCommand: lusstr_strs
label: lusstr_strs
doc: "Running the STR pipeline\n\nTool homepage: https://www.github.com/bioforensics/lusSTR"
inputs:
  - id: step
    type: string
    doc: Steps to run. Specifying 'format' will run only 'format'. Specifying 
      'convert' will run both 'format' and 'convert'. Specifying 'all' will run 
      all steps of the STR workflow ('format', 'convert' and 'filter').
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
stdout: lusstr_strs.out
