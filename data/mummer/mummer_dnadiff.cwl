cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnadiff
label: mummer_dnadiff
doc: "Run a comparative analysis of two sequence sets using nucmer and its associated utilities with recommended parameters, and write a report plus alignment, SNP and breakpoint files.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
    dockerOutputDirectory: /data
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.delta_sequences)
inputs:
  - id: delta_file
    type:
      - 'null'
      - File
    doc: "Provide precomputed delta file for analysis (use instead of the reference and query)"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: prefix
    type: string
    default: out
    doc: "Set the prefix of the output files (default out)"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: delta_sequences
    type:
      - 'null'
      - File[]
    doc: "Reference and query sequence files named in the delta file given with -d. They are staged in the working directory /data, the same place nucmer used, because the delta file records their absolute paths. Not needed when the reference and query are given."
  - id: reference
    type:
      - 'null'
      - File
    doc: "Set the input reference multi-FASTA filename (not used with a delta file)"
    inputBinding:
      position: 100
  - id: query
    type:
      - 'null'
      - File
    doc: "Set the input query multi-FASTA filename (not used with a delta file)"
    inputBinding:
      position: 101
outputs:
  - id: report_out
    type: File
    doc: "Summary of alignments, differences and SNPs"
    outputBinding:
      glob: "$(inputs.prefix).report"
  - id: delta_out
    type:
      - 'null'
      - File
    doc: "Standard nucmer alignment output"
    outputBinding:
      glob: "$(inputs.prefix).delta"
  - id: 1delta_out
    type:
      - 'null'
      - File
    doc: "1-to-1 alignment from delta-filter -1"
    outputBinding:
      glob: "$(inputs.prefix).1delta"
  - id: mdelta_out
    type:
      - 'null'
      - File
    doc: "M-to-M alignment from delta-filter -m"
    outputBinding:
      glob: "$(inputs.prefix).mdelta"
  - id: 1coords_out
    type:
      - 'null'
      - File
    doc: "1-to-1 coordinates from show-coords -THrcl on the 1delta file"
    outputBinding:
      glob: "$(inputs.prefix).1coords"
  - id: mcoords_out
    type:
      - 'null'
      - File
    doc: "M-to-M coordinates from show-coords -THrcl on the mdelta file"
    outputBinding:
      glob: "$(inputs.prefix).mcoords"
  - id: snps_out
    type:
      - 'null'
      - File
    doc: "SNPs from show-snps -rlTHC on the 1delta file"
    outputBinding:
      glob: "$(inputs.prefix).snps"
  - id: rdiff_out
    type:
      - 'null'
      - File
    doc: "Classified reference breakpoints from show-diff -rH on the mdelta file"
    outputBinding:
      glob: "$(inputs.prefix).rdiff"
  - id: qdiff_out
    type:
      - 'null'
      - File
    doc: "Classified query breakpoints from show-diff -qH on the mdelta file"
    outputBinding:
      glob: "$(inputs.prefix).qdiff"
  - id: unref_out
    type:
      - 'null'
      - File
    doc: "Unaligned reference IDs and lengths (if applicable)"
    outputBinding:
      glob: "$(inputs.prefix).unref"
  - id: unqry_out
    type:
      - 'null'
      - File
    doc: "Unaligned query IDs and lengths (if applicable)"
    outputBinding:
      glob: "$(inputs.prefix).unqry"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
stderr: mummer_dnadiff.log
