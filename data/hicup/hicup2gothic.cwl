cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup2gothic
label: hicup2gothic
doc: 'The hicup2gothic script converts HiCUP BAM/SAM files to a format compatible
  with GOTHiC (4 columns, with reads on separate lines: read ID, SAM flag, chromosome
  name, position). The output file is written beside the input file.


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
  - id: gothic_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GOTHiC format files
    outputBinding:
      glob: '*.gothic*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
