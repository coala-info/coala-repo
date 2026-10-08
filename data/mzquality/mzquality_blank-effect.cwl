cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blank-effect
label: mzquality_blank-effect
doc: "Calculate the blank effect of each compound.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: mea_file
    type: File
    doc: Measurements file (tab-separated with columns sample, aliquot, type, injection, replicate, batch, order, datetime, compound, rt, area, compound_is, rt_is, area_is)
    inputBinding:
      position: 1
      prefix: --mea-file
  - id: blank_effect_file
    type: string
    doc: Output TSV file with the blank effect
    inputBinding:
      position: 2
      prefix: --blank-effect-file
  - id: by_batch
    type: ['null', boolean]
    doc: Calculate per batch instead of over all batches
    inputBinding:
      position: 3
      prefix: --by-batch
outputs:
  - id: blank_effect
    type: File
    doc: Blank effect table
    outputBinding:
      glob: $(inputs.blank_effect_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
