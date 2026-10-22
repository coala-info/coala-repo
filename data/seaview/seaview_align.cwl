cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_align
doc: "align an input sequence file (no window creation)\n\nTool homepage: http://doua.prabi.fr/software/seaview"
inputs:
  - id: align_mode
    type: ['null', boolean]
    default: true
    doc: "Select the non-interactive mode: align an input sequence file (no window creation)"
    inputBinding:
      position: 1
      prefix: -align
  - id: align_algo
    type: ['null', int]
    doc: "rank (in seaview from 0) of alignment algorithm, otherwise use seaview's default alignment algorithm"
    inputBinding:
      position: 2
      prefix: -align_algo
  - id: align_extra_opts
    type: ['null', string]
    doc: "additional options to use when running the alignment algorithm"
    inputBinding:
      position: 2
      prefix: -align_extra_opts
  - id: align_at_protein_level
    type: ['null', boolean]
    doc: "translate and align input sequences and reproduce alignment at DNA level"
    inputBinding:
      position: 2
      prefix: -align_at_protein_level
  - id: output_format
    type: ['null', string]
    doc: "format of the output alignment (mase, phylip, clustal, msf, fasta, or nexus)"
    inputBinding:
      position: 2
      prefix: -output_format
  - id: output_file
    type: ['null', string]
    doc: "use fname as name of the output alignment (default is built from input filename)"
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
stdout: seaview_align.out
