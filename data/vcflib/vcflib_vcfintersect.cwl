cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfintersect
label: vcflib_vcfintersect
doc: "The provided text does not contain help documentation for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) indicating
  a failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfintersect.out
