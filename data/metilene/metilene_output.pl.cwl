cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metilene_output.pl
label: metilene_output.pl
doc: "Filter metilene DMR results by q-value, CpG count, methylation difference and
  length, and write a bedgraph, a table and summary plots.\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/metilene"
inputs:
  - id: query_file
    type: File
    doc: path/filename of metilene DMRs
    inputBinding:
      position: 101
      prefix: -q
  - id: max_qvalue
    type:
      - 'null'
      - float
    doc: 'maximum (<) adj. p-value (q-value) for output of significant DMRs (default:
      0.05)'
    inputBinding:
      position: 101
      prefix: -p
  - id: min_cpgs
    type:
      - 'null'
      - int
    doc: 'minimum (>=) cpgs (default:10)'
    inputBinding:
      position: 101
      prefix: -c
  - id: min_meth_diff
    type:
      - 'null'
      - float
    doc: 'minimum mean methylation difference (>=) (default:0.1)'
    inputBinding:
      position: 101
      prefix: -d
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'minimum length of DMR [nt] (>=) (post-processing, default: 0)'
    inputBinding:
      position: 101
      prefix: -l
  - id: group_a
    type:
      - 'null'
      - string
    doc: 'name of group A (default:"g1")'
    inputBinding:
      position: 101
      prefix: -a
  - id: group_b
    type:
      - 'null'
      - string
    doc: 'name of group B (default:"g2")'
    inputBinding:
      position: 101
      prefix: -b
  - id: out_prefix
    type: string
    default: metilene_out
    doc: 'path/prefix of output files (default: input_path/)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Filtered DMR table (.out), bedgraph and plots (.pdf)
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
