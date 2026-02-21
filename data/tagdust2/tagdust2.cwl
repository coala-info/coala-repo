cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagdust
label: tagdust2
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a failed container build/execution attempt.\n\n
  Tool homepage: https://github.com/aradar46/tagdust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagdust2:2.33.1--h503566f_0
stdout: tagdust2.out
