cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup2hicpipe
label: hicup2hicpipe
doc: 'The hicup2hicpipe script converts HiCUP BAM/SAM files to a format compatible
  with Hicpipe, termed a RAW data format file (6 columns for each di-tag). The output
  file is written beside the input file.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: sam_bam_files
    type:
      type: array
      items: File
    doc: HiCUP SAM/BAM files (staged writable because the outputs are written beside
      them)
    inputBinding:
      position: 2
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: raw_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Hicpipe RAW format files
    outputBinding:
      glob: '*.raw*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
