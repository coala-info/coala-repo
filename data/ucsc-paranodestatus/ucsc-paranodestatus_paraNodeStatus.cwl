cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStatus
label: ucsc-paranodestatus_paraNodeStatus
doc: "Check status of paraNode on a list of machines.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: machine_list
    type: string
    doc: List of machines
    inputBinding:
      position: 1
  - id: long_list
    type:
      - 'null'
      - boolean
    doc: List details of current and recent jobs.
    inputBinding:
      position: 102
      prefix: -long
  - id: retries
    type:
      - 'null'
      - int
    doc: Number of retries to get in touch with machine. The first retry is 
      after 1/100th of a second. Each retry after that takes twice as long up to
      a maximum of 1 second per retry. Default is 7 retries and takes about a 
      second.
    default: 7
    inputBinding:
      position: 102
      prefix: -retries
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestatus:482--h0b57e2e_0
stdout: ucsc-paranodestatus_paraNodeStatus.out
