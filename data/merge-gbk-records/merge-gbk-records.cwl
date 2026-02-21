cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge-gbk-records
label: merge-gbk-records
doc: "A tool to merge GenBank (GBK) records.\n\nTool homepage: http://github.com/kblin/merge-gbk-records"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merge-gbk-records:0.2.0--pyhdfd78af_0
stdout: merge-gbk-records.out
