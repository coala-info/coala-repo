cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plot-compounds-zipped
label: mzquality_plot-compounds-zipped
doc: "Plot a list of compounds and store them as a zip file.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: qc_corrected_file
    type: File
    doc: QC corrected measurements file (output of qc-correction)
    inputBinding:
      position: 1
      prefix: --qc-corrected-file
  - id: zip_file
    type: string
    doc: Output zip file with one HTML plot per compound
    inputBinding:
      position: 2
      prefix: --zip-file
outputs:
  - id: plots_zip
    type: File
    doc: Zip file with the HTML plots
    outputBinding:
      glob: $(inputs.zip_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
