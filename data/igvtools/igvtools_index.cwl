cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - index
label: igvtools_index
doc: "Create an index (.sai for alignments, .idx for features) for a sorted .bed, .gff, .vcf, .sam or .bam file. The index is written beside the input file.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: "Input file, sorted by start position; staged writable so the index can be written beside it"
arguments:
  - position: 10
    valueFrom: $(inputs.input_file.basename)
outputs:
  - id: index_file
    type: File[]
    doc: "Index file (<input>.sai for alignments, <input>.idx for features)"
    outputBinding:
      glob: ["$(inputs.input_file.basename).sai", "$(inputs.input_file.basename).idx"]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
