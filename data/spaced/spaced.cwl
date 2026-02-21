cwlVersion: v1.2
class: CommandLineTool
baseCommand: spaced
label: spaced
doc: "A tool for alignment-free sequence comparison (Note: The provided text contains
  only execution logs and no help information; therefore, no arguments could be extracted).\n
  \nTool homepage: https://github.com/spacedriveapp/spacedrive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/spaced:v1.2.0-201605dfsg-1-deb_cv1
stdout: spaced.out
