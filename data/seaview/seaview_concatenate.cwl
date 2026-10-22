cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_concatenate
doc: "concatenate alignment(s) to the end of an input alignment (no window creation)\n\nTool homepage: http://doua.prabi.fr/software/seaview"
inputs:
  - id: concatenate
    type:
      type: array
      items: File
    doc: "name(s) of alignment files to add at the end of the input alignment (comma separated on the command line)"
    inputBinding:
      position: 1
      prefix: -concatenate
      itemSeparator: ","
  - id: by_rank
    type: ['null', boolean]
    doc: "identify sequences by their rank in alignments (rather than by their name)"
    inputBinding:
      position: 2
      prefix: -by_rank
  - id: record_partition
    type: ['null', boolean]
    doc: "record the locations of the concatenated pieces in the final concatenate"
    inputBinding:
      position: 2
      prefix: -record_partition
  - id: output_format
    type: ['null', string]
    doc: "format of the concatenated alignment (mase, phylip, clustal, msf, fasta, or nexus)"
    inputBinding:
      position: 2
      prefix: -output_format
  - id: output_file
    type: ['null', string]
    doc: "use fname as name of the concatenated alignment (default is built from input filename)"
    inputBinding:
      position: 2
      prefix: -o
  - id: fontsize
    type: ['null', int]
    doc: "font size used for the tree plot or alignment windows"
    inputBinding:
      position: 2
      prefix: -fontsize
  - id: fast
    type: ['null', boolean]
    doc: "sequences will be displayed faster but less smoothly"
    inputBinding:
      position: 2
      prefix: -fast
  - id: input_file
    type: File
    doc: "alignment or sequence file to be read (always the last argument)"
    inputBinding:
      position: 99
outputs:
  - id: output_result
    type: ['null', File]
    doc: Output written with -o
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_concatenate.out
