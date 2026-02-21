cwlVersion: v1.2
class: CommandLineTool
baseCommand: intersectBed
label: pybedtools_intersectBed
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log (Apptainer/Singularity) indicating a failure
  to fetch or build the OCI image for pybedtools.\n\nTool homepage: https://github.com/daler/pybedtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybedtools:0.12.0--py310h275bdba_0
stdout: pybedtools_intersectBed.out
