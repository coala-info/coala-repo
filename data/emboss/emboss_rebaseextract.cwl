cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebaseextract
label: emboss_rebaseextract
doc: "Process REBASE files for use by restriction enzyme tools (Note: The provided
  help text contained only system error messages and no usage information. This entry
  is based on the tool name hint.)\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
stdout: emboss_rebaseextract.out
