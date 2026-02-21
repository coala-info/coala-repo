cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merquryfk
  - KatComp
label: merquryfk_KatComp
doc: "A tool within the MerquryFK suite (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_KatComp.out
