cwlVersion: v1.2
class: CommandLineTool
baseCommand: geopandas
label: geopandas
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the geopandas container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/geopandas/geopandas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geopandas:1.1.2
stdout: geopandas.out
