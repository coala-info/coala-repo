cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: ucsc-twobitinfo
doc: "Get information about sequences in a .2bit file. The output file has the columns\
  \ seqName and size.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_2bit
    type: File
    doc: Input .2bit file.
    inputBinding:
      position: 1
      valueFrom: '$(self.path + (inputs.sequences ? ":" + inputs.sequences : ""))'
  - id: sequences
    type:
      - 'null'
      - string
    doc: Comma-separated sequence names (the path:seq1,seq2,seqN form) so that information is returned only on the requested sequence(s).
  - id: output_tab
    type: string
    doc: Output tab-separated file name.
    inputBinding:
      position: 2
  - id: mask_bed
    type:
      - 'null'
      - boolean
    doc: Instead of seq sizes, output BED records that define areas with masked sequence.
    inputBinding:
      position: 103
      prefix: -maskBed
  - id: n_bed
    type:
      - 'null'
      - boolean
    doc: Instead of seq sizes, output BED records that define areas with N's in sequence.
    inputBinding:
      position: 103
      prefix: -nBed
  - id: no_ns
    type:
      - 'null'
      - boolean
    doc: Outputs the length of each sequence, but does not count Ns.
    inputBinding:
      position: 103
      prefix: -noNs
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: Place to put cache for remote bigBed/bigWigs.
    inputBinding:
      position: 103
      prefix: -udcDir=
      separate: false
outputs:
  - id: out_output_tab
    type: File
    doc: Output tab-separated file.
    outputBinding:
      glob: $(inputs.output_tab)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitinfo:482--hdc0a859_0
