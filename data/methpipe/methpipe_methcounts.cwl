cwlVersion: v1.2
class: CommandLineTool
baseCommand: methcounts
label: methpipe_methcounts
doc: "get methylation levels from mapped WGBS reads\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs:
  - id: mapped_reads
    type: File
    doc: mapped WGBS reads
    inputBinding:
      position: 1
  - id: chrom
    type: File
    doc: file or dir of chroms (FASTA format; .fa suffix)
    inputBinding:
      position: 102
      prefix: -chrom
  - id: cpg_only
    type:
      - 'null'
      - boolean
    doc: print only CpG context cytosines
    inputBinding:
      position: 102
      prefix: -cpg-only
  - id: suffix
    type:
      - 'null'
      - string
    doc: suffix of FASTA files (assumes -c specifies dir)
    inputBinding:
      position: 102
      prefix: -suffix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
