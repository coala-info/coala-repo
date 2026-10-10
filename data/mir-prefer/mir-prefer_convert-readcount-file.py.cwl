cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - convert-readcount-file.py
label: mir-prefer_convert-readcount-file.py
doc: "Convert read count files (sequence and depth per line) to the miR-PREFeR read format SampleName_rA_xB\n\nTool homepage: https://github.com/hangelwen/miR-PREFeR"
arguments:
  - position: 2
    valueFrom: $(inputs.readcount_files.map(function(f) { return f.basename; }))
inputs:
  - id: samplenamelist
    type: File
    doc: File listing the sample names, one per line, in the same order as the input files
    inputBinding:
      position: 1
  - id: readcount_files
    type:
      type: array
      items: File
    doc: Read count files with two columns, sequence and depth, separated by space or tab, in the same order as the sample names
outputs:
  - id: processed_files
    type:
      type: array
      items: File
    doc: Processed files, named like the inputs with the suffix .processed
    outputBinding:
      glob: '*.processed'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.readcount_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mir-prefer:0.24--py27_0
