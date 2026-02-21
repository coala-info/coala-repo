cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-match
  - intersect
label: pgscatalog.match_pgscatalog-intersect
doc: "The provided text does not contain help information or argument definitions.
  It appears to be an error log from a container build process (Singularity/Apptainer)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
stdout: pgscatalog.match_pgscatalog-intersect.out
