cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv2spectrast.py
label: msproteomicstools_tsv2spectrast.py
doc: "Convert a tab-delimited transition library (columns group_id, precursor,
  PeptideSequence, ProteinName, rt_calibrated, charge, product, library_intensity)
  into a SpectraST library.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_tsv
    type: File
    doc: Input TSV library file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Output library name (the SpectraST files are written with this prefix)
    inputBinding:
      position: 2
outputs:
  - id: output_spectrast
    type:
      type: array
      items: File
    doc: Output SpectraST library files
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
