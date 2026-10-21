cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - index
label: rtg-tools_rtg_index
doc: 'Creates index files for block compressed TAB-delimited genome position files. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: 'format of input to index. Allowed values are [sam, bam, cram, sv, coveragetsv, bed, vcf, gvcf, auto] (Default is auto)'
    inputBinding:
      position: 101
      prefix: --format
  - id: input_list_file
    type:
      - 'null'
      - File
    doc: 'file containing a list of block compressed files (1 per line) containing genome position data'
    inputBinding:
      position: 101
      prefix: --input-list-file
  - id: files
    type:
      type: array
      items: File
    doc: 'block compressed files containing data to be indexed. May be specified 0 or more times'
    inputBinding:
      position: 200
      valueFrom: '${return self.map(function(f){return f.basename;});}'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written beside the input files
    outputBinding:
      glob: ['*.tbi', '*.bai', '*.crai', '*.csi']
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_index.out
