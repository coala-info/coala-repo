cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebaseextract
label: emboss-explorer_rebaseextract
doc: "Process REBASE files for use by restriction enzyme tools. (Note: The provided
  help text contains a system error and does not list specific arguments.)\n\nTool
  homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_rebaseextract.out
