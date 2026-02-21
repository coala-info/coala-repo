cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromeister_allVsAll_incremental.sh
label: chromeister_allVsAll_incremental.sh
doc: "A script for all-vs-all incremental genome comparison using Chromeister. (Note:
  The provided help text contains only system error logs and does not list available
  arguments.)\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
stdout: chromeister_allVsAll_incremental.sh.out
