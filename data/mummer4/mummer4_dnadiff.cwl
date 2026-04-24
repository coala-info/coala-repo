cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnadiff
label: mummer4_dnadiff
doc: "Run comparative analysis of two sequence sets using nucmer and its associated
  utilities with recommended parameters. See MUMmer documentation for a more detailed
  description of the output. Produces the following output files:\n\n    .report \
  \ - Summary of alignments, differences and SNPs\n    .delta   - Standard nucmer
  alignment output\n    .1delta  - 1-to-1 alignment from delta-filter -1\n    .mdelta\
  \  - M-to-M alignment from delta-filter -m\n    .1coords - 1-to-1 coordinates from
  show-coords -THrcl .1delta\n    .mcoords - M-to-M coordinates from show-coords -THrcl
  .mdelta\n    .snps    - SNPs from show-snps -rlTHC .1delta\n    .rdiff   - Classified
  ref breakpoints from show-diff -rH .mdelta\n    .qdiff   - Classified qry breakpoints
  from show-diff -qH .mdelta\n    .unref   - Unaligned reference IDs and lengths (if
  applicable)\n    .unqry   - Unaligned query IDs and lengths (if applicable)\n\n\
  Tool homepage: https://mummer4.github.io/"
inputs:
  - id: reference
    type: File
    doc: Set the input reference multi-FASTA filename
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: Set the input query multi-FASTA filename
    inputBinding:
      position: 2
  - id: delta_file
    type: File
    doc: Provide precomputed delta file for analysis
    inputBinding:
      position: 103
      prefix: delta
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Set the prefix of the output files
    inputBinding:
      position: 103
      prefix: prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_dnadiff.out
