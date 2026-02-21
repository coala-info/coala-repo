cwlVersion: v1.2
class: CommandLineTool
baseCommand: disambiguate.py
label: ngs-disambiguate_disambiguate.py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/AstraZeneca-NGS/disambiguate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-disambiguate:2018.05.03--h2bd4fab_12
stdout: ngs-disambiguate_disambiguate.py.out
