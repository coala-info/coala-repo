cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup2juicer
label: hicup2juicer
doc: 'The hicup2juicer script converts HiCUP BAM/SAM files to a format compatible
  with Juicer and JuiceBox. The output may be converted to Juicer ''.hic'' files with
  the Juicer ''pre'' command. The output file is written beside the input file.


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
    doc: Specify the genome digest file (created by hicup_digester); this allows to
      get the fragment id
    inputBinding:
      position: 103
      prefix: --digest
  - id: usemid
    type:
      - 'null'
      - boolean
    doc: Use the middle of the fragment as position instead of the 5' end
    inputBinding:
      position: 103
      prefix: --usemid
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Write output to a gzip file
    inputBinding:
      position: 103
      prefix: --zip
outputs:
  - id: juicer_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Juicer pre-format files
    outputBinding:
      glob: '*.prejuicer*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
