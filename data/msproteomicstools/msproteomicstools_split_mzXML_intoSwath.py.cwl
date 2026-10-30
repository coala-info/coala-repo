cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - split_mzXML_intoSwath.py
label: msproteomicstools_split_mzXML_intoSwath.py
doc: "Split an mzXML(.gz) file of SWATH scans into one file per SWATH window (and an MS1 file).\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_file
    type: File
    doc: "mzXML or mzXML.gz file"
    inputBinding:
      position: 1
  - id: window_size
    type: int
    doc: "Number of SWATH windows (usually 32)"
    inputBinding:
      position: 2
  - id: output_dir
    type: ['null', string]
    doc: "Output directory (default .)"
    inputBinding:
      position: 3
  - id: noms1map
    type: ['null', boolean]
    doc: "Do not write the MS1 scans"
    inputBinding:
      position: 4
      valueFrom: "$(self ? \"noms1map\" : null)"
outputs:
  - id: split_files
    type: 'File[]'
    doc: "Split mzXML files"
    outputBinding:
      glob: "split_*.mzXML"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_split_mzXML_intoSwath.py.out
