cwlVersion: v1.2
class: CommandLineTool
baseCommand: sphae
label: sphae
doc: "The provided text does not contain help information for the tool 'sphae'. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the tool's image.\n\nTool homepage: https://github.com/linsalrob/sphae/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sphae:1.5.3--pyhdfd78af_0
stdout: sphae.out
