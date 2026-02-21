cwlVersion: v1.2
class: CommandLineTool
baseCommand: sumaclust
label: sumaclust
doc: "The provided text does not contain help information for sumaclust; it contains
  error logs from a container runtime (Apptainer/Singularity) failure.\n\nTool homepage:
  https://git.metabarcoding.org/obitools/sumaclust/wikis/home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sumaclust:v1.0.31-2-deb_cv1
stdout: sumaclust.out
