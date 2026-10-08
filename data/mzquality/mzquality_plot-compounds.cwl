cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plot-compounds
label: mzquality_plot-compounds
doc: "Plot a list of compounds.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: qc_corrected_file
    type: File
    doc: QC corrected measurements file (output of qc-correction)
    inputBinding:
      position: 1
      prefix: --qc-corrected-file
  - id: plot_location
    type: string
    doc: Output folder for the HTML plots (created if missing)
    inputBinding:
      position: 2
      prefix: --plot-location
outputs:
  - id: plots
    type: Directory
    doc: Folder with one HTML plot per compound
    outputBinding:
      glob: $(inputs.plot_location)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
