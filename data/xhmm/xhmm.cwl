cwlVersion: v1.2
class: CommandLineTool
baseCommand: xhmm
label: xhmm
doc: "The provided text does not contain help information for the xhmm tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the container image.\n\nTool homepage: http://atgu.mgh.harvard.edu/xhmm/index.shtml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--h1606924_0
stdout: xhmm.out
