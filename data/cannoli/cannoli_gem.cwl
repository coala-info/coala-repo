cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_gem
label: cannoli_gem
doc: "The provided text appears to be a system error log from a container runtime
  (Singularity/Apptainer) rather than CLI help text. No command-line arguments, flags,
  or tool descriptions could be extracted from this input.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_gem.out
