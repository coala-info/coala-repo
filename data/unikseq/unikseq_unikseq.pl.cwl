cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/unikseq.pl
label: unikseq_unikseq.pl
doc: "v2.0.0\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs:
  - id: ingroup_fasta
    type: File
    doc: ingroup FASTA
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length
    default: 25
    inputBinding:
      position: 101
      prefix: -k
  - id: leniency
    type:
      - 'null'
      - int
    doc: min. non-unique consecutive kmers allowed in outgroup
    default: 0
    inputBinding:
      position: 101
      prefix: -l
  - id: max_outgroup_entries
    type:
      - 'null'
      - float
    doc: max. [% entries] in outgroup tolerated to have a reference kmer
    default: 0 %
    inputBinding:
      position: 101
      prefix: -m
  - id: min_ingroup_proportion
    type:
      - 'null'
      - float
    doc: 'min. [-c 0:region average /-c 1: per position] proportion of ingroup entries'
    default: 0 %
    inputBinding:
      position: 101
      prefix: -p
  - id: min_reference_region_size
    type:
      - 'null'
      - int
    doc: min. reference FASTA region [size] (bp) to output
    default: 100 bp
    inputBinding:
      position: 101
      prefix: -s
  - id: min_unique_kmers
    type:
      - 'null'
      - float
    doc: min. [% unique] kmers in regions
    default: 90 %
    inputBinding:
      position: 101
      prefix: -u
  - id: outgroup_fasta
    type: File
    doc: outgroup FASTA
    inputBinding:
      position: 101
      prefix: -o
  - id: output_conserved_fasta
    type:
      - 'null'
      - boolean
    doc: output conserved FASTA regions between reference and ingroup entries
    default: '0'
    inputBinding:
      position: 101
      prefix: -c
  - id: output_first_t_bases
    type:
      - 'null'
      - int
    doc: print only first t bases in tsv output
    default: '[k]'
    inputBinding:
      position: 101
      prefix: -t
  - id: reference_fasta
    type: File
    doc: reference FASTA
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_unikseq.pl.out
