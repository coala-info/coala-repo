cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikseq.pl
label: unikseq_unikseq.pl
doc: "v2.0.0\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs:
  - id: ingroup_fasta
    type: File
    doc: ingroup FASTA
    inputBinding:
      position: 101
      prefix: -i
      valueFrom: $(self.basename)
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length
    inputBinding:
      position: 101
      prefix: -k
  - id: leniency
    type:
      - 'null'
      - int
    doc: min. non-unique consecutive kmers allowed in outgroup
    inputBinding:
      position: 101
      prefix: -l
  - id: max_outgroup_entries
    type:
      - 'null'
      - float
    doc: max. [% entries] in outgroup tolerated to have a reference kmer
    inputBinding:
      position: 101
      prefix: -m
  - id: min_ingroup_proportion
    type:
      - 'null'
      - float
    doc: 'min. [-c 0:region average /-c 1: per position] proportion of ingroup entries'
    inputBinding:
      position: 101
      prefix: -p
  - id: min_reference_region_size
    type:
      - 'null'
      - int
    doc: min. reference FASTA region [size] (bp) to output
    inputBinding:
      position: 101
      prefix: -s
  - id: min_unique_kmers
    type:
      - 'null'
      - float
    doc: min. [% unique] kmers in regions
    inputBinding:
      position: 101
      prefix: -u
  - id: outgroup_fasta
    type: File
    doc: outgroup FASTA
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: $(self.basename)
  - id: output_conserved_fasta
    type:
      - 'null'
      - int
    doc: output conserved FASTA regions between reference and ingroup entries (1 = yes, 0 = no [default])
    inputBinding:
      position: 101
      prefix: -c
  - id: output_first_t_bases
    type:
      - 'null'
      - int
    doc: print only first t bases in tsv output
    inputBinding:
      position: 101
      prefix: -t
  - id: reference_fasta
    type: File
    doc: reference FASTA
    inputBinding:
      position: 101
      prefix: -r
      valueFrom: $(self.basename)
  - id: output_tsv
    type:
      - 'null'
      - int
    doc: output tsv files (1 = yes, 0 = no [default])
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: unique_fasta
    type:
      - 'null'
      - type: array
        items: File
    outputBinding:
      glob: '*-unique.fa'
  - id: conserved_fasta
    type:
      - 'null'
      - type: array
        items: File
    outputBinding:
      glob: '*-conserved.fa'
  - id: bed_files
    type:
      - 'null'
      - type: array
        items: File
    outputBinding:
      glob: '*.bed'
  - id: log_files
    type:
      - 'null'
      - type: array
        items: File
    outputBinding:
      glob: '*.log'
  - id: kmer_tsv
    type:
      - 'null'
      - type: array
        items: File
    outputBinding:
      glob: '*Kmers.tsv'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_fasta)
      - $(inputs.ingroup_fasta)
      - $(inputs.outgroup_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_unikseq.pl.out
