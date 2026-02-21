cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sizemeup
  - build
label: sizemeup_sizemeup-build
doc: "The provided text appears to be a log of a failed container build process rather
  than help documentation. No command-line arguments or usage instructions were found
  in the text.\n\nTool homepage: https://github.com/rpetit3/sizemeup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sizemeup:1.3.0--pyhdfd78af_0
stdout: sizemeup_sizemeup-build.out
