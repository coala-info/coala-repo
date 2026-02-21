cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-info
label: genomedata_genomedata-info
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build or pull the container image due to insufficient disk space ('no
  space left on device').\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-info.out
