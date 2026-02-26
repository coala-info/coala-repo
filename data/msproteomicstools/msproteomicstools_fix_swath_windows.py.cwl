cwlVersion: v1.2
class: CommandLineTool
baseCommand: msproteomicstools_fix_swath_windows.py
label: msproteomicstools_fix_swath_windows.py
doc: "Fixes SWATH windows based on a parameter file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: paramfilename
    type: File
    doc: Parameter file containing SWATH window information.
    inputBinding:
      position: 1
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Optional output file name for the fixed SWATH windows. If not provided,
      output will be to stdout.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
