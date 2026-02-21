cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmlst
label: pmlst
doc: "The provided text does not contain help information for the tool 'pmlst'. It
  appears to be an error log from a container build process (Singularity/Apptainer).\n
  \nTool homepage: https://bitbucket.org/genomicepidemiology/pmlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmlst:2.0.3--hdfd78af_0
stdout: pmlst.out
