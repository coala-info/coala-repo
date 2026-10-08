cwlVersion: v1.2
class: CommandLineTool
baseCommand: [gmvalue, contig]
label: gmcloser_gmvalue_contig
doc: "GMvalue ver. 1.3: gmvalue contig\n\nTool homepage: https://sourceforge.net/projects/gmcloser/"
inputs:
  - id: query
    type: File
    doc: 'input contig fasta file (e.g., contig1.fa)'
    inputBinding:
      prefix: --query
  - id: ref
    type: File
    doc: 'input reference file (e.g., ref.fa)'
    inputBinding:
      prefix: --ref
  - id: prefix
    type: string
    doc: 'prefix name of output files'
    inputBinding:
      prefix: --prefix
  - id: min_id
    type: ['null', int]
    doc: 'minimum alignment identity (%) [default: 97]'
    inputBinding:
      prefix: --min_id
  - id: min_cov
    type: ['null', int]
    doc: 'minimum coverage (%) of query (contig) aligned to a reference [default: 99]'
    inputBinding:
      prefix: --min_cov
  - id: min_align
    type: ['null', int]
    doc: 'minimum alignment overlap length with the maximum allowable size of indels [default: 200]'
    inputBinding:
      prefix: --min_align
  - id: min_len
    type: ['null', int]
    doc: 'minimum contig length to be considered [default: 200]'
    inputBinding:
      prefix: --min_len
  - id: error_correct
    type: ['null', boolean]
    doc: 'output an error-corrected contig set [default: false]'
    inputBinding:
      prefix: --enable_out
  - id: nuc_len
    type: ['null', int]
    doc: 'minimum exact match length for specifying nucmer option -l [default: 30]'
    inputBinding:
      prefix: --nuc_len
  - id: max_indel
    type: ['null', int]
    doc: 'maximum allowable size of indels (or distance between break points of a local misassembly) [default: 100]'
    inputBinding:
      prefix: --max_indel
  - id: thread
    type: ['null', int]
    doc: 'number of threads to run [default: 1]'
    inputBinding:
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*.*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmcloser:1.6.2--0
stdout: gmvalue_contig.out
