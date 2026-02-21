cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs.plot.r
label: ngsplotdb-ngsplotdb-hg19_ngs.plot.r
doc: "The provided text does not contain help information, but appears to be a system
  error log from a container runtime (Apptainer/Singularity) indicating a 'no space
  left on device' failure during image conversion. No arguments could be extracted.\n
  \nTool homepage: https://github.com/shenlab-sinai/ngsplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
stdout: ngsplotdb-ngsplotdb-hg19_ngs.plot.r.out
