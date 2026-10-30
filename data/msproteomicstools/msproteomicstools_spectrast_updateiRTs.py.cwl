cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spectrast_updateiRTs.py
label: msproteomicstools_spectrast_updateiRTs.py
doc: "Update the RetTime values of SpectraST sptxt files with iRT values calculated with a linear model; the result is written as <name>_iRT.sptxt.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: sptxt_files
    type: 'File[]'
    doc: "SpectraST .sptxt file(s)"
    inputBinding:
      position: 20
      valueFrom: $(self.map(function(f){return f.basename;}))
  - id: auto_align
    type: ['null', boolean]
    doc: "Calculate the alignment models from the internal identifications of the calibration peptides"
    inputBinding:
      prefix: -a
  - id: irt_model
    type: ['null', File]
    doc: "File with the iRT models"
    inputBinding:
      prefix: -i
  - id: irt_peptides
    type: ['null', File]
    doc: "File containing the peptides and their iRTs for the linear model alignment"
    inputBinding:
      prefix: -p
  - id: time_scale
    type: ['null', {type: enum, symbols: [minutes, seconds]}]
    doc: "Time scale (default seconds)"
    inputBinding:
      prefix: -t
outputs:
  - id: updated_files
    type: 'File[]'
    doc: "Updated libraries"
    outputBinding:
      glob: "*_iRT.sptxt"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sptxt_files)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_spectrast_updateiRTs.py.out
