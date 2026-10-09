cwlVersion: v1.2
class: CommandLineTool
baseCommand: hardklor
label: hardklor
doc: "Hardklor in configuration-file mode: detects isotope-distribution features in
  high-resolution mass spectra. The config file lists the settings and, on its last
  lines, pairs of input and output file names (for example `YourData.mzML YourData.hk`).
  The input files and any data files named in the config are staged in the working
  directory, so the config must use bare file names.\n\nTool homepage: https://github.com/mhoopmann/hardklor"
inputs:
  - id: config_file
    type: File
    doc: Configuration file for Hardklor
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Spectra files named in the config file (staged in the working directory)
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional ISOTOPE.DAT and Hardklor.dat files named in the config file
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Hardklor results named in the config file (by convention .hk)
    outputBinding:
      glob: '*.hk'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_files.concat(inputs.data_files || []))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hardklor:2.3.2--h503566f_6
