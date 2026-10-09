cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup2ncc
label: hicup2ncc
doc: 'The hicup2ncc script converts HiCUP BAM/SAM files to NCC format, which is generated
  by the NucProcess pipeline. The script expects the sonication protocol to have been
  followed in the Hi-C library construction. The output file is written beside the
  aligned file.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: aligned
    type:
      type: array
      items: File
    doc: Whitespace-separated list of HiCUP BAM/SAM files (staged writable because
      the outputs are written beside them)
    inputBinding:
      position: 103
      prefix: --aligned
      itemSeparator: ' '
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: digest_file
    type: File
    doc: HiCUP digest file used in HiCUP analysis
    inputBinding:
      position: 103
      prefix: --digest
  - id: fastq1
    type:
      type: array
      items: File
    doc: Whitespace-separated list of FASTQ (read1) files, in the same order as the
      aligned files
    inputBinding:
      position: 103
      prefix: --fastq1
      itemSeparator: ' '
  - id: fastq2
    type:
      type: array
      items: File
    doc: Whitespace-separated list of FASTQ (read2) files, in the same order as the
      aligned files
    inputBinding:
      position: 103
      prefix: --fastq2
      itemSeparator: ' '
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Write output to a gzip file
    inputBinding:
      position: 103
      prefix: --zip
outputs:
  - id: ncc_files
    type:
      - 'null'
      - type: array
        items: File
    doc: NCC format files
    outputBinding:
      glob: '*.ncc*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.aligned)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
