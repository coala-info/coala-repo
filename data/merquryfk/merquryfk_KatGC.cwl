cwlVersion: v1.2
class: CommandLineTool
baseCommand: KatGC
label: merquryfk_KatGC
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a container image due to insufficient disk space.
  No arguments could be extracted.\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_KatGC.out
