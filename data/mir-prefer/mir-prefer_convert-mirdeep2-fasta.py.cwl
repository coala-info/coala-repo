cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - convert-mirdeep2-fasta.py
label: mir-prefer_convert-mirdeep2-fasta.py
doc: "Convert collapsed read FASTA files in miRDeep2 format (read ids ending in _xN) to the miR-PREFeR read format SampleName_rA_xB\n\nTool homepage: https://github.com/hangelwen/miR-PREFeR"
arguments:
  - position: 2
    valueFrom: $(inputs.fasta_files.map(function(f) { return f.basename; }))
inputs:
  - id: samplenamelist
    type: File
    doc: File listing the sample names, one per line, in the same order as the input files
    inputBinding:
      position: 1
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Collapsed FASTA files in miRDeep2 format (read ids ending in _xN, one sequence line per read), in the same order as the sample names
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
    listing: $(inputs.fasta_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mir-prefer:0.24--py27_0
