cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStop
label: ucsc-paranodestop_paraNodeStop
doc: "Shut down parasol node daemons on a list of machines.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: machine_list
    type: string
    doc: List of machines
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestop:482--h0b57e2e_0
stdout: ucsc-paranodestop_paraNodeStop.out
