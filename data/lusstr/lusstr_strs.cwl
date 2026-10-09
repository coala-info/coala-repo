cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lusstr
  - strs
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
    type: Directory
    doc: working directory that holds the config file (and the input files named
      in it). It is staged writable, and the results are written into it.
outputs:
  - id: output_directory
    type: Directory
    doc: The working directory with the results written by the tool
    outputBinding:
      glob: lusstr_wd
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 102
    prefix: --workdir
    valueFrom: lusstr_wd
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: lusstr_wd
        entry: $(inputs.working_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
stdout: lusstr_strs.out
