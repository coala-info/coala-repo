cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebaseextract
label: emboss-test_rebaseextract
doc: "Extract REBASE data for use by restriction enzyme tools (Note: The provided
  help text contains a system error and does not list specific arguments).\n\nTool
  homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-test:v6.6.0dfsg-7-deb_cv1
stdout: emboss-test_rebaseextract.out
