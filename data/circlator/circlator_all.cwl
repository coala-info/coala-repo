cwlVersion: v1.2
class: CommandLineTool
baseCommand: circlator all
label: circlator_all
doc: "Run mapreads, bam2reads, assemble, merge, clean, fixstart\n\nTool homepage:
  https://github.com/sanger-pathogens/circlator"
inputs:
  - id: assembly_fasta
    type: File
    doc: Name of original assembly
    inputBinding:
      position: 1
  - id: reads_fasta_q
    type: File
    doc: Name of corrected reads FASTA or FASTQ file
    inputBinding:
      position: 2
  - id: output_directory
    type: Directory
    doc: Name of output directory (must not already exist)
    inputBinding:
      position: 3
  - id: assemble_not_careful
    type:
      - 'null'
      - boolean
    doc: Do not use the --careful option with SPAdes (used by default)
    inputBinding:
      position: 104
      prefix: --assemble_not_careful
  - id: assemble_not_only_assembler
    type:
      - 'null'
      - boolean
    doc: 'Do not use the --assemble-only option with SPAdes (used by default). Important:
      with this option, the input reads must be in FASTQ format, otherwise SPAdes
      will crash because it needs quality scores to correct the reads.'
    inputBinding:
      position: 104
      prefix: --assemble_not_only_assembler
  - id: assemble_spades_k
    type:
      - 'null'
      - string
    doc: Comma separated list of kmers to use when running SPAdes. Max kmer is 
      127 and each kmer should be an odd integer
    default: 127,117,107,97,87,77
    inputBinding:
      position: 104
      prefix: --assemble_spades_k
  - id: assemble_spades_use_first
    type:
      - 'null'
      - boolean
    doc: Use the first successful SPAdes assembly. Default is to try all kmers 
      and use the assembly with the largest N50
    inputBinding:
      position: 104
      prefix: --assemble_spades_use_first
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler to use for reassemblies
    default: spades
    inputBinding:
      position: 104
      prefix: --assembler
  - id: b2r_discard_unmapped
    type:
      - 'null'
      - boolean
    doc: Use this to not keep unmapped reads
    inputBinding:
      position: 104
      prefix: --b2r_discard_unmapped
  - id: b2r_length_cutoff
    type:
      - 'null'
      - int
    doc: All reads mapped to contigs shorter than this will be kept
    default: 100000
    inputBinding:
      position: 104
      prefix: --b2r_length_cutoff
  - id: b2r_min_read_length
    type:
      - 'null'
      - int
    doc: Minimum length of read to output
    default: 250
    inputBinding:
      position: 104
      prefix: --b2r_min_read_length
  - id: b2r_only_contigs
    type:
      - 'null'
      - File
    doc: 'File of contig names (one per line). Only reads that map to these contigs
      are kept (and unmapped reads, unless --b2r_discard_unmapped is used). Note:
      the whole assembly is still used as a reference when mapping'
    inputBinding:
      position: 104
      prefix: --b2r_only_contigs
  - id: bwa_opts
    type:
      - 'null'
      - string
    doc: BWA options, in quotes
    default: -x pacbio
    inputBinding:
      position: 104
      prefix: --bwa_opts
  - id: clean_breaklen
    type:
      - 'null'
      - int
    doc: breaklen option used by nucmer
    default: 500
    inputBinding:
      position: 104
      prefix: --clean_breaklen
  - id: clean_diagdiff
    type:
      - 'null'
      - int
    doc: Nucmer diagdiff option
    default: 25
    inputBinding:
      position: 104
      prefix: --clean_diagdiff
  - id: clean_min_contig_length
    type:
      - 'null'
      - int
    doc: Contigs shorter than this are discarded (unless specified using --keep)
    default: 2000
    inputBinding:
      position: 104
      prefix: --clean_min_contig_length
  - id: clean_min_contig_percent
    type:
      - 'null'
      - float
    doc: If length of nucmer hit is at least this percentage of length of 
      contig, then contig is removed. (unless specified using --keep)
    default: 95.0
    inputBinding:
      position: 104
      prefix: --clean_min_contig_percent
  - id: clean_min_nucmer_id
    type:
      - 'null'
      - float
    doc: Nucmer minimum percent identity
    default: 95.0
    inputBinding:
      position: 104
      prefix: --clean_min_nucmer_id
  - id: clean_min_nucmer_length
    type:
      - 'null'
      - int
    doc: Minimum length of hit for nucmer to report
    default: 500
    inputBinding:
      position: 104
      prefix: --clean_min_nucmer_length
  - id: data_type
    type:
      - 'null'
      - string
    doc: String representing one of the 4 type of data analysed (only used for 
      Canu)
    default: pacbio-corrected
    inputBinding:
      position: 104
      prefix: --data_type
  - id: fixstart_min_id
    type:
      - 'null'
      - float
    doc: Minimum percent identity of promer match between contigs and gene(s) to
      use as start point
    default: 70.0
    inputBinding:
      position: 104
      prefix: --fixstart_min_id
  - id: fixstart_mincluster
    type:
      - 'null'
      - int
    doc: The -c|mincluster option of promer. If this option is used, it 
      overrides promer's default value
    inputBinding:
      position: 104
      prefix: --fixstart_mincluster
  - id: genes_fa
    type:
      - 'null'
      - File
    doc: FASTA file of genes to search for to use as start point. If this option
      is not used, a built-in set of dnaA genes is used
    inputBinding:
      position: 104
      prefix: --genes_fa
  - id: merge_breaklen
    type:
      - 'null'
      - int
    doc: breaklen option used by nucmer
    default: 500
    inputBinding:
      position: 104
      prefix: --merge_breaklen
  - id: merge_diagdiff
    type:
      - 'null'
      - int
    doc: Nucmer diagdiff option
    default: 25
    inputBinding:
      position: 104
      prefix: --merge_diagdiff
  - id: merge_min_id
    type:
      - 'null'
      - float
    doc: Nucmer minimum percent identity
    default: 95.0
    inputBinding:
      position: 104
      prefix: --merge_min_id
  - id: merge_min_length
    type:
      - 'null'
      - int
    doc: Minimum length of hit for nucmer to report
    default: 500
    inputBinding:
      position: 104
      prefix: --merge_min_length
  - id: merge_min_length_merge
    type:
      - 'null'
      - int
    doc: Minimum length of nucmer hit to use when merging
    default: 4000
    inputBinding:
      position: 104
      prefix: --merge_min_length_merge
  - id: merge_min_spades_circ_pc
    type:
      - 'null'
      - float
    doc: Min percent of contigs needed to be covered by nucmer hits to spades 
      circular contigs
    default: 95.0
    inputBinding:
      position: 104
      prefix: --merge_min_spades_circ_pc
  - id: merge_reassemble_end
    type:
      - 'null'
      - int
    doc: max distance allowed between nucmer hit and end of reassembly contig
    default: 1000
    inputBinding:
      position: 104
      prefix: --merge_reassemble_end
  - id: merge_ref_end
    type:
      - 'null'
      - int
    doc: max distance allowed between nucmer hit and end of input assembly 
      contig
    default: 15000
    inputBinding:
      position: 104
      prefix: --merge_ref_end
  - id: no_pair_merge
    type:
      - 'null'
      - boolean
    doc: Do not merge pairs of contigs when running merge task
    inputBinding:
      position: 104
      prefix: --no_pair_merge
  - id: split_all_reads
    type:
      - 'null'
      - boolean
    doc: By default, reads mapped to shorter contigs are left unchanged. This 
      option splits them into two, broken at the middle of the contig to try to 
      force circularization. May help if the assembler does not detect circular 
      contigs (eg canu)
    inputBinding:
      position: 104
      prefix: --split_all_reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
  - id: unchanged_code
    type:
      - 'null'
      - int
    doc: Code to return when the input assembly is not changed
    default: 0
    inputBinding:
      position: 104
      prefix: --unchanged_code
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_all.out
