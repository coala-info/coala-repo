cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid
label: tepid
doc: "The provided text does not contain help information for the tool 'tepid'. It
  appears to be a log of a failed container build process (Apptainer/Singularity)
  attempting to fetch the 'tepid' image from a container registry.\n\nTool homepage:
  https://github.com/ListerLab/TEPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid.out
