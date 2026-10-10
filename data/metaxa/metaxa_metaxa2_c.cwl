cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_c
label: metaxa_metaxa2_c
doc: "Metaxa Classifier classifies predicted barcoding genes (rRNA sequences) taxonomically.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input
    type: File
    doc: "DNA FASTA input file of rRNA sequences to investigate"
    inputBinding:
      position: 101
      prefix: -i
      valueFrom: $(self.basename)
  - id: output_base
    type: string
    doc: "Base for the names of output file(s)"
    inputBinding:
      position: 101
      prefix: -o
  - id: database
    type: ['null', string]
    doc: "The BLAST database used for classification, default is in the same directory as metaxa itself"
    inputBinding:
      position: 101
      prefix: -d
  - id: date_stamp
    type: ['null', boolean]
    doc: "Add a date and time stamp to the output directory (T or F), default F"
    inputBinding:
      position: 101
      prefix: --date
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
  - id: matches_to_consider
    type: ['null', int]
    doc: "Number of sequence matches to consider for classification, default 5"
    inputBinding:
      position: 101
      prefix: -M
  - id: reliability_cutoff
    type: ['null', float]
    doc: "Reliability cutoff for taxonomic classification, default 75"
    inputBinding:
      position: 101
      prefix: -R
  - id: taxonomic_cutoffs
    type: ['null', string]
    doc: "Comma-separated percent identity cutoffs for Kingdom,Phylum,Class,Order,Family,Genus,Species (default 0,60,70,75,85,90,97)"
    inputBinding:
      position: 101
      prefix: -T
  - id: scoring_model
    type: ['null', string]
    doc: "Scoring model for classification (new, old), default new"
    inputBinding:
      position: 101
      prefix: --scoring_model
  - id: extractor_points
    type: ['null', float]
    doc: "Number of points the Metaxa Extractor prediction is given, default equals -M"
    inputBinding:
      position: 101
      prefix: -H
  - id: blast_eval
    type: ['null', float]
    doc: "E-value cutoff of the BLAST search, default 1e-5; cannot be used with --blast_score"
    inputBinding:
      position: 101
      prefix: --blast_eval
  - id: blast_score
    type: ['null', float]
    doc: "Score cutoff of the BLAST search"
    inputBinding:
      position: 101
      prefix: --blast_score
  - id: blast_wordsize
    type: ['null', int]
    doc: "Word size for the BLAST classification, default 14"
    inputBinding:
      position: 101
      prefix: --blast_wordsize
  - id: cpu
    type: ['null', int]
    doc: "Number of CPU threads to use, default 1"
    inputBinding:
      position: 101
      prefix: --cpu
  - id: megablast
    type: ['null', boolean]
    doc: "Use megablast for classification, faster but less accurate (T or F), default F"
    inputBinding:
      position: 101
      prefix: --megablast
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: use_blast_plus
    type: ['null', boolean]
    doc: "Run the blast search through blast+ instead of legacy blastall (T or F), default F"
    inputBinding:
      position: 101
      prefix: --plus
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: usearch_version
    type: ['null', string]
    doc: "Run usearch instead of blast; give the version, default off (0)"
    inputBinding:
      position: 101
      prefix: --usearch
  - id: usearch_bin
    type: ['null', File]
    doc: "Location of the Usearch binary, default 'usearch'"
    inputBinding:
      position: 101
      prefix: --usearch_bin
  - id: ublast
    type: ['null', boolean]
    doc: "Run the Ublast algorithm instead of the Usearch algorithm (T or F), default T"
    inputBinding:
      position: 101
      prefix: --ublast
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: reference
    type: ['null', File]
    doc: "FASTA file of reference sequences to be sent to a separate file in the analysis"
    inputBinding:
      position: 101
      prefix: --reference
  - id: ref_identity
    type: ['null', float]
    doc: "Sequence identity cutoff to be considered derived from a reference entry, default 99"
    inputBinding:
      position: 101
      prefix: --ref_identity
  - id: summary
    type: ['null', boolean]
    doc: "Summary of results output (T or F), default T"
    inputBinding:
      position: 101
      prefix: --summary
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: fasta_output
    type: ['null', boolean]
    doc: "FASTA output of extracted rRNA sequences (T or F), default T"
    inputBinding:
      position: 101
      prefix: --fasta
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: split_pairs
    type: ['null', boolean]
    doc: "Output the two read pairs separately (T or F), default F"
    inputBinding:
      position: 101
      prefix: --split_pairs
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: table
    type: ['null', boolean]
    doc: "Table output of sequences containing probable rRNAs (T or F), default F"
    inputBinding:
      position: 101
      prefix: --table
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: taxonomy_output
    type: ['null', boolean]
    doc: "Table output of probable taxonomic origin (T or F), default T"
    inputBinding:
      position: 101
      prefix: --taxonomy
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: reltax
    type: ['null', boolean]
    doc: "Output of taxonomic origin with reliability scores at each rank (T or F), default F"
    inputBinding:
      position: 101
      prefix: --reltax
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: taxlevel
    type: ['null', int]
    doc: "Force classification at a certain taxonomy level, default off (0)"
    inputBinding:
      position: 101
      prefix: --taxlevel
  - id: align
    type: ['null', string]
    doc: "Output alignments of BLAST matches to the query (a, all, u, uncertain, n, none), needs MAFFT, default none"
    inputBinding:
      position: 101
      prefix: --align
  - id: guess_species
    type: ['null', boolean]
    doc: "Write a species guess to the FASTA definition line (T or F), deprecated, default F"
    inputBinding:
      position: 101
      prefix: --guess_species
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: not_found
    type: ['null', boolean]
    doc: "Save a list of non-found entries (T or F), default F"
    inputBinding:
      position: 101
      prefix: --not_found
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: silent
    type: ['null', boolean]
    doc: "Suppress progress info on stderr (T or F), default F"
    inputBinding:
      position: 101
      prefix: --silent
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
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
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_c.out
