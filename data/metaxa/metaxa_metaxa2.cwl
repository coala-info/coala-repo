cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2
label: metaxa_metaxa2
doc: "Metaxa2 is a tool for identification and taxonomic classification of small and
  large subunit rRNA sequences in metagenomes and other sequence data sets.\n\nTool
  homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: classification_only
    type:
      - 'null'
      - boolean
    doc: Run only the classification part of Metaxa2, without prior extraction
    inputBinding:
      position: 101
      prefix: -c
  - id: compression
    type:
      - 'null'
      - string
    doc: Specifies the format of the input file (f, a, auto, gzip, bzip, zip, 
      dsrc)
    inputBinding:
      position: 101
      prefix: -z
  - id: cpu
    type:
      - 'null'
      - int
    doc: The number of CPU threads to use
    inputBinding:
      position: 101
      prefix: --cpu
  - id: database
    type:
      - 'null'
      - string
    doc: The BLAST databased used for classification
    inputBinding:
      position: 101
      prefix: -d
  - id: date_stamp
    type:
      - 'null'
      - boolean
    doc: Adds a date and time stamp to the output directory
    inputBinding:
      position: 101
      prefix: --date
  - id: e_value_cutoff
    type:
      - 'null'
      - float
    doc: Domain E-value cutoff for a sequence to be included in the output
    inputBinding:
      position: 101
      prefix: -E
  - id: extraction_only
    type:
      - 'null'
      - boolean
    doc: Run only the extraction part of Metaxa2, without classification
    inputBinding:
      position: 101
      prefix: -x
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: FASTA-format output of extracted rRNA sequences
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gene
    type:
      - 'null'
      - string
    doc: Specifies the barcoding gene Metaxa should look for (ssu, lsu, string)
    inputBinding:
      position: 101
      prefix: -g
  - id: hmmscan_base
    type:
      - 'null'
      - File
    doc: If the hmmscan has already been performed, this option can be used as 
      the base for the hmmscan output files
    inputBinding:
      position: 101
      prefix: --hmmscan
  - id: ignore_paired_read
    type:
      - 'null'
      - boolean
    doc: Do not discard the entire pair if only one of the reads is of bad 
      quality
    inputBinding:
      position: 101
      prefix: --ignore_paired_read
  - id: input
    type: File
    doc: DNA FASTA or FASTQ input file to investigate
    inputBinding:
      position: 101
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: Specifies the format of the input file (a, auto, f, fasta, q, fastq, p,
      paired-end, pa, paired-fasta)
    inputBinding:
      position: 101
      prefix: --format
  - id: matches_to_consider
    type:
      - 'null'
      - int
    doc: Number of sequence matches to consider for classification
    inputBinding:
      position: 101
      prefix: -M
  - id: min_domains
    type:
      - 'null'
      - int
    doc: The minimal number of domains that must match a sequence before it is 
      included
    inputBinding:
      position: 101
      prefix: -N
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality value for basecalling
    inputBinding:
      position: 101
      prefix: -q
  - id: mode
    type:
      - 'null'
      - string
    doc: Controls the Metaxa2 operating mode (m, metagenome, g, genome, a, auto)
    inputBinding:
      position: 101
      prefix: --mode
  - id: multi_thread
    type:
      - 'null'
      - boolean
    doc: Multi-thread the HMMER-search
    inputBinding:
      position: 101
      prefix: --multi_thread
  - id: pair_distance
    type:
      - 'null'
      - int
    doc: Specifies the distance between the sequence pairs
    inputBinding:
      position: 101
      prefix: --distance
  - id: pairfile
    type:
      - 'null'
      - File
    doc: DNA FASTQ file containing the pairs to the sequences in the input file
    inputBinding:
      position: 101
      prefix: --pairfile
  - id: profile_dir
    type:
      - 'null'
      - Directory
    doc: A path to a directory of HMM-profile collections representing rRNA 
      conserved regions
    inputBinding:
      position: 101
      prefix: -p
  - id: profile_set
    type:
      - 'null'
      - string
    doc: 'Profile set to use for the search (comma-separated: b, bacteria, a, archaea,
      e, eukaryota, m, mitochondrial, c, chloroplast, A, all, o, other)'
    inputBinding:
      position: 101
      prefix: -t
  - id: quality_filter
    type:
      - 'null'
      - boolean
    doc: Filter out low-quality reads (below specified -q value)
    inputBinding:
      position: 101
      prefix: --quality_filter
  - id: quality_percent
    type:
      - 'null'
      - int
    doc: Percentage of low-quality (below -q value) accepted before 
      filtering/trimming
    inputBinding:
      position: 101
      prefix: --quality_percent
  - id: quality_trim
    type:
      - 'null'
      - boolean
    doc: Trim away ends of low quality (below -q value)
    inputBinding:
      position: 101
      prefix: --quality_trim
  - id: read1
    type:
      - 'null'
      - File
    doc: DNA FASTQ input file containing the first reads in the read pairs to 
      investigate
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type:
      - 'null'
      - File
    doc: DNA FASTQ input file containing the second reads in the pairs to 
      investigate
    inputBinding:
      position: 101
      prefix: '-2'
  - id: reliability_cutoff
    type:
      - 'null'
      - float
    doc: Reliability cutoff for taxonomic classification
    inputBinding:
      position: 101
      prefix: -R
  - id: reset_db
    type:
      - 'null'
      - boolean
    doc: Rebuilds the HMM database
    inputBinding:
      position: 101
      prefix: --reset
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: Domain score cutoff for a sequence to be included in the output
    inputBinding:
      position: 101
      prefix: -S
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Supresses printing progress info to stderr
    inputBinding:
      position: 101
      prefix: --silent
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Summary of results output
    inputBinding:
      position: 101
      prefix: --summary
  - id: taxonomic_cutoffs
    type:
      - 'null'
      - string
    doc: Sets the percent identity cutoff to be classified at a certain 
      taxonomic level (comma-separated values)
    inputBinding:
      position: 101
      prefix: -T
  - id: taxonomy_output
    type:
      - 'null'
      - boolean
    doc: Table format output of probable taxonomic origin for sequences
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Custom directory to put the temporary files in
    inputBinding:
      position: 101
      prefix: --temp
  - id: ublast
    type:
      - 'null'
      - boolean
    doc: Runs the Ublast algorithm instead of Usearch algorithm
    inputBinding:
      position: 101
      prefix: --ublast
  - id: use_blast_plus
    type:
      - 'null'
      - boolean
    doc: Runs blast search through blast+ instead of the legacy blastall engine
    inputBinding:
      position: 101
      prefix: --plus
  - id: usearch_bin
    type:
      - 'null'
      - File
    doc: Specifies the location of the Usearch binary to be used
    inputBinding:
      position: 101
      prefix: --usearch_bin
  - id: usearch_version
    type:
      - 'null'
      - string
    doc: Runs usearch instead of blast, specify version
    inputBinding:
      position: 101
      prefix: --usearch
outputs:
  - id: output_base
    type: File
    doc: Base for the names of output file(s)
    outputBinding:
      glob: $(inputs.output_base)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
