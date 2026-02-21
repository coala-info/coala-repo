cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamtocov_covtotarget
label: bamtocov_covtotarget
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/telatin/bamtocov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtocov:2.8.0--h1104d80_0
stdout: bamtocov_covtotarget.out
