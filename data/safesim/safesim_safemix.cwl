cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - safesim
  - safemix
label: safesim_safemix
doc: "The provided text does not contain help information for safesim_safemix, but
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the safesim image.\n\nTool homepage: https://github.com/genetronhealth/safesim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
stdout: safesim_safemix.out
