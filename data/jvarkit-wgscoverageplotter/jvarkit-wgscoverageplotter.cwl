cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit-wgscoverageplotter
label: jvarkit-wgscoverageplotter
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: http://lindenb.github.io/jvarkit/WGSCoveragePlotter.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-wgscoverageplotter:20201223--hdfd78af_3
stdout: jvarkit-wgscoverageplotter.out
