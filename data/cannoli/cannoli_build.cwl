cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_build
label: cannoli_build
doc: "The provided text appears to be a log from a container build process (Singularity/Apptainer)
  rather than command-line help text. As a result, no specific arguments, flags, or
  positional parameters could be extracted.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_build.out
