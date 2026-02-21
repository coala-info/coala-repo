cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfdistance
label: vcflib_vcfdistance
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages indicating a failure to fetch the OCI image.\n\n
  Tool homepage: https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfdistance.out
