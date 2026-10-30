cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectrast_create.rb
label: protk_spectrast_create.rb
doc: 'Create a spectral library from pep.xml input files.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: pepxml_files
    type:
      type: array
      items: File
    doc: Input pepXML files (staged in the working directory beside the spectrum files, where SpectraST
      looks for them)
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f){ return f.basename; }))
  - id: spectrum_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to raw spectrum files. These should be provided in a comma separated list
    inputBinding:
      position: 102
      prefix: --spectrum-files
      itemSeparator: ','
      valueFrom: $(self.map(function(f){ return f.basename; }))
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Produce spectral libraries in binary format rather than ASCII [false]
    inputBinding:
      position: 102
      prefix: --binary-output
  - id: predicate
    type:
      - 'null'
      - string
    doc: Keep only spectra satifying predicate pred. Should be a C-style predicate
    inputBinding:
      position: 102
      prefix: --predicate
  - id: p_thresh
    type:
      - 'null'
      - float
    doc: Probability threshold below which spectra are discarded [0.99]
    inputBinding:
      position: 102
      prefix: --p-thresh
  - id: instrument_acquisition
    type:
      - 'null'
      - string
    doc: 'Set the instrument and acquisition settings of the spectra (in case not specified in data files).
      Examples: CID, ETD, CID-QTOF, HCD. The latter two are treated as high-mass accuracy spectra. [CID]'
    inputBinding:
      position: 102
      prefix: --instrument-acquisition
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: library_files
    type:
      type: array
      items: File
    doc: Spectral library files (.splib, .spidx, .pepidx, .sptxt as written)
    outputBinding:
      glob: $(inputs.output_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pepxml_files)
      - ${ return inputs.spectrum_files || []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
