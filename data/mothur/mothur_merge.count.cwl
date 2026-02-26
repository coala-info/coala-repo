cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_merge.count
doc: "This tool appears to be a command-line interface for the mothur software, specifically
  designed to process a 'merge.count' batch file. The provided text indicates an error
  in opening this file, suggesting it's a core input for the operation.\n\nTool homepage:
  https://www.mothur.org"
inputs:
  - id: batch_file
    type: File
    doc: The batch file containing commands for mothur. In this case, it's 
      expected to be 'merge.count'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_merge.count.out
