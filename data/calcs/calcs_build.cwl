cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calcs
  - build
label: calcs_build
doc: "The provided text appears to be a log of a failed container build process rather
  than a help menu. No command-line arguments, flags, or tool descriptions were found
  in the input.\n\nTool homepage: https://github.com/akikuno/calcs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calcs:0.0.0.9999--pyh5e36f6f_0
stdout: calcs_build.out
