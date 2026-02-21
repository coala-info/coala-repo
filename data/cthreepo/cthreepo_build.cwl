cwlVersion: v1.2
class: CommandLineTool
baseCommand: cthreepo_build
label: cthreepo_build
doc: "The provided text appears to be a log of a failed container build process rather
  than a command-line help menu. No arguments or usage instructions were found in
  the text.\n\nTool homepage: https://github.com/vkkodali/cthreepo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cthreepo:0.1.3--pyh7cba7a3_0
stdout: cthreepo_build.out
