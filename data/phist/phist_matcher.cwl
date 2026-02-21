cwlVersion: v1.2
class: CommandLineTool
baseCommand: phist_matcher
label: phist_matcher
doc: "PHage-host Interaction Search Tool (Note: The provided text contains container
  build logs and error messages rather than the tool's help documentation).\n\nTool
  homepage: https://github.com/refresh-bio/PHIST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phist:1.0.0--py311h2de2dd3_1
stdout: phist_matcher.out
