cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbpbench
  - isocomp
label: rbpbench_isocomp
doc: "Check for differences in regex hit occurrences between transcript isoforms.\n\
  \nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: allow_overlaps
    type:
      - 'null'
      - boolean
    doc: 'Allow overlapping regex hits. By default, search continues +1 after regex
      hit end position (i.e., not overlapping). NOTE that if --regex is structure
      pattern, search is currently always overlapping (default: False)'
    default: false
    inputBinding:
      position: 101
      prefix: --allow-overlaps
  - id: chr_id_style
    type:
      - 'null'
      - int
    doc: 'Define to which chromosome ID style to convert chromosome IDs to. 1: do
      not change chromosome IDs. 2: convert to chr1,chr2,...,chrM style. 3: convert
      to 1,2,...,MT style (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --chr-id-style
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file with transcript sequences to check for --regex 
      matches. Note that sequence IDs have to be unique, and in format 
      >transcript_id,gene_id for isoform assignment. Also note that either 
      --fasta or --gtf + --genome need to be supplied
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genome
    type:
      - 'null'
      - File
    doc: 'Genomic sequences file (currently supported formats: FASTA)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: gtf
    type:
      - 'null'
      - File
    doc: Input GTF file with genomic region annotations. Used to extract 
      transcript sequences for isoform comparisons. NOTE that by default only 
      3'UTR sequences are compared / used for motif search (change via 
      --select-mode). Also note that only features on standard chromosomes 
      (1,2,..,X,Y,MT) are currently used for annotation
    inputBinding:
      position: 101
      prefix: --gtf
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: 'Minimum sequence length required for input transcript sequences to be included
      in search (default: False)'
    default: 'False'
    inputBinding:
      position: 101
      prefix: --min-seq-len
  - id: min_spacer_len
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length between regex hits. By default 0, i.e., hits can also
      be adjacent. Note that setting --min-spacer to > 0 also sets --allow-overlaps
      (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: --min-spacer-len
  - id: regex
    type: string
    doc: Specify regular expression (regex) DNA motif for which to check for 
      differences in hit occurrences between transcript isoforms, e.g. --regex 
      AAACCC, --regex 'C[ACGT]AC[AC]' .. IUPAC code is also supported, e.g. 
      AAARN resolves to AAA[AG][ACGT]. Alternatively, supply structure pattern, 
      e.g. AA((((ARA))))AA or CC(((A...R)))CC with variable spacer
    inputBinding:
      position: 101
      prefix: --regex
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: 'Maximum GU (GT) base pair fraction to report structure pattern regex hits
      (default: 1.0)'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: 'Minimum GC base pair fraction to report structure pattern regex hits (default:
      0.0)'
    default: 0.0
    inputBinding:
      position: 101
      prefix: --regex-min-gc
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: 'Maximum spacer length for structure pattern regex search (default: 200)'
    default: 200
    inputBinding:
      position: 101
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length for structure pattern regex search (default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: --regex-spacer-min
  - id: select_mode
    type:
      - 'null'
      - int
    doc: "Define what to extract from GTF file, i.e., for which transcripts or parts
      of transcripts to extract sequences to use for motif search and isoform comparison.
      1: use only 3'UTR parts of mRNA transcripts. 2: use only 5'UTR parts of mRNA
      transcripts. 3: use full mRNA transcripts (i.e., all mRNA transcripts from GTF).
      4: use full non-coding transcripts (i.e., no transcripts from protein-coding
      genes). 5: use full transcripts, coding AND non-coding (i.e., all transcripts
      from GTF!) (default: 1)"
    default: 1
    inputBinding:
      position: 101
      prefix: --select-mode
outputs:
  - id: out
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
