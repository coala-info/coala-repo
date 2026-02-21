cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cascade-config
  - build
label: cascade-config_build
doc: "The provided text appears to be a log of a failed container build process rather
  than a help menu. No command-line arguments or usage instructions were found in
  the text.\n\nTool homepage: https://github.com/RalfG/cascade-config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cascade-config:0.4.0--pyhdfd78af_0
stdout: cascade-config_build.out
