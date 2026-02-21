cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-utils
  - build
label: pgscatalog-utils_build
doc: "The provided text appears to be a system log or error message from a container
  build process (Singularity/Apptainer) rather than the help text for the 'pgscatalog-utils
  build' command. As a result, no command-line arguments could be extracted.\n\nTool
  homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_build.out
