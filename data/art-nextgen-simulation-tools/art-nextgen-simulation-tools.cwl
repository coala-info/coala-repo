cwlVersion: v1.2
class: CommandLineTool
baseCommand: ''
label: art-nextgen-simulation-tools
doc: The provided text does not contain help information or usage instructions. 
  It appears to be a fatal error log from a container build process 
  (Singularity/Apptainer) indicating a 'no space left on device' error during 
  the extraction of an OCI image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/art-nextgen-simulation-tools:v20160605dfsg-3-deb_cv1
stdout: art-nextgen-simulation-tools.out
