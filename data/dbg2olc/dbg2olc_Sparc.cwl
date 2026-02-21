cwlVersion: v1.2
class: CommandLineTool
baseCommand: Sparc
label: dbg2olc_Sparc
doc: "Sparc is a consensus tool used in the DBG2OLC assembly pipeline. Note: The provided
  help text contains only system error messages and no usage information.\n\nTool
  homepage: https://github.com/yechengxi/DBG2OLC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
stdout: dbg2olc_Sparc.out
