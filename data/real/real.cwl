cwlVersion: v1.2
class: CommandLineTool
baseCommand: real
label: real
doc: "The provided text appears to be a container build log showing a fatal error
  during the fetching of the OCI image for 'real', rather than the help text for the
  tool itself. As a result, no command-line arguments or descriptions could be extracted
  from this specific input.\n\nTool homepage: https://nms.kcl.ac.uk/informatics/projects/real/?id=man"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/real:1.0--he941832_1
stdout: real.out
