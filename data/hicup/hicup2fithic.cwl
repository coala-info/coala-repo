cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup2fithic
label: hicup2fithic
doc: 'The hicup2fithic script converts HiCUP BAM/SAM files to a format compatible
  with Fit-Hi-C. It produces two output files: a list of all restriction fragments
  and a list of mid-range contacts. The output files are written beside the input
  file.


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
  - id: digest_file
    type:
      - 'null'
      - File
    doc: HiCUP Digester generated digest file
    inputBinding:
      position: 103
      prefix: --digest
  - id: maximum
    type:
      - 'null'
      - int
    doc: The maximum allowed distance separation (bps) between contacts (selecting
      this option also removes trans contacts)
    inputBinding:
      position: 103
      prefix: --maximum
  - id: minimum
    type:
      - 'null'
      - int
    doc: The minimum allowed distance separation (bps) between contacts (selecting
      this option also removes trans contacts)
    inputBinding:
      position: 103
      prefix: --minimum
outputs:
  - id: fragments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Fit-Hi-C fragments file
    outputBinding:
      glob: '*.equal_binning.txt'
  - id: interactions_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Fit-Hi-C contacts file
    outputBinding:
      glob: '*.interactions.txt'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
