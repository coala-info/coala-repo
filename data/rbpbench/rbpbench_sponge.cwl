cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbpbench
  - sponge
label: rbpbench_sponge
doc: "Identify sponge transcripts based on regex matches.\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: allow_overlaps
    type:
      - 'null'
      - boolean
    doc: 'Allow overlapping regex hits. By default, search continues +1 after regex
      hit end position (i.e., not overlapping). NOTE that if --regex is structure
      pattern, search is currently always overlapping (default: False)'
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
    inputBinding:
      position: 101
      prefix: --chr-id-style
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file with transcript sequences to check for --regex 
      matches, to identifiy sponge transcripts (i.e. sequences with high amounts
      of regex hits per kilo base (kb) length). Note that sequence IDs have to 
      be unique. Also note that either --fasta or --gtf + --genome need to be 
      supplied, in order to get transcript sequences for sponge testing
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
      transcript sequences to check for sponge effects. Note that only features 
      on standard chromosomes (1,2,..,X,Y,MT) are currently used for annotation
    inputBinding:
      position: 101
      prefix: --gtf
  - id: min_hit_count
    type:
      - 'null'
      - int
    doc: 'Minimum regex hit count for a transcript to be included in percentile calculation
      and output table (default: 0)'
    inputBinding:
      position: 101
      prefix: --min-hit-count
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: 'Minimum sequence length required for input transcript sequences to be included
      in search (default: False)'
    inputBinding:
      position: 101
      prefix: --min-seq-len
  - id: min_spacer_len
    type:
      - 'null'
      - int
    doc: Minimum spacer length between regex hits. By default 0, i.e., hits can 
      also be adjacent. Note that setting --min-spacer to > 0 also sets 
      --allow-overlaps
    inputBinding:
      position: 101
      prefix: --min-spacer-len
  - id: regex
    type: string
    doc: Specify regular expression (regex) DNA motif for which to look for 
      sponge transcripts, e.g. --regex AAACCC, --regex 'C[ACGT]AC[AC]' .. IUPAC 
      code is also supported, e.g. AAARN resol. Alternatively, supply structure 
      pattern, e.g. AA((((ARA))))AA or CC(((A...R)))CC with variable spacer
    inputBinding:
      position: 101
      prefix: --regex
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: 'Maximum GU (GT) base pair fraction to report structure pattern regex hits
      (default: 1.0)'
    inputBinding:
      position: 101
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: 'Minimum GC base pair fraction to report structure pattern regex hits (default:
      0.0)'
    inputBinding:
      position: 101
      prefix: --regex-min-gc
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: 'Maximum spacer length for structure pattern regex search (default: 200)'
    inputBinding:
      position: 101
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length for structure pattern regex search (default: 5)'
    inputBinding:
      position: 101
      prefix: --regex-spacer-min
  - id: select_mode
    type:
      - 'null'
      - int
    doc: "Define what to extract from GTF file, i.e., for which transcripts or parts
      of transcripts to extract sequences to use for sponge search. 1: use full transcripts
      from all genes (selecting one representative for each gene). 2: use only mRNA
      transcripts. 3: use only 3'UTR parts of mRNA transcripts (default: 1)"
    inputBinding:
      position: 101
      prefix: --select-mode
  - id: tr_list
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) to define which 
      transcripts to extract from --gtf (overrides representative transcript 
      selection, might not be compatible with --select-mode 2 or 3)
    inputBinding:
      position: 101
      prefix: --tr-list
outputs:
  - id: out
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
