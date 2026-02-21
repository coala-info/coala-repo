cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-data
label: ncbi-data
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool 'ncbi-data'.\n
  \nTool homepage: https://github.com/NAalytics/Assemblies-of-putative-SARS-CoV2-spike-encoding-mRNA-sequences-for-vaccines-BNT-162b2-and-mRNA-1273"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-data:v6.1.20170106-6-deb_cv1
stdout: ncbi-data.out
