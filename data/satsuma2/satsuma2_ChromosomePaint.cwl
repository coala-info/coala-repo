cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ChromosomePaint]
label: satsuma2_ChromosomePaint
doc: "Comparative chromosome painter.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "MizBee file (as written by BlockDisplaySatsuma)"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: "outfile (post-script)"
    inputBinding:
      position: 2
      prefix: -o
  - id: dot_size
    type: ['null', double]
    doc: "dot size (def=1). The help also lists a second option -d (print individual matches, boolean) that shares the same flag"
    inputBinding:
      position: 3
      prefix: -d
  - id: scale
    type: ['null', double]
    doc: "scale (def=60000)"
    inputBinding:
      position: 4
      prefix: -s
  - id: target_id
    type: ['null', int]
    doc: "target id (def=-1)"
    inputBinding:
      position: 5
      prefix: -t
  - id: forward_only
    type: ['null', boolean]
    doc: "forward only (def=0)"
    inputBinding:
      position: 6
      prefix: -f
outputs:
  - id: painting
    type: File
    doc: "Chromosome painting (PostScript)"
    outputBinding:
      glob: "$(inputs.output_file)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
