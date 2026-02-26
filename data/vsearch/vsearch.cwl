cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsearch
label: vsearch
doc: "VSEARCH: a versatile open source tool for metagenomics\n\nTool homepage: https://github.com/torognes/vsearch"
inputs:
  - id: abskew
    type:
      - 'null'
      - float
    doc: minimum abundance ratio
    default: 1.0, 2.0, 16.0 for uchime3
    inputBinding:
      position: 101
      prefix: --abskew
  - id: acceptall
    type:
      - 'null'
      - boolean
    doc: output all pairwise alignments
    inputBinding:
      position: 101
      prefix: --acceptall
  - id: alignwidth
    type:
      - 'null'
      - int
    doc: width of alignments in alignment output file
    default: 60
    inputBinding:
      position: 101
      prefix: --alignwidth
  - id: alignwidth
    type:
      - 'null'
      - int
    doc: width of alignment in uchimealn output
    default: 80
    inputBinding:
      position: 101
      prefix: --alignwidth
  - id: allpairs_global
    type:
      - 'null'
      - File
    doc: perform global alignment of all sequence pairs
    inputBinding:
      position: 101
      prefix: --allpairs_global
  - id: alnout
    type:
      - 'null'
      - File
    doc: output chimera alignments to file
    inputBinding:
      position: 101
      prefix: --alnout
  - id: alnout
    type:
      - 'null'
      - File
    doc: filename for human-readable alignment output
    inputBinding:
      position: 101
      prefix: --alnout
  - id: alnout
    type:
      - 'null'
      - File
    doc: filename for human-readable alignment output
    inputBinding:
      position: 101
      prefix: --alnout
  - id: biomout
    type:
      - 'null'
      - File
    doc: filename for OTU table output in biom 1.0 format
    inputBinding:
      position: 101
      prefix: --biomout
  - id: biomout
    type:
      - 'null'
      - File
    doc: filename for OTU table output in biom 1.0 format
    inputBinding:
      position: 101
      prefix: --biomout
  - id: blast6out
    type:
      - 'null'
      - File
    doc: filename for blast-like tab-separated output
    inputBinding:
      position: 101
      prefix: --blast6out
  - id: borderline
    type:
      - 'null'
      - File
    doc: output borderline chimeric sequences to file
    inputBinding:
      position: 101
      prefix: --borderline
  - id: bzip2_decompress
    type:
      - 'null'
      - boolean
    doc: decompress input with bzip2 (required if pipe)
    inputBinding:
      position: 101
      prefix: --bzip2_decompress
  - id: centroids
    type:
      - 'null'
      - File
    doc: output centroid sequences to FASTA file
    inputBinding:
      position: 101
      prefix: --centroids
  - id: chimeras
    type:
      - 'null'
      - File
    doc: output chimeric sequences to file
    inputBinding:
      position: 101
      prefix: --chimeras
  - id: chimeras
    type:
      - 'null'
      - File
    doc: output chimeric sequences to file
    inputBinding:
      position: 101
      prefix: --chimeras
  - id: chimeras_denovo
    type:
      - 'null'
      - File
    doc: detect chimeras de novo in long exact sequences
    inputBinding:
      position: 101
      prefix: --chimeras_denovo
  - id: chimeras_diff_pct
    type:
      - 'null'
      - float
    doc: mismatch % allowed in each chimeric region
    default: 0.0
    inputBinding:
      position: 101
      prefix: --chimeras_diff_pct
  - id: chimeras_length_min
    type:
      - 'null'
      - int
    doc: minimum length of each chimeric region
    default: 10
    inputBinding:
      position: 101
      prefix: --chimeras_length_min
  - id: chimeras_parents_max
    type:
      - 'null'
      - int
    doc: maximum number of parent sequences
    default: 3
    inputBinding:
      position: 101
      prefix: --chimeras_parents_max
  - id: chimeras_parts
    type:
      - 'null'
      - int
    doc: number of parts to divide sequences
    default: length/100
    inputBinding:
      position: 101
      prefix: --chimeras_parts
  - id: cluster_fast
    type:
      - 'null'
      - File
    doc: cluster sequences after sorting by length
    inputBinding:
      position: 101
      prefix: --cluster_fast
  - id: cluster_size
    type:
      - 'null'
      - File
    doc: cluster sequences after sorting by abundance
    inputBinding:
      position: 101
      prefix: --cluster_size
  - id: cluster_smallmem
    type:
      - 'null'
      - File
    doc: cluster already sorted sequences (see -usersort)
    inputBinding:
      position: 101
      prefix: --cluster_smallmem
  - id: cluster_unoise
    type:
      - 'null'
      - File
    doc: denoise Illumina amplicon reads
    inputBinding:
      position: 101
      prefix: --cluster_unoise
  - id: clusterout_id
    type:
      - 'null'
      - boolean
    doc: add cluster id info to consout and profile files
    inputBinding:
      position: 101
      prefix: --clusterout_id
  - id: clusterout_sort
    type:
      - 'null'
      - boolean
    doc: order msaout, consout, profile by decr abundance
    inputBinding:
      position: 101
      prefix: --clusterout_sort
  - id: clusters
    type:
      - 'null'
      - string
    doc: output each cluster to a separate FASTA file
    inputBinding:
      position: 101
      prefix: --clusters
  - id: cons_truncate
    type:
      - 'null'
      - boolean
    doc: do not ignore terminal gaps in MSA for consensus
    inputBinding:
      position: 101
      prefix: --cons_truncate
  - id: consout
    type:
      - 'null'
      - File
    doc: output cluster consensus sequences to FASTA file
    inputBinding:
      position: 101
      prefix: --consout
  - id: cut
    type:
      - 'null'
      - File
    doc: filename of FASTA formatted input sequences
    inputBinding:
      position: 101
      prefix: --cut
  - id: cut_pattern
    type:
      - 'null'
      - string
    doc: pattern to match with ^ and _ at cut sites
    inputBinding:
      position: 101
      prefix: --cut_pattern
  - id: db
    type:
      - 'null'
      - File
    doc: reference database for --uchime_ref
    inputBinding:
      position: 101
      prefix: --db
  - id: db
    type:
      - 'null'
      - File
    doc: database of sequences in correct orientation
    inputBinding:
      position: 101
      prefix: --db
  - id: db
    type:
      - 'null'
      - File
    doc: FASTA or UDB database (only FASTA for search_exact)
    inputBinding:
      position: 101
      prefix: --db
  - id: db
    type:
      - 'null'
      - File
    doc: taxonomic reference db in given FASTA or UDB file
    inputBinding:
      position: 101
      prefix: --db
  - id: dbmask
    type:
      - 'null'
      - string
    doc: mask db seqs with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --dbmask
  - id: dbmask
    type:
      - 'null'
      - string
    doc: mask db with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --dbmask
  - id: dbmask
    type:
      - 'null'
      - string
    doc: mask db with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --dbmask
  - id: dbmatched
    type:
      - 'null'
      - File
    doc: FASTA file for matching database sequences
    inputBinding:
      position: 101
      prefix: --dbmatched
  - id: dbnotmatched
    type:
      - 'null'
      - File
    doc: FASTA file for non-matching database sequences
    inputBinding:
      position: 101
      prefix: --dbnotmatched
  - id: derep_fulllength
    type:
      - 'null'
      - File
    doc: dereplicate sequences in the given FASTA file
    inputBinding:
      position: 101
      prefix: --derep_fulllength
  - id: derep_id
    type:
      - 'null'
      - File
    doc: dereplicate using both identifiers and sequences
    inputBinding:
      position: 101
      prefix: --derep_id
  - id: derep_prefix
    type:
      - 'null'
      - File
    doc: dereplicate sequences in file based on prefixes
    inputBinding:
      position: 101
      prefix: --derep_prefix
  - id: derep_smallmem
    type:
      - 'null'
      - File
    doc: dereplicate sequences in file using less memory
    inputBinding:
      position: 101
      prefix: --derep_smallmem
  - id: dn
    type:
      - 'null'
      - float
    doc: "'no' vote pseudo-count"
    default: 1.4
    inputBinding:
      position: 101
      prefix: --dn
  - id: ee_cutoffs
    type:
      - 'null'
      - string
    doc: fastq_eestats2 expected error cutoffs
    default: 0.5,1,2
    inputBinding:
      position: 101
      prefix: --ee_cutoffs
  - id: eeout
    type:
      - 'null'
      - boolean
    doc: include expected errors in output
    inputBinding:
      position: 101
      prefix: --eeout
  - id: eetabbedout
    type:
      - 'null'
      - File
    doc: output error statistics to specified file
    inputBinding:
      position: 101
      prefix: --eetabbedout
  - id: fasta2fastq
    type:
      - 'null'
      - File
    doc: convert from FASTA to FASTQ, fake quality scores
    inputBinding:
      position: 101
      prefix: --fasta2fastq
  - id: fasta_score
    type:
      - 'null'
      - boolean
    doc: include chimera score in FASTA output
    inputBinding:
      position: 101
      prefix: --fasta_score
  - id: fasta_width
    type:
      - 'null'
      - int
    doc: width of FASTA seq lines, 0 for no wrap
    default: 80
    inputBinding:
      position: 101
      prefix: --fasta_width
  - id: fastaout
    type:
      - 'null'
      - File
    doc: output FASTA file (for fastx_uniques)
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: output to specified FASTA file
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: FASTA output filename for oriented sequences
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: FASTA output filename for joined sequences
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: FASTA output filename for merged sequences
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: FASTA filename for fragments on forward strand
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: FASTA output filename
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: output subsampled sequences to FASTA file
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout
    type:
      - 'null'
      - File
    doc: FASTA filename for passed sequences
    inputBinding:
      position: 101
      prefix: --fastaout
  - id: fastaout_discarded
    type:
      - 'null'
      - File
    doc: FASTA filename for non-matching sequences
    inputBinding:
      position: 101
      prefix: --fastaout_discarded
  - id: fastaout_discarded
    type:
      - 'null'
      - File
    doc: output non-subsampled sequences to FASTA file
    inputBinding:
      position: 101
      prefix: --fastaout_discarded
  - id: fastaout_discarded
    type:
      - 'null'
      - File
    doc: FASTA filename for discarded sequences
    inputBinding:
      position: 101
      prefix: --fastaout_discarded
  - id: fastaout_discarded_rev
    type:
      - 'null'
      - File
    doc: FASTA filename for non-matching, reverse compl.
    inputBinding:
      position: 101
      prefix: --fastaout_discarded_rev
  - id: fastaout_discarded_rev
    type:
      - 'null'
      - File
    doc: FASTA filename for discarded reverse sequences
    inputBinding:
      position: 101
      prefix: --fastaout_discarded_rev
  - id: fastaout_notmerged_fwd
    type:
      - 'null'
      - File
    doc: FASTA filename for non-merged forward sequences
    inputBinding:
      position: 101
      prefix: --fastaout_notmerged_fwd
  - id: fastaout_notmerged_rev
    type:
      - 'null'
      - File
    doc: FASTA filename for non-merged reverse sequences
    inputBinding:
      position: 101
      prefix: --fastaout_notmerged_rev
  - id: fastaout_rev
    type:
      - 'null'
      - File
    doc: FASTA filename for fragments on reverse strand
    inputBinding:
      position: 101
      prefix: --fastaout_rev
  - id: fastaout_rev
    type:
      - 'null'
      - File
    doc: FASTA filename for passed reverse sequences
    inputBinding:
      position: 101
      prefix: --fastaout_rev
  - id: fastapairs
    type:
      - 'null'
      - File
    doc: FASTA file with pairs of query and target
    inputBinding:
      position: 101
      prefix: --fastapairs
  - id: fastq_allowmergestagger
    type:
      - 'null'
      - boolean
    doc: allow merging of staggered reads
    inputBinding:
      position: 101
      prefix: --fastq_allowmergestagger
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_ascii
    type:
      - 'null'
      - int
    doc: FASTQ input quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_ascii
  - id: fastq_asciiout
    type:
      - 'null'
      - int
    doc: FASTQ output quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_asciiout
  - id: fastq_asciiout
    type:
      - 'null'
      - int
    doc: FASTQ output quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_asciiout
  - id: fastq_asciiout
    type:
      - 'null'
      - int
    doc: FASTQ output quality score ASCII base char
    default: 33
    inputBinding:
      position: 101
      prefix: --fastq_asciiout
  - id: fastq_chars
    type:
      - 'null'
      - File
    doc: analyse FASTQ file for version and quality range
    inputBinding:
      position: 101
      prefix: --fastq_chars
  - id: fastq_convert
    type:
      - 'null'
      - File
    doc: convert between FASTQ file formats
    inputBinding:
      position: 101
      prefix: --fastq_convert
  - id: fastq_eeout
    type:
      - 'null'
      - boolean
    doc: include expected errors (ee) in FASTQ output
    inputBinding:
      position: 101
      prefix: --fastq_eeout
  - id: fastq_eestats
    type:
      - 'null'
      - File
    doc: quality score and expected error statistics
    inputBinding:
      position: 101
      prefix: --fastq_eestats
  - id: fastq_eestats2
    type:
      - 'null'
      - File
    doc: expected error and length cutoff statistics
    inputBinding:
      position: 101
      prefix: --fastq_eestats2
  - id: fastq_filter
    type:
      - 'null'
      - File
    doc: trim and filter sequences in FASTQ file
    inputBinding:
      position: 101
      prefix: --fastq_filter
  - id: fastq_join
    type:
      - 'null'
      - File
    doc: join paired-end reads into one sequence with gap
    inputBinding:
      position: 101
      prefix: --fastq_join
  - id: fastq_maxdiffpct
    type:
      - 'null'
      - float
    doc: maximum percentage diff. bases in overlap
    default: 100.0
    inputBinding:
      position: 101
      prefix: --fastq_maxdiffpct
  - id: fastq_maxdiffs
    type:
      - 'null'
      - int
    doc: maximum number of different bases in overlap
    default: 10
    inputBinding:
      position: 101
      prefix: --fastq_maxdiffs
  - id: fastq_maxee
    type:
      - 'null'
      - float
    doc: maximum expected error value for merged sequence
    inputBinding:
      position: 101
      prefix: --fastq_maxee
  - id: fastq_maxee
    type:
      - 'null'
      - float
    doc: discard if expected error value is higher
    inputBinding:
      position: 101
      prefix: --fastq_maxee
  - id: fastq_maxee_rate
    type:
      - 'null'
      - float
    doc: discard if expected error rate is higher
    inputBinding:
      position: 101
      prefix: --fastq_maxee_rate
  - id: fastq_maxlen
    type:
      - 'null'
      - int
    doc: discard if length of sequence is longer
    inputBinding:
      position: 101
      prefix: --fastq_maxlen
  - id: fastq_maxmergelen
    type:
      - 'null'
      - int
    doc: maximum length of entire merged sequence
    inputBinding:
      position: 101
      prefix: --fastq_maxmergelen
  - id: fastq_maxns
    type:
      - 'null'
      - int
    doc: maximum number of N's
    inputBinding:
      position: 101
      prefix: --fastq_maxns
  - id: fastq_maxns
    type:
      - 'null'
      - int
    doc: discard if number of N's is higher
    inputBinding:
      position: 101
      prefix: --fastq_maxns
  - id: fastq_mergepairs
    type:
      - 'null'
      - File
    doc: merge paired-end reads into one sequence
    inputBinding:
      position: 101
      prefix: --fastq_mergepairs
  - id: fastq_minlen
    type:
      - 'null'
      - int
    doc: minimum input read length after truncation
    default: 1
    inputBinding:
      position: 101
      prefix: --fastq_minlen
  - id: fastq_minlen
    type:
      - 'null'
      - int
    doc: discard if length of sequence is shorter
    inputBinding:
      position: 101
      prefix: --fastq_minlen
  - id: fastq_minmergelen
    type:
      - 'null'
      - int
    doc: minimum length of entire merged sequence
    inputBinding:
      position: 101
      prefix: --fastq_minmergelen
  - id: fastq_minovlen
    type:
      - 'null'
      - int
    doc: minimum length of overlap between reads
    default: 10
    inputBinding:
      position: 101
      prefix: --fastq_minovlen
  - id: fastq_minqual
    type:
      - 'null'
      - int
    doc: discard if any base quality value lower
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_minqual
  - id: fastq_nostagger
    type:
      - 'null'
      - boolean
    doc: disallow merging of staggered reads (default)
    inputBinding:
      position: 101
      prefix: --fastq_nostagger
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmax
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ input
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmax
  - id: fastq_qmaxout
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ output
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmaxout
  - id: fastq_qmaxout
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ output
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmaxout
  - id: fastq_qmaxout
    type:
      - 'null'
      - int
    doc: fake quality score for FASTQ output
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmaxout
  - id: fastq_qmaxout
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ output
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmaxout
  - id: fastq_qmaxout
    type:
      - 'null'
      - int
    doc: maximum base quality value for FASTQ output
    default: 41
    inputBinding:
      position: 101
      prefix: --fastq_qmaxout
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qmin
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ input
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qmin
  - id: fastq_qminout
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ output
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qminout
  - id: fastq_qminout
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ output
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qminout
  - id: fastq_qminout
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ output
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qminout
  - id: fastq_qminout
    type:
      - 'null'
      - int
    doc: minimum base quality value for FASTQ output
    default: 0
    inputBinding:
      position: 101
      prefix: --fastq_qminout
  - id: fastq_stats
    type:
      - 'null'
      - File
    doc: report statistics on FASTQ file
    inputBinding:
      position: 101
      prefix: --fastq_stats
  - id: fastq_stripleft
    type:
      - 'null'
      - int
    doc: delete given number of bases from the 5' end
    inputBinding:
      position: 101
      prefix: --fastq_stripleft
  - id: fastq_stripright
    type:
      - 'null'
      - int
    doc: delete given number of bases from the 3' end
    inputBinding:
      position: 101
      prefix: --fastq_stripright
  - id: fastq_tail
    type:
      - 'null'
      - int
    doc: min length of tails to count for fastq_chars
    default: 4
    inputBinding:
      position: 101
      prefix: --fastq_tail
  - id: fastq_truncee
    type:
      - 'null'
      - float
    doc: truncate to given maximum expected error
    inputBinding:
      position: 101
      prefix: --fastq_truncee
  - id: fastq_truncee_rate
    type:
      - 'null'
      - float
    doc: truncate to given maximum expected error rate
    inputBinding:
      position: 101
      prefix: --fastq_truncee_rate
  - id: fastq_trunclen
    type:
      - 'null'
      - int
    doc: truncate to given length (discard if shorter)
    inputBinding:
      position: 101
      prefix: --fastq_trunclen
  - id: fastq_trunclen_keep
    type:
      - 'null'
      - int
    doc: truncate to given length (keep if shorter)
    inputBinding:
      position: 101
      prefix: --fastq_trunclen_keep
  - id: fastq_truncqual
    type:
      - 'null'
      - int
    doc: base quality value for truncation
    inputBinding:
      position: 101
      prefix: --fastq_truncqual
  - id: fastq_truncqual
    type:
      - 'null'
      - int
    doc: truncate to given minimum base quality
    inputBinding:
      position: 101
      prefix: --fastq_truncqual
  - id: fastqout
    type:
      - 'null'
      - File
    doc: output converted sequences to given FASTQ file
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: output FASTQ file (for fastx_uniques)
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ output filename for converted sequences
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ output filename for converted sequences
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: output to specified FASTQ file
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ output filenamr for oriented sequences
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ output filename for joined sequences
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ output filename for merged sequences
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ output filename
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: output subsampled sequences to FASTQ file
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout
    type:
      - 'null'
      - File
    doc: FASTQ filename for passed sequences
    inputBinding:
      position: 101
      prefix: --fastqout
  - id: fastqout_discarded
    type:
      - 'null'
      - File
    doc: output non-subsampled sequences to FASTQ file
    inputBinding:
      position: 101
      prefix: --fastqout_discarded
  - id: fastqout_discarded
    type:
      - 'null'
      - File
    doc: FASTQ filename for discarded sequences
    inputBinding:
      position: 101
      prefix: --fastqout_discarded
  - id: fastqout_discarded_rev
    type:
      - 'null'
      - File
    doc: FASTQ filename for discarded reverse sequences
    inputBinding:
      position: 101
      prefix: --fastqout_discarded_rev
  - id: fastqout_notmerged_fwd
    type:
      - 'null'
      - File
    doc: FASTQ filename for non-merged forward sequences
    inputBinding:
      position: 101
      prefix: --fastqout_notmerged_fwd
  - id: fastqout_notmerged_rev
    type:
      - 'null'
      - File
    doc: FASTQ filename for non-merged reverse sequences
    inputBinding:
      position: 101
      prefix: --fastqout_notmerged_rev
  - id: fastqout_rev
    type:
      - 'null'
      - File
    doc: FASTQ filename for passed reverse sequences
    inputBinding:
      position: 101
      prefix: --fastqout_rev
  - id: fastx_filter
    type:
      - 'null'
      - File
    doc: trim and filter sequences in FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --fastx_filter
  - id: fastx_mask
    type:
      - 'null'
      - File
    doc: mask sequences in the given FASTA or FASTQ file
    inputBinding:
      position: 101
      prefix: --fastx_mask
  - id: fastx_revcomp
    type:
      - 'null'
      - File
    doc: reverse-complement seqs in FASTA or FASTQ file
    inputBinding:
      position: 101
      prefix: --fastx_revcomp
  - id: fastx_subsample
    type:
      - 'null'
      - File
    doc: subsample sequences from given FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --fastx_subsample
  - id: fastx_uniques
    type:
      - 'null'
      - File
    doc: dereplicate sequences in the FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --fastx_uniques
  - id: fulldp
    type:
      - 'null'
      - boolean
    doc: full dynamic programming alignment (always on)
    inputBinding:
      position: 101
      prefix: --fulldp
  - id: gapext
    type:
      - 'null'
      - string
    doc: penalties for gap extension
    default: 2I/1E
    inputBinding:
      position: 101
      prefix: --gapext
  - id: gapopen
    type:
      - 'null'
      - string
    doc: penalties for gap opening
    default: 20I/2E
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gzip_decompress
    type:
      - 'null'
      - boolean
    doc: decompress input with gzip (required if pipe)
    inputBinding:
      position: 101
      prefix: --gzip_decompress
  - id: hardmask
    type:
      - 'null'
      - boolean
    doc: mask by replacing with N instead of lower case
    inputBinding:
      position: 101
      prefix: --hardmask
  - id: hardmask
    type:
      - 'null'
      - boolean
    doc: mask by replacing with N instead of lower case
    inputBinding:
      position: 101
      prefix: --hardmask
  - id: hardmask
    type:
      - 'null'
      - boolean
    doc: mask by replacing with N instead of lower case
    inputBinding:
      position: 101
      prefix: --hardmask
  - id: hardmask
    type:
      - 'null'
      - boolean
    doc: mask by replacing with N instead of lower case
    inputBinding:
      position: 101
      prefix: --hardmask
  - id: id
    type:
      - 'null'
      - float
    doc: 'reject if identity lower, accepted values: 0-1.0'
    inputBinding:
      position: 101
      prefix: --id
  - id: id
    type:
      - 'null'
      - float
    doc: reject if identity lower
    inputBinding:
      position: 101
      prefix: --id
  - id: iddef
    type:
      - 'null'
      - int
    doc: id definition, 0-4=CD-HIT,all,int,MBL,BLAST
    default: 2
    inputBinding:
      position: 101
      prefix: --iddef
  - id: iddef
    type:
      - 'null'
      - int
    doc: id definition, 0-4=CD-HIT,all,int,MBL,BLAST
    default: 2
    inputBinding:
      position: 101
      prefix: --iddef
  - id: idprefix
    type:
      - 'null'
      - int
    doc: reject if first n nucleotides do not match
    inputBinding:
      position: 101
      prefix: --idprefix
  - id: idsuffix
    type:
      - 'null'
      - int
    doc: reject if last n nucleotides do not match
    inputBinding:
      position: 101
      prefix: --idsuffix
  - id: join_padgap
    type:
      - 'null'
      - string
    doc: sequence string used for padding
    default: NNNNNNNN
    inputBinding:
      position: 101
      prefix: --join_padgap
  - id: join_padgapq
    type:
      - 'null'
      - string
    doc: quality string used for padding
    default: IIIIIIII
    inputBinding:
      position: 101
      prefix: --join_padgapq
  - id: label_suffix
    type:
      - 'null'
      - string
    doc: suffix to append to label of merged sequences
    inputBinding:
      position: 101
      prefix: --label_suffix
  - id: label_suffix
    type:
      - 'null'
      - string
    doc: label to append to identifier in the output
    inputBinding:
      position: 101
      prefix: --label_suffix
  - id: lca_cutoff
    type:
      - 'null'
      - float
    doc: fraction of matching hits required for LCA
    default: 1.0
    inputBinding:
      position: 101
      prefix: --lca_cutoff
  - id: lcaout
    type:
      - 'null'
      - File
    doc: output LCA of matching sequences to file
    inputBinding:
      position: 101
      prefix: --lcaout
  - id: leftjust
    type:
      - 'null'
      - boolean
    doc: reject if terminal gaps at alignment left end
    inputBinding:
      position: 101
      prefix: --leftjust
  - id: length_cutoffs
    type:
      - 'null'
      - string
    doc: fastq_eestats2 length (min,max,incr)
    default: 50,*,50
    inputBinding:
      position: 101
      prefix: --length_cutoffs
  - id: log
    type:
      - 'null'
      - File
    doc: write messages, timing and memory info to file
    inputBinding:
      position: 101
      prefix: --log
  - id: log
    type:
      - 'null'
      - File
    doc: output file for fastq_stats statistics
    inputBinding:
      position: 101
      prefix: --log
  - id: makeudb_usearch
    type:
      - 'null'
      - File
    doc: make UDB file from given FASTA file
    inputBinding:
      position: 101
      prefix: --makeudb_usearch
  - id: maskfasta
    type:
      - 'null'
      - File
    doc: mask sequences in the given FASTA file
    inputBinding:
      position: 101
      prefix: --maskfasta
  - id: match
    type:
      - 'null'
      - int
    doc: score for match
    default: 2
    inputBinding:
      position: 101
      prefix: --match
  - id: matched
    type:
      - 'null'
      - File
    doc: FASTA file for matching query sequences
    inputBinding:
      position: 101
      prefix: --matched
  - id: max_unmasked_pct
    type:
      - 'null'
      - float
    doc: max unmasked % of sequences to keep
    default: 100.0
    inputBinding:
      position: 101
      prefix: --max_unmasked_pct
  - id: maxaccepts
    type:
      - 'null'
      - int
    doc: number of hits to accept and show per strand
    default: 1
    inputBinding:
      position: 101
      prefix: --maxaccepts
  - id: maxdiffs
    type:
      - 'null'
      - int
    doc: reject if more substitutions or indels
    inputBinding:
      position: 101
      prefix: --maxdiffs
  - id: maxgaps
    type:
      - 'null'
      - int
    doc: reject if more indels
    inputBinding:
      position: 101
      prefix: --maxgaps
  - id: maxhits
    type:
      - 'null'
      - int
    doc: maximum number of hits to show
    default: unlimited
    inputBinding:
      position: 101
      prefix: --maxhits
  - id: maxid
    type:
      - 'null'
      - float
    doc: reject if identity higher
    inputBinding:
      position: 101
      prefix: --maxid
  - id: maxqsize
    type:
      - 'null'
      - int
    doc: reject if query abundance larger
    inputBinding:
      position: 101
      prefix: --maxqsize
  - id: maxqt
    type:
      - 'null'
      - float
    doc: reject if query/target length ratio higher
    inputBinding:
      position: 101
      prefix: --maxqt
  - id: maxrejects
    type:
      - 'null'
      - int
    doc: number of non-matching hits to consider
    default: 32
    inputBinding:
      position: 101
      prefix: --maxrejects
  - id: maxseqlength
    type:
      - 'null'
      - int
    doc: maximum sequence length
    default: 50000
    inputBinding:
      position: 101
      prefix: --maxseqlength
  - id: maxsize
    type:
      - 'null'
      - int
    doc: maximum abundance for sortbysize
    inputBinding:
      position: 101
      prefix: --maxsize
  - id: maxsize
    type:
      - 'null'
      - int
    doc: discard if abundance of sequence is above
    inputBinding:
      position: 101
      prefix: --maxsize
  - id: maxsizeratio
    type:
      - 'null'
      - float
    doc: reject if query/target abundance ratio higher
    inputBinding:
      position: 101
      prefix: --maxsizeratio
  - id: maxsl
    type:
      - 'null'
      - float
    doc: reject if shorter/longer length ratio higher
    inputBinding:
      position: 101
      prefix: --maxsl
  - id: maxsubs
    type:
      - 'null'
      - int
    doc: reject if more substitutions
    inputBinding:
      position: 101
      prefix: --maxsubs
  - id: maxuniquesize
    type:
      - 'null'
      - int
    doc: maximum abundance for output from dereplication
    inputBinding:
      position: 101
      prefix: --maxuniquesize
  - id: mid
    type:
      - 'null'
      - float
    doc: reject if percent identity lower, ignoring gaps
    inputBinding:
      position: 101
      prefix: --mid
  - id: min_unmasked_pct
    type:
      - 'null'
      - float
    doc: min unmasked % of sequences to keep
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min_unmasked_pct
  - id: mincols
    type:
      - 'null'
      - int
    doc: reject if alignment length shorter
    inputBinding:
      position: 101
      prefix: --mincols
  - id: mindiffs
    type:
      - 'null'
      - int
    doc: minimum number of differences in segment
    default: 3
    inputBinding:
      position: 101
      prefix: --mindiffs
  - id: mindiv
    type:
      - 'null'
      - float
    doc: minimum divergence from closest parent
    default: 0.8
    inputBinding:
      position: 101
      prefix: --mindiv
  - id: minh
    type:
      - 'null'
      - float
    doc: minimum score (ignored in uchime2/3)
    default: 0.28
    inputBinding:
      position: 101
      prefix: --minh
  - id: minqt
    type:
      - 'null'
      - float
    doc: reject if query/target length ratio lower
    inputBinding:
      position: 101
      prefix: --minqt
  - id: minseqlength
    type:
      - 'null'
      - int
    doc: 'min seq length (clust/derep/search: 32, other:1)'
    default: 32, other:1
    inputBinding:
      position: 101
      prefix: --minseqlength
  - id: minsize
    type:
      - 'null'
      - int
    doc: minimum abundance (unoise only)
    default: 8
    inputBinding:
      position: 101
      prefix: --minsize
  - id: minsize
    type:
      - 'null'
      - int
    doc: minimum abundance for sortbysize
    inputBinding:
      position: 101
      prefix: --minsize
  - id: minsize
    type:
      - 'null'
      - int
    doc: discard if abundance of sequence is below
    inputBinding:
      position: 101
      prefix: --minsize
  - id: minsizeratio
    type:
      - 'null'
      - float
    doc: reject if query/target abundance ratio lower
    inputBinding:
      position: 101
      prefix: --minsizeratio
  - id: minsl
    type:
      - 'null'
      - float
    doc: reject if shorter/longer length ratio lower
    inputBinding:
      position: 101
      prefix: --minsl
  - id: mintsize
    type:
      - 'null'
      - int
    doc: reject if target abundance lower
    inputBinding:
      position: 101
      prefix: --mintsize
  - id: minuniquesize
    type:
      - 'null'
      - int
    doc: minimum abundance for output from dereplication
    inputBinding:
      position: 101
      prefix: --minuniquesize
  - id: minwordmatches
    type:
      - 'null'
      - int
    doc: minimum number of word matches required
    default: 12
    inputBinding:
      position: 101
      prefix: --minwordmatches
  - id: mismatch
    type:
      - 'null'
      - int
    doc: score for mismatch
    default: -4
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: mothur_shared_out
    type:
      - 'null'
      - File
    doc: filename for OTU table output in mothur format
    inputBinding:
      position: 101
      prefix: --mothur_shared_out
  - id: mothur_shared_out
    type:
      - 'null'
      - File
    doc: filename for OTU table output in mothur format
    inputBinding:
      position: 101
      prefix: --mothur_shared_out
  - id: msaout
    type:
      - 'null'
      - File
    doc: output multiple seq. alignments to FASTA file
    inputBinding:
      position: 101
      prefix: --msaout
  - id: n_mismatch
    type:
      - 'null'
      - boolean
    doc: consider aligning with N's as mismatches
    inputBinding:
      position: 101
      prefix: --n_mismatch
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: do not show progress indicator
    inputBinding:
      position: 101
      prefix: --no_progress
  - id: nonchimeras
    type:
      - 'null'
      - File
    doc: output non-chimeric sequences to file
    inputBinding:
      position: 101
      prefix: --nonchimeras
  - id: nonchimeras
    type:
      - 'null'
      - File
    doc: output non-chimeric sequences to file
    inputBinding:
      position: 101
      prefix: --nonchimeras
  - id: notmatched
    type:
      - 'null'
      - File
    doc: output filename for undetermined sequences
    inputBinding:
      position: 101
      prefix: --notmatched
  - id: notmatched
    type:
      - 'null'
      - File
    doc: FASTA file for non-matching query sequences
    inputBinding:
      position: 101
      prefix: --notmatched
  - id: notrunclabels
    type:
      - 'null'
      - boolean
    doc: do not truncate labels at first space
    inputBinding:
      position: 101
      prefix: --notrunclabels
  - id: orient
    type:
      - 'null'
      - File
    doc: orient sequences in given FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --orient
  - id: otutabout
    type:
      - 'null'
      - File
    doc: filename for OTU table output in classic format
    inputBinding:
      position: 101
      prefix: --otutabout
  - id: otutabout
    type:
      - 'null'
      - File
    doc: filename for OTU table output in classic format
    inputBinding:
      position: 101
      prefix: --otutabout
  - id: output
    type:
      - 'null'
      - File
    doc: output FASTA file (not for fastx_uniques)
    inputBinding:
      position: 101
      prefix: --output
  - id: output
    type:
      - 'null'
      - File
    doc: output file for fastq_eestats(2) statistics
    inputBinding:
      position: 101
      prefix: --output
  - id: output
    type:
      - 'null'
      - File
    doc: output to specified FASTA file
    inputBinding:
      position: 101
      prefix: --output
  - id: output
    type:
      - 'null'
      - File
    doc: output to specified FASTA file
    inputBinding:
      position: 101
      prefix: --output
  - id: output
    type:
      - 'null'
      - File
    doc: UDB or FASTA output file
    inputBinding:
      position: 101
      prefix: --output
  - id: output_no_hits
    type:
      - 'null'
      - boolean
    doc: output non-matching queries to output files
    inputBinding:
      position: 101
      prefix: --output_no_hits
  - id: pattern
    type:
      - 'null'
      - string
    doc: option is ignored
    inputBinding:
      position: 101
      prefix: --pattern
  - id: profile
    type:
      - 'null'
      - File
    doc: output sequence profile of each cluster to file
    inputBinding:
      position: 101
      prefix: --profile
  - id: qmask
    type:
      - 'null'
      - string
    doc: mask seqs with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --qmask
  - id: qmask
    type:
      - 'null'
      - string
    doc: mask seqs with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --qmask
  - id: qmask
    type:
      - 'null'
      - string
    doc: mask seqs with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --qmask
  - id: qmask
    type:
      - 'null'
      - string
    doc: mask query with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --qmask
  - id: qmask
    type:
      - 'null'
      - string
    doc: mask query with dust, soft or no method
    default: dust
    inputBinding:
      position: 101
      prefix: --qmask
  - id: query_cov
    type:
      - 'null'
      - float
    doc: reject if fraction of query seq. aligned lower
    inputBinding:
      position: 101
      prefix: --query_cov
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: output just warnings and fatal errors to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: randseed
    type:
      - 'null'
      - int
    doc: seed for PRNG, zero to use random data source
    default: 0
    inputBinding:
      position: 101
      prefix: --randseed
  - id: randseed
    type:
      - 'null'
      - int
    doc: seed for PRNG, zero to use random data source
    default: 0
    inputBinding:
      position: 101
      prefix: --randseed
  - id: randseed
    type:
      - 'null'
      - int
    doc: seed for PRNG, zero to use random data source
    default: 0
    inputBinding:
      position: 101
      prefix: --randseed
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel nonchimeras with this prefix string
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel nonchimeras with this prefix string
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel centroids with this prefix string
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel with this prefix string
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel sequences with this prefix string
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel sequences with this prefix string
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel
    type:
      - 'null'
      - string
    doc: relabel filtered sequences with given prefix
    inputBinding:
      position: 101
      prefix: --relabel
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_keep
    type:
      - 'null'
      - boolean
    doc: keep the old label after the new when relabelling
    inputBinding:
      position: 101
      prefix: --relabel_keep
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel with md5 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel with md5 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel with md5 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel with md5 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel with md5 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel sequences with md5 digest
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_md5
    type:
      - 'null'
      - boolean
    doc: relabel filtered sequences with md5 digest
    inputBinding:
      position: 101
      prefix: --relabel_md5
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_self
    type:
      - 'null'
      - boolean
    doc: relabel with the sequence itself as label
    inputBinding:
      position: 101
      prefix: --relabel_self
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel with sha1 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel with sha1 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel with sha1 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel with sha1 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel with sha1 digest of normalized sequence
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel sequences with sha1 digest
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: relabel_sha1
    type:
      - 'null'
      - boolean
    doc: relabel filtered sequences with sha1 digest
    inputBinding:
      position: 101
      prefix: --relabel_sha1
  - id: rereplicate
    type:
      - 'null'
      - File
    doc: rereplicate sequences in the given FASTA file
    inputBinding:
      position: 101
      prefix: --rereplicate
  - id: reverse
    type:
      - 'null'
      - File
    doc: specify FASTQ file with reverse reads
    inputBinding:
      position: 101
      prefix: --reverse
  - id: reverse
    type:
      - 'null'
      - File
    doc: specify FASTQ file with reverse reads
    inputBinding:
      position: 101
      prefix: --reverse
  - id: reverse
    type:
      - 'null'
      - File
    doc: FASTQ file with other end of paired-end reads
    inputBinding:
      position: 101
      prefix: --reverse
  - id: rightjust
    type:
      - 'null'
      - boolean
    doc: reject if terminal gaps at alignment right end
    inputBinding:
      position: 101
      prefix: --rightjust
  - id: rowlen
    type:
      - 'null'
      - int
    doc: width of alignment lines in alnout output
    default: 64
    inputBinding:
      position: 101
      prefix: --rowlen
  - id: samheader
    type:
      - 'null'
      - boolean
    doc: include a header in the SAM output file
    inputBinding:
      position: 101
      prefix: --samheader
  - id: samout
    type:
      - 'null'
      - File
    doc: filename for SAM format output
    inputBinding:
      position: 101
      prefix: --samout
  - id: sample_pct
    type:
      - 'null'
      - float
    doc: sampling percentage between 0.0 and 100.0
    inputBinding:
      position: 101
      prefix: --sample_pct
  - id: sample_size
    type:
      - 'null'
      - int
    doc: sampling size
    inputBinding:
      position: 101
      prefix: --sample_size
  - id: search_exact
    type:
      - 'null'
      - File
    doc: filename of queries for exact match search
    inputBinding:
      position: 101
      prefix: --search_exact
  - id: self
    type:
      - 'null'
      - boolean
    doc: exclude identical labels for --uchime_ref
    inputBinding:
      position: 101
      prefix: --self
  - id: self
    type:
      - 'null'
      - boolean
    doc: reject if labels identical
    inputBinding:
      position: 101
      prefix: --self
  - id: selfid
    type:
      - 'null'
      - boolean
    doc: exclude identical sequences for --uchime_ref
    inputBinding:
      position: 101
      prefix: --selfid
  - id: selfid
    type:
      - 'null'
      - boolean
    doc: reject if sequences identical
    inputBinding:
      position: 101
      prefix: --selfid
  - id: sff_clip
    type:
      - 'null'
      - boolean
    doc: clip ends of sequences as indicated in file
    default: false
    inputBinding:
      position: 101
      prefix: --sff_clip
  - id: sff_convert
    type:
      - 'null'
      - File
    doc: convert given SFF file to FASTQ format
    inputBinding:
      position: 101
      prefix: --sff_convert
  - id: shuffle
    type:
      - 'null'
      - File
    doc: shuffle order of sequences in FASTA file randomly
    inputBinding:
      position: 101
      prefix: --shuffle
  - id: sintax
    type:
      - 'null'
      - File
    doc: classify sequences in given FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --sintax
  - id: sintax_cutoff
    type:
      - 'null'
      - float
    doc: confidence value cutoff level
    default: 0.0
    inputBinding:
      position: 101
      prefix: --sintax_cutoff
  - id: sintax_random
    type:
      - 'null'
      - boolean
    doc: use random sequence, not shortest, if equal match
    inputBinding:
      position: 101
      prefix: --sintax_random
  - id: sizein
    type:
      - 'null'
      - boolean
    doc: propagate abundance annotation from input
    inputBinding:
      position: 101
      prefix: --sizein
  - id: sizein
    type:
      - 'null'
      - boolean
    doc: propagate abundance annotation from input
    inputBinding:
      position: 101
      prefix: --sizein
  - id: sizein
    type:
      - 'null'
      - boolean
    doc: propagate abundance annotation from input
    inputBinding:
      position: 101
      prefix: --sizein
  - id: sizein
    type:
      - 'null'
      - boolean
    doc: propagate abundance annotation from input
    inputBinding:
      position: 101
      prefix: --sizein
  - id: sizein
    type:
      - 'null'
      - boolean
    doc: propagate abundance annotation from input
    inputBinding:
      position: 101
      prefix: --sizein
  - id: sizein
    type:
      - 'null'
      - boolean
    doc: consider abundance info from input, do not ignore
    inputBinding:
      position: 101
      prefix: --sizein
  - id: sizeorder
    type:
      - 'null'
      - boolean
    doc: sort accepted centroids by abundance, AGC
    inputBinding:
      position: 101
      prefix: --sizeorder
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: include abundance information when relabelling
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: include abundance information when relabelling
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: write cluster abundances to centroid file
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: write abundance annotation to output
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: write abundance information to dbmatched file
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: include abundance information when relabelling
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: update abundance information in output
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: sizeout
    type:
      - 'null'
      - boolean
    doc: include abundance information when relabelling
    inputBinding:
      position: 101
      prefix: --sizeout
  - id: slots
    type:
      - 'null'
      - int
    doc: option is ignored
    inputBinding:
      position: 101
      prefix: --slots
  - id: sortbylength
    type:
      - 'null'
      - File
    doc: sort sequences by length in given FASTA file
    inputBinding:
      position: 101
      prefix: --sortbylength
  - id: sortbysize
    type:
      - 'null'
      - File
    doc: abundance sort sequences in given FASTA file
    inputBinding:
      position: 101
      prefix: --sortbysize
  - id: strand
    type:
      - 'null'
      - string
    doc: cluster using plus or both strands
    default: plus
    inputBinding:
      position: 101
      prefix: --strand
  - id: strand
    type:
      - 'null'
      - string
    doc: dereplicate plus or both strands
    default: plus
    inputBinding:
      position: 101
      prefix: --strand
  - id: strand
    type:
      - 'null'
      - string
    doc: search plus or both strands
    default: plus
    inputBinding:
      position: 101
      prefix: --strand
  - id: tabbedout
    type:
      - 'null'
      - File
    doc: output chimera info to tab-separated file
    inputBinding:
      position: 101
      prefix: --tabbedout
  - id: tabbedout
    type:
      - 'null'
      - File
    doc: write cluster info to tsv file for fastx_uniques
    inputBinding:
      position: 101
      prefix: --tabbedout
  - id: tabbedout
    type:
      - 'null'
      - File
    doc: output filename for result information
    inputBinding:
      position: 101
      prefix: --tabbedout
  - id: tabbedout
    type:
      - 'null'
      - File
    doc: write results to given tab-delimited file
    inputBinding:
      position: 101
      prefix: --tabbedout
  - id: target_cov
    type:
      - 'null'
      - float
    doc: reject if fraction of target seq. aligned lower
    inputBinding:
      position: 101
      prefix: --target_cov
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use, zero for all cores
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: top_hits_only
    type:
      - 'null'
      - boolean
    doc: output only hits with identity equal to the best
    inputBinding:
      position: 101
      prefix: --top_hits_only
  - id: topn
    type:
      - 'null'
      - int
    doc: output only n most abundant sequences after derep
    inputBinding:
      position: 101
      prefix: --topn
  - id: topn
    type:
      - 'null'
      - int
    doc: output just first n sequences
    inputBinding:
      position: 101
      prefix: --topn
  - id: uc
    type:
      - 'null'
      - File
    doc: specify filename for UCLUST-like output
    inputBinding:
      position: 101
      prefix: --uc
  - id: uc
    type:
      - 'null'
      - File
    doc: filename for UCLUST-like dereplication output
    inputBinding:
      position: 101
      prefix: --uc
  - id: uc
    type:
      - 'null'
      - File
    doc: filename for UCLUST-like output
    inputBinding:
      position: 101
      prefix: --uc
  - id: uc_allhits
    type:
      - 'null'
      - boolean
    doc: show all, not just top hit with uc output
    inputBinding:
      position: 101
      prefix: --uc_allhits
  - id: uchime2_denovo
    type:
      - 'null'
      - File
    doc: detect chimeras de novo in denoised amplicons
    inputBinding:
      position: 101
      prefix: --uchime2_denovo
  - id: uchime3_denovo
    type:
      - 'null'
      - File
    doc: detect chimeras de novo in denoised amplicons
    inputBinding:
      position: 101
      prefix: --uchime3_denovo
  - id: uchime_denovo
    type:
      - 'null'
      - File
    doc: detect chimeras de novo
    inputBinding:
      position: 101
      prefix: --uchime_denovo
  - id: uchime_ref
    type:
      - 'null'
      - File
    doc: detect chimeras using a reference database
    inputBinding:
      position: 101
      prefix: --uchime_ref
  - id: uchimealns
    type:
      - 'null'
      - File
    doc: output chimera alignments to file
    inputBinding:
      position: 101
      prefix: --uchimealns
  - id: uchimeout
    type:
      - 'null'
      - File
    doc: output to chimera info to tab-separated file
    inputBinding:
      position: 101
      prefix: --uchimeout
  - id: uchimeout5
    type:
      - 'null'
      - boolean
    doc: make output compatible with uchime version 5
    inputBinding:
      position: 101
      prefix: --uchimeout5
  - id: udb2fasta
    type:
      - 'null'
      - File
    doc: output FASTA file from given UDB file
    inputBinding:
      position: 101
      prefix: --udb2fasta
  - id: udbinfo
    type:
      - 'null'
      - File
    doc: show information about UDB file
    inputBinding:
      position: 101
      prefix: --udbinfo
  - id: udbstats
    type:
      - 'null'
      - File
    doc: report statistics about indexed words in UDB file
    inputBinding:
      position: 101
      prefix: --udbstats
  - id: unoise_alpha
    type:
      - 'null'
      - float
    doc: alpha parameter (unoise only)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --unoise_alpha
  - id: usearch_global
    type:
      - 'null'
      - File
    doc: filename of queries for global alignment search
    inputBinding:
      position: 101
      prefix: --usearch_global
  - id: userfields
    type:
      - 'null'
      - string
    doc: fields to output in userout file
    inputBinding:
      position: 101
      prefix: --userfields
  - id: userout
    type:
      - 'null'
      - File
    doc: filename for user-defined tab-separated output
    inputBinding:
      position: 101
      prefix: --userout
  - id: usersort
    type:
      - 'null'
      - boolean
    doc: indicate sequences not pre-sorted by length
    inputBinding:
      position: 101
      prefix: --usersort
  - id: weak_id
    type:
      - 'null'
      - float
    doc: include aligned hits with >= id; continue search
    inputBinding:
      position: 101
      prefix: --weak_id
  - id: wordlength
    type:
      - 'null'
      - int
    doc: length of words used for matching 3-15
    default: 12
    inputBinding:
      position: 101
      prefix: --wordlength
  - id: wordlength
    type:
      - 'null'
      - int
    doc: length of words for database index 3-15
    default: 8
    inputBinding:
      position: 101
      prefix: --wordlength
  - id: wordlength
    type:
      - 'null'
      - int
    doc: length of words for database index 3-15
    default: 8
    inputBinding:
      position: 101
      prefix: --wordlength
  - id: xee
    type:
      - 'null'
      - boolean
    doc: remove expected errors (ee) info from output
    inputBinding:
      position: 101
      prefix: --xee
  - id: xee
    type:
      - 'null'
      - boolean
    doc: remove expected errors (ee) info from output
    inputBinding:
      position: 101
      prefix: --xee
  - id: xn
    type:
      - 'null'
      - float
    doc: "'no' vote weight"
    default: 8.0
    inputBinding:
      position: 101
      prefix: --xn
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in output
    inputBinding:
      position: 101
      prefix: --xsize
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in output
    inputBinding:
      position: 101
      prefix: --xsize
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in output
    inputBinding:
      position: 101
      prefix: --xsize
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in derep output
    inputBinding:
      position: 101
      prefix: --xsize
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in output
    inputBinding:
      position: 101
      prefix: --xsize
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in output
    inputBinding:
      position: 101
      prefix: --xsize
  - id: xsize
    type:
      - 'null'
      - boolean
    doc: strip abundance information in output
    inputBinding:
      position: 101
      prefix: --xsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsearch:2.30.4--hd6d6fdc_0
stdout: vsearch.out
