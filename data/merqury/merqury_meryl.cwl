cwlVersion: v1.2
class: CommandLineTool
baseCommand: merqury_meryl
label: merqury_meryl
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' error during image construction.\n\nTool
  homepage: https://github.com/marbl/merqury"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merqury:1.3--hdfd78af_4
stdout: merqury_meryl.out
