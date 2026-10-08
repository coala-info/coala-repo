cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rt-shifts
label: mzquality_rt-shifts
doc: "Calculate the RT shifts of each compound per batch.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: mea_file
    type: File
    doc: Measurements file (tab-separated with columns sample, aliquot, type, injection, replicate, batch, order, datetime, compound, rt, area, compound_is, rt_is, area_is)
    inputBinding:
      position: 1
      prefix: --mea-file
  - id: rt_shifts_file
    type: string
    doc: Output TSV file with the RT shifts
    inputBinding:
      position: 2
      prefix: --rt-shifts-file
outputs:
  - id: rt_shifts
    type: File
    doc: RT shift table
    outputBinding:
      glob: $(inputs.rt_shifts_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
