cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsfilter
label: obitools_ngsfilter
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failure.\n
  \nTool homepage: http://metabarcoding.org/obitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_ngsfilter.out
