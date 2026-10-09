cwlVersion: v1.2
class: CommandLineTool
baseCommand: annot-tsv
label: htslib_annot_tsv
doc: "Annotate regions of the target file (TGT) with information from overlapping regions of the source file (SRC). Multiple columns can be transferred and the transfer can be conditioned on matching values in one or more columns. All indexes and coordinates are 1-based and inclusive.\n\nTool homepage: https://github.com/samtools/htslib"
inputs:
  - id: source_file
    type: File
    doc: "Source file to take annotations from"
    inputBinding:
      position: 101
      prefix: --source-file
  - id: target_file
    type: File
    doc: "Target file to be extended with annotations from -s"
    inputBinding:
      position: 102
      prefix: --target-file
  - id: core
    type:
      - 'null'
      - string
    doc: "Core columns in SRC and TGT file, as SRC:TGT [chr,beg,end:chr,beg,end]"
    inputBinding:
      position: 103
      prefix: --core
  - id: transfer
    type:
      - 'null'
      - string
    doc: "Columns to transfer, as SRC:TGT. If SRC column does not exist, interpret as the default value to use"
    inputBinding:
      position: 104
      prefix: --transfer
  - id: match
    type:
      - 'null'
      - string
    doc: "Require match in these columns for annotation transfer, as SRC:TGT"
    inputBinding:
      position: 105
      prefix: --match
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file name [STDOUT]"
    inputBinding:
      position: 106
      prefix: --output
  - id: allow_dups
    type:
      - 'null'
      - boolean
    doc: "Add annotations multiple times"
    inputBinding:
      position: 107
      prefix: --allow-dups
  - id: max_annots
    type:
      - 'null'
      - int
    doc: "Adding at most INT annotations per column to save time in big regions"
    inputBinding:
      position: 108
      prefix: --max-annots
  - id: annotate
    type:
      - 'null'
      - string
    doc: "Add special annotations, one or more of: cnt (number of overlapping regions), frac (fraction of the target region with an overlap), nbp (number of source base pairs in the overlap), as a comma separated list"
    inputBinding:
      position: 109
      prefix: --annotate
  - id: coords
    type:
      - 'null'
      - string
    doc: "Are coordinates 0 or 1-based, as SRC:TGT, BED=01, TSV=11 [11]"
    inputBinding:
      position: 110
      prefix: --coords
  - id: delim
    type:
      - 'null'
      - string
    doc: "Column delimiter in SRC and TGT file, as SRC:TGT"
    inputBinding:
      position: 111
      prefix: --delim
  - id: headers
    type:
      - 'null'
      - string
    doc: "Header row line number as SRC:TGT, 0:0 is equivalent to -H, negative value counts from the end of comment line block [1:1]"
    inputBinding:
      position: 112
      prefix: --headers
  - id: ignore_headers
    type:
      - 'null'
      - boolean
    doc: "Use numeric indices, ignore the headers completely"
    inputBinding:
      position: 113
      prefix: --ignore-headers
  - id: no_header_idx
    type:
      - 'null'
      - boolean
    doc: "Suppress index numbers in the printed header"
    inputBinding:
      position: 114
      prefix: --no-header-idx
  - id: drop_header
    type:
      - 'null'
      - boolean
    doc: "Drop the entire header (-I given twice)"
    inputBinding:
      position: 115
      prefix: -II
  - id: overlap
    type:
      - 'null'
      - string
    doc: "Minimum required overlap with respect to SRC,TGT, as FLOAT[,FLOAT]. If single value, the bigger overlap is considered"
    inputBinding:
      position: 116
      prefix: --overlap
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: "Apply the overlap requirement to both overlapping intervals"
    inputBinding:
      position: 117
      prefix: --reciprocal
  - id: drop_overlaps
    type:
      - 'null'
      - boolean
    doc: "Drop overlapping regions (precludes -f)"
    inputBinding:
      position: 118
      prefix: --drop-overlaps
outputs:
  - id: stdout
    type: stdout
    doc: "Annotated target file (empty when an output file is given)"
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Annotated target file written with --output"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
stdout: htslib_annot_tsv.out
