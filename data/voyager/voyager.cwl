cwlVersion: v1.2
class: CommandLineTool
baseCommand: voyager
label: voyager
doc: "The provided text does not contain help information or usage instructions for
  the tool 'voyager'. It appears to be a log output from a container build process
  (Apptainer/Singularity) that encountered a fatal error while fetching an OCI image.\n
  \nTool homepage: https://bitbucket.org/sverre-phd-work/voyager/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voyager:0.1.4--hdfd78af_0
stdout: voyager.out
