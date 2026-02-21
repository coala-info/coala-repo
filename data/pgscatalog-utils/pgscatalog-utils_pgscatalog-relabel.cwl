cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-utils
  - relabel
label: pgscatalog-utils_pgscatalog-relabel
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to extract the tool's image due to insufficient disk space.
  It does not contain the help text or argument definitions for the tool.\n\nTool
  homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-relabel.out
