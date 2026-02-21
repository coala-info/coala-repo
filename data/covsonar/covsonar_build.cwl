cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - covsonar
  - build
label: covsonar_build
doc: "The provided text appears to be a system log or error message from a container
  build process (Singularity/Apptainer) rather than the help text for the covsonar_build
  tool. As a result, no command-line arguments, flags, or positional parameters could
  be extracted.\n\nTool homepage: https://github.com/rki-mf1/covsonar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/covsonar:2.0.0a1--pyhdfd78af_0
stdout: covsonar_build.out
