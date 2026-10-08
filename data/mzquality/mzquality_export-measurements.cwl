cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - export-measurements
label: mzquality_export-measurements
doc: "Exports data as samples vs compounds.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: measurements_file
    type: File
    doc: Measurements file (raw or QC corrected)
    inputBinding:
      position: 1
      prefix: --file
  - id: column
    type: string
    doc: Column to export, e.g. area, ratio or inter_median_qc_corrected
    inputBinding:
      position: 2
      prefix: --column
  - id: export_location
    type: string
    doc: Output TSV file (samples vs. compounds)
    inputBinding:
      position: 3
      prefix: --export-location
  - id: include_is
    type: ['null', boolean]
    doc: Also export the internal standard area of each compound
    inputBinding:
      position: 4
      prefix: --include-is
outputs:
  - id: exported
    type: File
    doc: Samples vs. compounds table
    outputBinding:
      glob: $(inputs.export_location)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
