cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_unimap
label: cannoli_unimap
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container build process (Singularity/Apptainer) indicating
  a 'no space left on device' failure.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_unimap.out
