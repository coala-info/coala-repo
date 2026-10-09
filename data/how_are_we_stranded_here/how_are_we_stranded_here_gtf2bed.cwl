cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtf2bed
label: how_are_we_stranded_here_gtf2bed
doc: "Convert the exon lines of a GTF file to a BED12 file with one line per transcript\n\nTool homepage: https://github.com/betsig/how_are_we_stranded_here"
inputs:
  - id: gtf
    type: File
    doc: input gtf file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: transcript_id_marker
    type:
      - 'null'
      - string
    doc: text preceeding the transcript id in the 9th field
    inputBinding:
      position: 101
      prefix: --transcript_id_marker
  - id: bed
    type: string
    doc: output bed file
    inputBinding:
      position: 102
      prefix: --bed
outputs:
  - id: bed_file
    type: File
    doc: output BED12 file
    outputBinding:
      glob: $(inputs.bed)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
