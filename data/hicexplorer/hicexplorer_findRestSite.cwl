cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicexplorer_findRestSite
label: hicexplorer_findRestSite
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failure due
  to lack of disk space.\n\nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer_findRestSite.out
