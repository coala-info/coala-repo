cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: makehub_twoBitInfo
doc: "get information about sequences in a .2bit file\n\nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: input_2bit
    type: File
    doc: Input .2bit file. Can be specified as path:seq or 
      path:seq1,seq2,seqN...
    inputBinding:
      position: 1
  - id: mask_bed
    type:
      - 'null'
      - boolean
    doc: instead of seq sizes, output BED records that define areas with masked 
      sequence
    inputBinding:
      position: 102
      prefix: -maskBed
  - id: n_bed
    type:
      - 'null'
      - boolean
    doc: instead of seq sizes, output BED records that define areas with N's in 
      sequence
    inputBinding:
      position: 102
      prefix: -nBed
  - id: no_ns
    type:
      - 'null'
      - boolean
    doc: outputs the length of each sequence, but does not count Ns
    inputBinding:
      position: 102
      prefix: -noNs
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: output_tab
    type: File
    doc: 'Output tab-separated file. Columns: seqName size'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
