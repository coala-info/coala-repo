cwlVersion: v1.2
class: CommandLineTool
baseCommand: splash_compactors
label: splash_compactors
doc: "The provided text does not contain help information or usage instructions for
  splash_compactors. It contains log messages from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/refresh-bio/splash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splash:2.11.0--py313h9ee0642_0
stdout: splash_compactors.out
