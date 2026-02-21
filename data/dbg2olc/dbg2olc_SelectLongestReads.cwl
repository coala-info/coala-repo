cwlVersion: v1.2
class: CommandLineTool
baseCommand: SelectLongestReads
label: dbg2olc_SelectLongestReads
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to pull or build a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/yechengxi/DBG2OLC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
stdout: dbg2olc_SelectLongestReads.out
