cwlVersion: v1.2
class: CommandLineTool
baseCommand: GMcloser
label: gmcloser
doc: "GMcloser ver. 1.5\n\nTool homepage: https://sourceforge.net/projects/gmcloser/"
inputs:
  - id: ad_score
    type:
      - 'null'
      - float
    doc: 'score to add to (subtract from) the standard threshold score for selection
      of correct contig-subcontig alignments (e.g., 1 or -1) [default: 0]'
    default: 0
    inputBinding:
      position: 101
      prefix: --ad_score
  - id: align_file
    type:
      - 'null'
      - File
    doc: Nucmer alignment file for query against target [optional]
    inputBinding:
      position: 101
      prefix: --align_file
  - id: alignq
    type:
      - 'null'
      - File
    doc: BLASTn alignment file for query against query [optional]
    inputBinding:
      position: 101
      prefix: --alignq
  - id: base_qual
    type:
      - 'null'
      - string
    doc: 'base call quality format of fastq read file; illumina (phred64) or sanger
      (phred33) [default: auto]'
    default: auto
    inputBinding:
      position: 101
      prefix: --base_qual
  - id: blast
    type:
      - 'null'
      - boolean
    doc: 'conduct alignment between target and query contigs with BLASTn [default:
      false] (Nucmer alignment by default)'
    default: false
    inputBinding:
      position: 101
      prefix: --blast
  - id: connect_subcon
    type:
      - 'null'
      - boolean
    doc: 'connect between gap-encompassing subcontig pairs with their original (not
      merged with query contigs) termini [default: false]'
    default: false
    inputBinding:
      position: 101
      prefix: --connect_subcon
  - id: extend
    type:
      - 'null'
      - boolean
    doc: 'extend scaffold temini with aligned query sequences [default: false] (When
      using long read query, this option is disabled in the current version)'
    default: false
    inputBinding:
      position: 101
      prefix: --extend
  - id: hetero
    type:
      - 'null'
      - boolean
    doc: 'heterozygosity factor (specify this if your sequenced genome is heterozygous
      (>0.2% difference of the haploid size)) [default: false]'
    default: false
    inputBinding:
      position: 101
      prefix: --hetero
  - id: insert
    type:
      - 'null'
      - int
    doc: 'average insert size of paired-end reads [>read_len <20001, default: 400]'
    default: 400
    inputBinding:
      position: 101
      prefix: --insert
  - id: iterate
    type:
      - 'null'
      - int
    doc: 'number of iteration [default: 3]'
    default: 3
    inputBinding:
      position: 101
      prefix: --iterate
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: 'query sequence file is a fasta file of long reads (PacBio reads must be
      error-corrected) [default: false] (alignment is peformed with blast)'
    default: false
    inputBinding:
      position: 101
      prefix: --long_read
  - id: lr_cov
    type:
      - 'null'
      - int
    doc: 'fold coverage of long reads for target scaffolds [default: auto ; automatically
      calculated by dividing a total length of query by a total length of target]'
    default: auto
    inputBinding:
      position: 101
      prefix: --lr_cov
  - id: max_indel
    type:
      - 'null'
      - int
    doc: 'maximum length of indel, observed in alignments between target subcontigs
      and query contigs. The alignments separated by the indel will be merged. [default:
      70]'
    default: 70
    inputBinding:
      position: 101
      prefix: --max_indel
  - id: max_qsc
    type:
      - 'null'
      - int
    doc: 'maximum alignment coverage (%) of query singletones for target subcontigs
      (query with >= INT is excluded from query singletone output) [default: 60]'
    default: 60
    inputBinding:
      position: 101
      prefix: --max_qsc
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: 'minimum length of gap, when spliting the target scaffold sequences into
      subcontigs  [>0, default: 1]'
    default: 1
    inputBinding:
      position: 101
      prefix: --min_gap_size
  - id: min_identity
    type:
      - 'null'
      - int
    doc: 'minimum overlap identity (%) to be filtered for Nucmer alignments. Alignments
      are selected by combination with -mm option. [95~100, default: 99]'
    default: 99
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: min_len_local
    type:
      - 'null'
      - int
    doc: 'minimum overlap length for merging between neighbor subcontigs with YASS
      aligner [>14, default: 20]'
    default: 20
    inputBinding:
      position: 101
      prefix: --min_len_local
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: 'minimum overlap length to be filtered for Nucmer alignments. Contig-alignments
      that satisfy both the values specified with -mm and -mi are selected, irrespective
      of any mapping rates of PE-reads. [>49, default: 300]'
    default: 300
    inputBinding:
      position: 101
      prefix: --min_match_len
  - id: min_qalign
    type:
      - 'null'
      - int
    doc: "minimum number of queries that are aligned to either 5'- or 3'-terminus
      of a target subcontig [default: 1]"
    default: 1
    inputBinding:
      position: 101
      prefix: --min_qalign
  - id: min_subcon
    type:
      - 'null'
      - int
    doc: 'minimum length of subcontigs, to be used for gapclosing [default: 100]'
    default: 100
    inputBinding:
      position: 101
      prefix: --min_subcon
  - id: nuc_len
    type:
      - 'null'
      - int
    doc: "nucmer exact match length, a value specified with '-l' option of the Nucmer
      aligner [default: auto, increased from 30 to 50 depending on the total contig
      length]"
    default: auto
    inputBinding:
      position: 101
      prefix: --nuc_len
  - id: prefix_out
    type: string
    doc: prefix name of output files
    inputBinding:
      position: 101
      prefix: --prefix_out
  - id: query_seq
    type: File
    doc: input query contig (or long-read) fasta file (e.g., contig.fa) (if long
      reads are used, -lr option must be specified)
    inputBinding:
      position: 101
      prefix: --query_seq
  - id: read_file
    type:
      - 'null'
      - type: array
        items: File
    doc: space-separated list of fastq or fasta files (or gzip compressed files)
      of paired-end reads (e.g., -r read_pe1.fq read_pe2.fq)
    inputBinding:
      position: 101
      prefix: --read_file
  - id: read_format
    type:
      - 'null'
      - string
    doc: 'fastq or fasta [default: fastq]'
    default: fastq
    inputBinding:
      position: 101
      prefix: --read_format
  - id: read_len
    type: int
    doc: read length of paired-end reads specified with the -r, -st, -sq, or -sd
      option (mean read length if read lengths are variable)
    inputBinding:
      position: 101
      prefix: --read_len
  - id: sam_dir
    type:
      - 'null'
      - Directory
    doc: path of directory (i.e., bowtie_align) containing sam alignment files 
      generated from a previous job with GMcloser (this can be used in place of 
      -st and -sq option)
    inputBinding:
      position: 101
      prefix: --sam_dir
  - id: sam_qalign
    type:
      - 'null'
      - type: array
        items: File
    doc: space-separated list of sam alignment file(s) for query contigs, 
      created in a single-end read alignment mode for paired-end reads (e.g., 
      -sa qPE1.sam qPE2.sam, for paired-end read files PE1.fq and PE2.fq)
    inputBinding:
      position: 101
      prefix: --sam_qalign
  - id: sam_talign
    type:
      - 'null'
      - type: array
        items: File
    doc: space-separated list of sam alignment file(s) for target scaffolds, 
      created in a single-end read alignment mode for paired-end reads (e.g., 
      -sa tPE1.sam tPE2.sam, for paired-end read files PE1.fq and PE2.fq)
    inputBinding:
      position: 101
      prefix: --sam_talign
  - id: sd_insert
    type:
      - 'null'
      - int
    doc: 'standard deviation of insert size of paired-end reads [default: 40]'
    default: 40
    inputBinding:
      position: 101
      prefix: --sd_insert
  - id: target_scaf
    type: File
    doc: input target scaffold fasta file (e.g., scaf.fa)
    inputBinding:
      position: 101
      prefix: --target_scaf
  - id: thread
    type:
      - 'null'
      - int
    doc: 'number of threads (for machines with multiple processors), enabling all
      the alignment processes in parallel [default: 5]'
    default: 5
    inputBinding:
      position: 101
      prefix: --thread
  - id: thread_connect
    type:
      - 'null'
      - int
    doc: 'number of threads (for machines with multiple processors), enabling the
      subcontig-connection process in parallel [default: number specified with --thread]'
    default: number specified with --thread
    inputBinding:
      position: 101
      prefix: --thread_connect
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmcloser:1.6.2--0
stdout: gmcloser.out
