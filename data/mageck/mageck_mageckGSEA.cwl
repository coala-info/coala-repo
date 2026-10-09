cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mageckGSEA
label: mageck_mageckGSEA
doc: "mageckGSEA: A fast implementation of GSEA enrichment test.\n\nTool homepage:
  http://mageck.sourceforge.net"
inputs:
  - id: rank_file
    type: File
    doc: Rank file. The first column of the rank file must be the gene name.
    inputBinding:
      position: 101
      prefix: -r
  - id: gmt_file
    type: File
    doc: The pathway annotation in GMT format.
    inputBinding:
      position: 101
      prefix: -g
  - id: reverse_value
    type:
      - 'null'
      - boolean
    doc: Reverse the order of the gene.
    inputBinding:
      position: 101
      prefix: -e
  - id: sort_byp
    type:
      - 'null'
      - boolean
    doc: Sort the pathways by p value.
    inputBinding:
      position: 101
      prefix: -s
  - id: score_column
    type:
      - 'null'
      - int
    doc: The column for gene scores. If you just want to use the ranking of the
      gene (located at the 1st column), use 0. The column number starts from 0.
      Default 0.
    inputBinding:
      position: 101
      prefix: -c
  - id: perm_time
    type:
      - 'null'
      - int
    doc: Permutations, default 1000.
    inputBinding:
      position: 101
      prefix: -p
  - id: pathway_name
    type:
      - 'null'
      - string
    doc: Name of the pathway to be tested. If not found, will test all pathways.
    inputBinding:
      position: 101
      prefix: -n
  - id: output_file
    type:
      - 'null'
      - string
    doc: The name of the output file. Use - to print to standard output.
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - File
    doc: Pathway enrichment result
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck_mageckGSEA.out
