cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakesee profile-show
label: snakesee_profile-show
doc: "Display contents of a timing profile.\n\nTool homepage: https://github.com/nh13/snakesee"
inputs:
  - id: profile_path
    type: File
    doc: Path to the profile file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
stdout: snakesee_profile-show.out
