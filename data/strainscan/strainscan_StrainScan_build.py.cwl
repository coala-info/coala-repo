cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainscan_StrainScan_build.py
label: strainscan_StrainScan_build.py
doc: "The provided text does not contain help information for strainscan_StrainScan_build.py;
  it contains error logs from a Singularity/Apptainer container build process. No
  arguments could be extracted.\n\nTool homepage: https://github.com/liaoherui/StrainScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
stdout: strainscan_StrainScan_build.py.out
