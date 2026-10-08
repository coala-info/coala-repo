cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - summary
label: mzquality_summary
doc: "Report a summary of the measurements (batches, samples and compounds) as JSON on standard output.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: mea_file
    type: File
    doc: Measurements file (tab-separated with columns sample, aliquot, type, injection, replicate, batch, order, datetime, compound, rt, area, compound_is, rt_is, area_is)
    inputBinding:
      position: 1
      prefix: --mea-file
outputs:
  - id: summary_json
    type: stdout
    doc: JSON summary
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
stdout: mzquality_summary.json
