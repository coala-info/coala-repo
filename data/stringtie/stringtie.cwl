cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringtie
label: stringtie
doc: "Assemble RNA-Seq alignments into potential transcripts and estimate their abundances.\n\nTool homepage: https://ccb.jhu.edu/software/stringtie"
inputs:
  - id: alignments
    type:
      type: array
      items: File
    doc: Sorted alignment file(s) (BAM/CRAM); with --mix the long read alignments must be the 2nd file
    inputBinding:
      position: 101
  - id: conservative
    type:
      - 'null'
      - boolean
    doc: conservative transcript assembly, same as -t -c 1.5 -f 0.05
    inputBinding:
      position: 1
      prefix: --conservative
  - id: mix
    type:
      - 'null'
      - boolean
    doc: both short and long read data alignments are provided (long read alignments must be the 2nd BAM/CRAM input file)
    inputBinding:
      position: 1
      prefix: --mix
  - id: rf
    type:
      - 'null'
      - boolean
    doc: assume stranded library fr-firststrand
    inputBinding:
      position: 1
      prefix: --rf
  - id: fr
    type:
      - 'null'
      - boolean
    doc: assume stranded library fr-secondstrand
    inputBinding:
      position: 1
      prefix: --fr
  - id: guide_gff
    type:
      - 'null'
      - File
    doc: reference annotation to use for guiding the assembly process (GTF/GFF)
    inputBinding:
      position: 1
      prefix: -G
  - id: ptf
    type:
      - 'null'
      - File
    doc: load point-features from a given 4 column feature file
    inputBinding:
      position: 1
      prefix: --ptf
  - id: label
    type:
      - 'null'
      - string
    doc: name prefix for output transcripts (default STRG)
    inputBinding:
      position: 1
      prefix: -l
  - id: min_iso_fraction
    type:
      - 'null'
      - float
    doc: minimum isoform fraction (default 0.01)
    inputBinding:
      position: 1
      prefix: -f
  - id: long_reads
    type:
      - 'null'
      - boolean
    doc: long reads processing; also enforces -s 1.5 -g 0
    inputBinding:
      position: 1
      prefix: -L
  - id: clean_collapse_only
    type:
      - 'null'
      - boolean
    doc: if long reads are provided, just clean and collapse the reads but do not assemble
    inputBinding:
      position: 1
      prefix: -R
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum assembled transcript length (default 200)
    inputBinding:
      position: 1
      prefix: -m
  - id: min_anchor_len
    type:
      - 'null'
      - int
    doc: minimum anchor length for junctions (default 10)
    inputBinding:
      position: 1
      prefix: -a
  - id: min_junction_cov
    type:
      - 'null'
      - float
    doc: minimum junction coverage (default 1)
    inputBinding:
      position: 1
      prefix: -j
  - id: disable_trimming
    type:
      - 'null'
      - boolean
    doc: disable trimming of predicted transcripts based on coverage
    inputBinding:
      position: 1
      prefix: -t
  - id: min_cov
    type:
      - 'null'
      - float
    doc: minimum reads per bp coverage to consider for multi-exon transcript (default 1)
    inputBinding:
      position: 1
      prefix: -c
  - id: min_single_exon_cov
    type:
      - 'null'
      - float
    doc: minimum reads per bp coverage to consider for single-exon transcript (default 4.75)
    inputBinding:
      position: 1
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose (log bundle processing details)
    inputBinding:
      position: 1
      prefix: -v
  - id: max_gap
    type:
      - 'null'
      - int
    doc: maximum gap allowed between read mappings (default 50)
    inputBinding:
      position: 1
      prefix: -g
  - id: multihit_fraction
    type:
      - 'null'
      - float
    doc: fraction of bundle allowed to be covered by multi-hit reads (default 1)
    inputBinding:
      position: 1
      prefix: -M
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to use (default 1)
    inputBinding:
      position: 1
      prefix: -p
  - id: non_polya
    type:
      - 'null'
      - boolean
    doc: use with non-polyA RNA-seq
    inputBinding:
      position: 1
      prefix: -N
  - id: nascent
    type:
      - 'null'
      - boolean
    doc: output nascent transcripts
    inputBinding:
      position: 1
      prefix: --nasc
  - id: err_margin
    type:
      - 'null'
      - int
    doc: define window around possibly erroneous splice sites from long reads to look out for correct splice sites (default 25)
    inputBinding:
      position: 1
      prefix: -E
  - id: ballgown
    type:
      - 'null'
      - boolean
    doc: enable output of Ballgown table files which will be created in the same directory as the output GTF (requires -G, -o recommended)
    inputBinding:
      position: 1
      prefix: -B
  - id: ballgown_dir
    type:
      - 'null'
      - string
    doc: enable output of Ballgown table files, created under the given directory path
    inputBinding:
      position: 1
      prefix: -b
  - id: estimate_only
    type:
      - 'null'
      - boolean
    doc: only estimate the abundance of given reference transcripts (requires -G)
    inputBinding:
      position: 1
      prefix: -e
  - id: viral
    type:
      - 'null'
      - boolean
    doc: only relevant for long reads from viral data where splice sites do not follow consensus
    inputBinding:
      position: 1
      prefix: --viral
  - id: exclude_seqids
    type:
      - 'null'
      - string
    doc: do not assemble any transcripts on the given reference sequence(s) (comma separated)
    inputBinding:
      position: 1
      prefix: -x
  - id: no_multimap_correction
    type:
      - 'null'
      - boolean
    doc: no multi-mapping correction
    inputBinding:
      position: 1
      prefix: -u
  - id: cram_ref
    type:
      - 'null'
      - File
    doc: reference genome FASTA file for CRAM input
    inputBinding:
      position: 1
      prefix: --cram-ref
  - id: output_gtf_path
    type: string
    doc: output path/file name for the assembled transcripts GTF
    inputBinding:
      position: 2
      prefix: -o
  - id: gene_abundance_path
    type:
      - 'null'
      - string
    doc: gene abundance estimation output file
    inputBinding:
      position: 2
      prefix: -A
outputs:
  - id: output_gtf
    type: File
    doc: Assembled transcripts GTF
    outputBinding:
      glob: $(inputs.output_gtf_path)
  - id: gene_abundance
    type:
      - 'null'
      - File
    doc: Gene abundance estimation table
    outputBinding:
      glob: $(inputs.gene_abundance_path)
  - id: ballgown_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Ballgown table files (*.ctab) written next to the output GTF or under the -b directory
    outputBinding:
      glob: "$(inputs.ballgown_dir ? inputs.ballgown_dir + '/*.ctab' : '*.ctab')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringtie:3.0.3--h29c0135_0
