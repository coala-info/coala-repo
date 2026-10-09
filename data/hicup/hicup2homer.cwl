cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup2homer
label: hicup2homer
doc: 'The hicup2homer script converts HiCUP BAM/SAM files to a format compatible with
  Homer (7 columns, with read pairs on the same line). The output file is written
  beside the input file.


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
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Write output to a gzip file
    inputBinding:
      position: 103
      prefix: --zip
outputs:
  - id: homer_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Homer format files
    outputBinding:
      glob: '*.homer*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
