cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - gbfiletool
  - cut
label: mitoz_tools_gbfiletool_cut
doc: "Cut GenBank records (5' and/or 3' end): the sub-records [start, stop] of the given records are output; other records are omitted.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: input_genbank
    type: File
    doc: "genbank input file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_genbank
    type: string
    doc: "genbank out file"
    inputBinding:
      position: 2
      prefix: -o
  - id: regions
    type: string[]
    doc: "sequence regions to output as seqid:start:stop. subrecord [start, stop] will be output. if seqid:start, sites from start to the end of rec will be output; other seq records will be omitted. position is 1-left"
    inputBinding:
      position: 3
      prefix: -k
outputs:
  - id: genbank_out
    type: File
    doc: "Output GenBank file."
    outputBinding:
      glob: $(inputs.output_genbank)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
