cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - internal-standard-rsd
label: mzquality_internal-standard-rsd
doc: "Calculate the Internal Standard RSD's.\n\nmzQuality is a Tool for quality monitoring and reporting of mass spectrometry measurements. The image ENTRYPOINT is /files/mzQuality/qcli.py (not on PATH), so the command words start at the subcommand.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs:
  - id: qc_corrected_file
    type: File
    doc: QC corrected measurements file (output of qc-correction)
    inputBinding:
      position: 1
      prefix: --qc-corrected-file
  - id: is_rsd_file
    type: string
    doc: Output TSV file with the internal standard RSDs
    inputBinding:
      position: 2
      prefix: --is-rsd-file
  - id: by_batch
    type: ['null', boolean]
    doc: Calculate per batch instead of over all batches
    inputBinding:
      position: 3
      prefix: --by-batch
outputs:
  - id: is_rsd
    type: File
    doc: Internal standard RSD table
    outputBinding:
      glob: $(inputs.is_rsd_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
