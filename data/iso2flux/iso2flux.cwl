cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_and_solve_iso2flux_model.py
label: iso2flux
doc: "Creates and solves an iso2flux model.\n\nTool homepage: https://github.com/cfoguet/iso2flux"
inputs:
  - id: experimental_data_file
    type: File
    doc: Path to the experimental data file.
    inputBinding:
      position: 101
      prefix: --experimental_data_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux.out
