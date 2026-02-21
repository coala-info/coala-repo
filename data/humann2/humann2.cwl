cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2
label: humann2
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or argument definitions for the humann2
  tool. The error indicates a failure to create a build directory due to 'no space
  left on device'.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
stdout: humann2.out
