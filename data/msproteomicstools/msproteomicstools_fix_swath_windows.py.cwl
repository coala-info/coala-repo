cwlVersion: v1.2
class: CommandLineTool
baseCommand: msproteomicstools_fix_swath_windows.py
label: msproteomicstools_fix_swath_windows.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h8b767f7_4
stdout: msproteomicstools_fix_swath_windows.py.out
