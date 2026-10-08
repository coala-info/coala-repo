cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qc-correction
label: mzquality_qc-correction
doc: "Calculate the QC corrected data.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: mea_file
    type: File
    doc: Measurements file (tab-separated with columns sample, aliquot, type, injection, replicate, batch, order, datetime, compound, rt, area, compound_is, rt_is, area_is)
    inputBinding:
      position: 1
      prefix: --mea-file
  - id: qc_corrected_file
    type: string
    doc: Output TSV file with the QC corrected measurements
    inputBinding:
      position: 2
      prefix: --qc-corrected-file
outputs:
  - id: qc_corrected
    type: File
    doc: QC corrected measurements
    outputBinding:
      glob: $(inputs.qc_corrected_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
