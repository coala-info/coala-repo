cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2
label: metaxa_metaxa2
doc: "Metaxa2 identifies and classifies small and large subunit rRNA sequences in metagenomes and other sequence data sets.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input
    type: File
    doc: "DNA FASTA or FASTQ input file to investigate"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_base
    type: string
    doc: "Base for the names of output file(s)"
    inputBinding:
      position: 101
      prefix: -o
  - id: read1
    type: ['null', File]
    doc: "DNA FASTQ input file containing the first reads in the read pairs to investigate"
    inputBinding:
      position: 101
      prefix: "-1"
  - id: read2
    type: ['null', File]
    doc: "DNA FASTQ input file containing the second reads in the pairs to investigate"
    inputBinding:
      position: 101
      prefix: "-2"
  - id: input_format
    type: ['null', string]
    doc: "Format of the input file (a, auto, f, fasta, q, fastq, p, paired-end, pa, paired-fasta), default auto"
    inputBinding:
      position: 101
      prefix: -f
  - id: compression
    type: ['null', string]
    doc: "Compression of the input file (f, a, auto, gzip, bzip, zip, dsrc), default f (off)"
    inputBinding:
      position: 101
      prefix: -z
  - id: gene
    type: ['null', string]
    doc: "Barcoding gene Metaxa should look for (ssu, lsu, string), default ssu"
    inputBinding:
      position: 101
      prefix: -g
  - id: pairfile
    type: ['null', File]
    doc: "DNA FASTQ file containing the pairs to the sequences in the input file"
    inputBinding:
      position: 101
      prefix: --pairfile
  - id: format
    type: ['null', string]
    doc: "Format of the input file (a, auto, f, fasta, q, fastq, p, paired-end), default auto"
    inputBinding:
      position: 101
      prefix: --format
  - id: mode
    type: ['null', string]
    doc: "Operating mode (m, metagenome, g, genome, a, auto), default metagenome"
    inputBinding:
      position: 101
      prefix: --mode
  - id: extraction_only
    type: ['null', boolean]
    doc: "Run only the extraction part of Metaxa2, without classification (T or F), default F"
    inputBinding:
      position: 101
      prefix: -x
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: classification_only
    type: ['null', boolean]
    doc: "Run only the classification part of Metaxa2, without prior extraction (T or F), default F"
    inputBinding:
      position: 101
      prefix: -c
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: profile_dir
    type: ['null', Directory]
    doc: "Directory of HMM-profile collections representing rRNA conserved regions"
    inputBinding:
      position: 101
      prefix: -p
  - id: database
    type: ['null', string]
    doc: "The BLAST database used for classification, default is in the same directory as metaxa itself"
    inputBinding:
      position: 101
      prefix: -d
  - id: hmmscan
    type: ['null', string]
    doc: "Base of existing hmmscan output files; the hmmscan step is then skipped (a DNA FASTA file must still be given)"
    inputBinding:
      position: 101
      prefix: --hmmscan
  - id: date_stamp
    type: ['null', boolean]
    doc: "Add a date and time stamp to the output directory (T or F), default F"
    inputBinding:
      position: 101
      prefix: --date
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
  - id: reset_db
    type: ['null', boolean]
    doc: "Rebuild the HMM database (T or F), default F"
    inputBinding:
      position: 101
      prefix: --reset
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: temp_dir
    type: ['null', string]
    doc: "Custom directory for temporary files"
    inputBinding:
      position: 101
      prefix: --temp
  - id: min_quality
    type: ['null', int]
    doc: "Minimum quality value for basecalling, default 20"
    inputBinding:
      position: 101
      prefix: -q
  - id: quality_filter
    type: ['null', boolean]
    doc: "Filter out low-quality reads (T or F), default F"
    inputBinding:
      position: 101
      prefix: --quality_filter
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: quality_trim
    type: ['null', boolean]
    doc: "Trim away ends of low quality (T or F), default F"
    inputBinding:
      position: 101
      prefix: --quality_trim
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: quality_percent
    type: ['null', int]
    doc: "Percentage of low-quality bases accepted before filtering or trimming, default 10"
    inputBinding:
      position: 101
      prefix: --quality_percent
  - id: ignore_paired_read
    type: ['null', boolean]
    doc: "Do not discard the entire pair if only one of the reads is of bad quality (T or F), default T"
    inputBinding:
      position: 101
      prefix: --ignore_paired_read
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: pair_distance
    type: ['null', int]
    doc: "Distance between the sequence pairs, default 150"
    inputBinding:
      position: 101
      prefix: --distance
  - id: profile_set
    type: ['null', string]
    doc: "Profile set to use for the search, comma-separated (b, bacteria, a, archaea, e, eukaryota, m, mitochondrial, c, chloroplast, A, all, o, other), default all"
    inputBinding:
      position: 101
      prefix: -t
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
    doc: "Comma-separated percent identity cutoffs for Kingdom,Phylum,Class,Order,Family,Genus,Species (SSU default 0,60,70,75,85,90,97)"
    inputBinding:
      position: 101
      prefix: -T
  - id: extractor_points
    type: ['null', float]
    doc: "Number of points the Metaxa Extractor prediction is given, default equals -M"
    inputBinding:
      position: 101
      prefix: -H
  - id: selection_priority
    type: ['null', string]
    doc: "Priority when determining the origin of a sequence (score, domains, eval, sum), default score"
    inputBinding:
      position: 101
      prefix: --selection_priority
  - id: scoring_model
    type: ['null', string]
    doc: "Scoring model for classification (new, old), default new"
    inputBinding:
      position: 101
      prefix: --scoring_model
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
  - id: megablast
    type: ['null', boolean]
    doc: "Use megablast for classification, faster but less accurate (T or F), default F"
    inputBinding:
      position: 101
      prefix: --megablast
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
  - id: not_found
    type: ['null', boolean]
    doc: "Save a list of non-found entries (T or F), default F"
    inputBinding:
      position: 101
      prefix: --not_found
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: align
    type: ['null', string]
    doc: "Output alignments of BLAST matches to the query (a, all, u, uncertain, n, none), needs MAFFT, default none"
    inputBinding:
      position: 101
      prefix: --align
  - id: truncate
    type: ['null', boolean]
    doc: "Truncate the FASTA output to the putative rRNA sequence (T or F), default T"
    inputBinding:
      position: 101
      prefix: --truncate
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: guess_species
    type: ['null', boolean]
    doc: "Write a species guess to the FASTA definition line (T or F), deprecated, default F"
    inputBinding:
      position: 101
      prefix: --guess_species
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
stdout: metaxa_metaxa2.out
