cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-aggregate
label: pgscatalog-utils_pgscatalog-aggregate
doc: "The provided text is a system error log (Singularity/Apptainer build failure)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-aggregate.out
