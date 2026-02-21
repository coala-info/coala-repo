cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismrmrd-tools_recon_multi_reps.py
label: ismrmrd-tools_recon_multi_reps.py
doc: "A tool for reconstructing ISMRMRD data with multiple repetitions. (Note: The
  provided input text contained container runtime error messages rather than help
  text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/ismrmrd/ismrmrd-python-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ismrmrd-tools:v1.4.0-1-deb_cv1
stdout: ismrmrd-tools_recon_multi_reps.py.out
