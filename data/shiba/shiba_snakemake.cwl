cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba_snakemake
label: shiba_snakemake
doc: "The provided text does not contain help information or usage instructions; it
  consists of error logs from a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba:0.8.1--py312hdfd78af_0
stdout: shiba_snakemake.out
