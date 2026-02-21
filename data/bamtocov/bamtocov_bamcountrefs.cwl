cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtocov
  - bamcountrefs
label: bamtocov_bamcountrefs
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/telatin/bamtocov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtocov:2.8.0--h1104d80_0
stdout: bamtocov_bamcountrefs.out
