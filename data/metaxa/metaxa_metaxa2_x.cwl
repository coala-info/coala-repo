cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_x
label: metaxa_metaxa2_x
doc: "Metaxa Extractor identifies barcoding genes (rRNA) in (meta)genomic data and extracts them.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input
    type: File
    doc: "DNA FASTA input file to investigate"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_base
    type: string
    doc: "Base for the names of output file(s)"
    inputBinding:
      position: 101
      prefix: -o
  - id: profile_dir
    type: ['null', Directory]
    doc: "Directory of HMM-profile collections representing rRNA conserved regions"
    inputBinding:
      position: 101
      prefix: -p
  - id: hmmsearch
    type: ['null', string]
    doc: "Base of existing hmmsearch output files; the hmmsearch step is then skipped (a DNA FASTA file must still be given)"
    inputBinding:
      position: 101
      prefix: --hmmsearch
  - id: date_stamp
    type: ['null', boolean]
    doc: "Add a date and time stamp to the output directory (T or F), default F"
    inputBinding:
      position: 101
      prefix: --date
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: reset_db
    type: ['null', boolean]
    doc: "Rebuild the HMM database (T or F), default F"
    inputBinding:
      position: 101
      prefix: --reset
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: profile_set
    type: ['null', string]
    doc: "Profile set to use, comma-separated (b, bacteria, a, archaea, e, eukaryota, m, mitochondrial, c, chloroplast, A, all, o, other), default all"
    inputBinding:
      position: 101
      prefix: -t
  - id: gene
    type: ['null', string]
    doc: "Barcoding gene (ssu, lsu, string), default ssu"
    inputBinding:
      position: 101
      prefix: -g
  - id: mode
    type: ['null', string]
    doc: "Operating mode (m, metagenome, g, genome, a, auto), default metagenome"
    inputBinding:
      position: 101
      prefix: --mode
  - id: e_value_cutoff
    type: ['null', float]
    doc: "Domain E-value cutoff for a sequence to be included in the output, default 1"
    inputBinding:
      position: 101
      prefix: -E
  - id: score_cutoff
    type: ['null', float]
    doc: "Domain score cutoff for a sequence to be included in the output, default 12"
    inputBinding:
      position: 101
      prefix: -S
  - id: min_domains
    type: ['null', int]
    doc: "Minimal number of domains that must match a sequence before it is included, default 2"
    inputBinding:
      position: 101
      prefix: -N
  - id: selection_priority
    type: ['null', string]
    doc: "Priority when determining the origin of a sequence (score, domains, eval, sum), default sum"
    inputBinding:
      position: 101
      prefix: --selection_priority
  - id: search_eval
    type: ['null', float]
    doc: "E-value cutoff of the HMMER search; cannot be used with --search_score"
    inputBinding:
      position: 101
      prefix: --search_eval
  - id: search_score
    type: ['null', float]
    doc: "Score cutoff of the HMMER search, default 0"
    inputBinding:
      position: 101
      prefix: --search_score
  - id: allow_single_domain
    type: ['null', string]
    doc: "Allow sequences that find only a single domain: e-value,score or F, default 1e-10,0"
    inputBinding:
      position: 101
      prefix: --allow_single_domain
  - id: allow_reorder
    type: ['null', boolean]
    doc: "Allow profiles to be in the wrong order on extracted sequences (T or F), default T"
    inputBinding:
      position: 101
      prefix: --allow_reorder
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: complement
    type: ['null', boolean]
    doc: "Check both DNA strands against the database (T or F), default T"
    inputBinding:
      position: 101
      prefix: --complement
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: cpu
    type: ['null', int]
    doc: "Number of CPU threads to use, default 1"
    inputBinding:
      position: 101
      prefix: --cpu
  - id: multi_thread
    type: ['null', boolean]
    doc: "Multi-thread the HMMER search (T or F)"
    inputBinding:
      position: 101
      prefix: --multi_thread
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: heuristics
    type: ['null', boolean]
    doc: "Use HMMER's heuristic filtering (T or F), default T"
    inputBinding:
      position: 101
      prefix: --heuristics
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: summary
    type: ['null', boolean]
    doc: "Summary of results output (T or F), default T"
    inputBinding:
      position: 101
      prefix: --summary
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: graphical
    type: ['null', boolean]
    doc: "Graphical output (T or F), default T"
    inputBinding:
      position: 101
      prefix: --graphical
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: fasta_output
    type: ['null', boolean]
    doc: "FASTA output of extracted rRNA sequences (T or F), default T"
    inputBinding:
      position: 101
      prefix: --fasta
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: table
    type: ['null', boolean]
    doc: "Table output of sequences containing probable rRNAs (T or F), default F"
    inputBinding:
      position: 101
      prefix: --table
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: not_found
    type: ['null', boolean]
    doc: "Save a list of non-found entries (T or F), default F"
    inputBinding:
      position: 101
      prefix: --not_found
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: truncate
    type: ['null', boolean]
    doc: "Truncate the FASTA output to the putative rRNA sequence (T or F), default T"
    inputBinding:
      position: 101
      prefix: --truncate
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: silent
    type: ['null', boolean]
    doc: "Suppress progress info on stderr (T or F), default F"
    inputBinding:
      position: 101
      prefix: --silent
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: graph_scale
    type: ['null', float]
    doc: "Scale of the graph output; zero shows a percentage view, default 0"
    inputBinding:
      position: 101
      prefix: --graph_scale
  - id: save_raw
    type: ['null', boolean]
    doc: "Keep all raw data of the searches (T or F), default F"
    inputBinding:
      position: 101
      prefix: --save_raw
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Files written with the output base name"
    outputBinding:
      glob: "$(inputs.output_base)*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_x.out
