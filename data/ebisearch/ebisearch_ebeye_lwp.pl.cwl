cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebisearch_ebeye_lwp.pl
label: ebisearch_ebeye_lwp.pl
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_ebeye_lwp.pl.out
