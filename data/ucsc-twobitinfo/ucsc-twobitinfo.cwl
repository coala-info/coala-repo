cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: ucsc-twobitinfo
doc: get information about sequences in a .2bit file
inputs:
  - id: input_2bit
    type: string
    doc: input .2bit file, optionally specified in the form path:seq or 
      path:seq1,seq2,seqN... to return information only on requested sequence(s)
    inputBinding:
      position: 1
  - id: output_tab
    type: string
    doc: output tab-separated file
    inputBinding:
      position: 2
  - id: mask_bed
    type:
      - 'null'
      - boolean
    doc: instead of seq sizes, output BED records that define areas with masked 
      sequence
    inputBinding:
      position: 103
      prefix: -maskBed
  - id: n_bed
    type:
      - 'null'
      - boolean
    doc: instead of seq sizes, output BED records that define areas with N's in 
      sequence
    inputBinding:
      position: 103
      prefix: -nBed
  - id: no_ns
    type:
      - 'null'
      - boolean
    doc: outputs the length of each sequence, but does not count Ns
    inputBinding:
      position: 103
      prefix: -noNs
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 103
      prefix: -udcDir=
      separate: false
outputs:
  - id: out_output_tab
    type: File
    doc: output tab-separated file
    outputBinding:
      glob: $(inputs.output_tab)
  - id: output_udc_dir
    type:
      - 'null'
      - Directory
    doc: place to put cache for remote bigBed/bigWigs
    outputBinding:
      glob: $(inputs.udc_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitinfo:482--hdc0a859_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
