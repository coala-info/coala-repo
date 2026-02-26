# isaac4 CWL Generation Report

## isaac4_isaac-align

### Tool Description
Aligns sequencing reads to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
- **Homepage**: https://github.com/Illumina/Isaac4
- **Package**: https://anaconda.org/channels/bioconda/packages/isaac4/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isaac4/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Illumina/Isaac4
- **Stars**: N/A
### Original Help Text
```text
2026-02-25 02:54:31 	[784517f42740]	Forcing LC_ALL to C
2026-02-25 02:54:31 	[784517f42740]	Version: Isaac-04.18.11.09
2026-02-25 02:54:31 	[784517f42740]	Genome offset type: j
2026-02-25 02:54:31 	[784517f42740]	argc: 1 argv: isaac-align
isaac-align -r <reference> -b <base calls> -m <memory limit> [optional arguments]

Command line options:
  --allow-empty-flowcells arg (=0)                Avoid failure when some of 
                                                  the --base-calls contain no 
                                                  data
  --anchor-mate arg (=1)                          Allow entire pair to be 
                                                  anchored by only one read if 
                                                  it has not been realigned. If
                                                  not set, each read is 
                                                  anchored individually and 
                                                  does not affect anchoring of 
                                                  its mate.
  --anomalous-pair-handicap arg (=240)            When deciding between an 
                                                  anomalous pair and a rescued 
                                                  pair, this is proportional to
                                                  the number of mismatches 
                                                  anomalous pair needs to have 
                                                  less in order to be accepted 
                                                  instead of a rescued pair.
  --bam-exclude-tags arg (=ZX,ZY)                 Comma-separated list of 
                                                  regular tags to exclude from 
                                                  the output BAM files. Allowed
                                                  values are: all,none,AS,BC,NM
                                                  ,OC,RG,SM,ZX,ZY
  --bam-gzip-level arg (=1)                       Gzip level to use for BAM
  --bam-header-tag arg                            Additional bam entries that 
                                                  are copied into the header of
                                                  each produced bam file. Use 
                                                  '\t' to represent tab 
                                                  separators.
  --bam-pessimistic-mapq arg (=0)                 When set, the MAPQ is 
                                                  computed as MAPQ:=min(60, 
                                                  min(SM, AS)), otherwise 
                                                  MAPQ:=min(60, max(SM, AS))
  --bam-produce-md5 arg (=1)                      Controls whether a separate 
                                                  file containing md5 checksum 
                                                  is produced for each output 
                                                  bam.
  --bam-pu-format arg (=%F:%L:%B)                 Template string for bam 
                                                  header RG tag PU field. 
                                                  Ordinary characters are 
                                                  directly copied. The 
                                                  following placeholders are 
                                                  supported:
                                                    - %F             : Flowcell
                                                  ID
                                                    - %L             : Lane 
                                                  number
                                                    - %B             : Barcode
  --barcode-mismatches arg (=1)                   Multiple entries allowed. 
                                                  Each entry is applied to the 
                                                  corresponding base-calls. 
                                                  Last entry applies to all the
                                                  bases-calls-directory that do
                                                  not have barcode-mismatches 
                                                  specified. Last component 
                                                  mismatch value applies to all
                                                  subsequent barcode components
                                                  should there be more than 
                                                  one. Examples: 
                                                    - 1:0             : allow 
                                                  one mismatch for the first 
                                                  barcode component and no 
                                                  mismatches for the subsequent
                                                  components.
                                                    - 1               : allow 
                                                  one mismatch for every 
                                                  barcode component.
                                                    - 0               : no 
                                                  mismatches allowed in any 
                                                  barcode component. This is 
                                                  the default.
  -b [ --base-calls ] arg                         full path to the base calls. 
                                                  Multiple entries allowed. 
                                                  Path should point either to a
                                                  directory or a file depending
                                                  on --base-calls-format
  -f [ --base-calls-format ] arg                  Multiple entries allowed. 
                                                  Each entry is applied to the 
                                                  corresponding base-calls. 
                                                  Last entry is applied to all 
                                                  --base-calls that don't have 
                                                  --base-calls-format 
                                                  specified.
                                                    - bam             : 
                                                  --base-calls points to a Bam 
                                                  file. All data found in bam 
                                                  file is assumed to come from 
                                                  lane 1 of a single flowcell.
                                                    - bcl             : 
                                                  --base-calls points to 
                                                  RunInfo.xml file. Data is 
                                                  made of uncompressed bcl 
                                                  files.
                                                    - bcl-gz          : 
                                                  --base-calls points to 
                                                  RunInfo.xml file. Bcl cycle 
                                                  tile files are individually 
                                                  compressed and named 
                                                  s_X_YYYY.bcl.gz
                                                    - bcl-bgzf        : 
                                                  --base-calls points to 
                                                  RunInfo.xml file. Bcl data is
                                                  stored in cycle files that 
                                                  are named CCCC.bcl.bgzf
                                                    - fastq           : 
                                                  --base-calls points to a 
                                                  directory containing one 
                                                  fastq per lane/read named 
                                                  lane<X>_read<Y>.fastq. Use 
                                                  lane<X>_read1.fastq for 
                                                  single-ended data.
                                                    - fastq-gz        : 
                                                  --base-calls points to a 
                                                  directory containing one 
                                                  compressed fastq per 
                                                  lane/read named 
                                                  lane<X>_read<Y>.fastq.gz. Use
                                                  lane<X>_read1.fastq.gz for 
                                                  single-ended data.
  --base-quality-cutoff arg (=15)                 3' end quality trimming 
                                                  cutoff. Value above 0 causes 
                                                  low quality bases to be 
                                                  soft-clipped. 0 turns the 
                                                  trimming off.
  --bcl-tiles-per-chunk arg (=1)                  Increase this number when the
                                                  tiles are too small for the 
                                                  processing to be efficient. 
                                                  In particular, collecting the
                                                  template length statistics 
                                                  requires several tens of 
                                                  thousands clusters to work. 
                                                  If tiles are small and data 
                                                  is heavily multiplexed, there
                                                  might be not enough clusters 
                                                  in a single tile to collect 
                                                  the tls for a sample
  --bin-regex arg (=all)                          Define which bins appear in 
                                                  the output bam files
                                                  all                   : 
                                                  Include all bins in the bam 
                                                  and all contig entries in the
                                                  bam header.
                                                  skip-empty             : 
                                                  Include only the contigs that
                                                  have aligned data.
                                                  REGEX                 : Is 
                                                  treated as comma-separated 
                                                  list of regular expressions. 
                                                  Bam files will be filtered to
                                                  contain only the bins that 
                                                  match by the name.
  --candidate-matches-max arg (=800)              Maximum number of candidate 
                                                  matches to be considered for 
                                                  finding the best alignment. 
                                                  If seeds yield a greater 
                                                  number, the alignment 
                                                  generally is not performed. 
                                                  Other mechanisms such as 
                                                  shadow rescue may still place
                                                  the fragment.
  --cleanup-intermediary arg (=0)                 When set, Isaac will erase 
                                                  intermediate input files for 
                                                  the stages that have been 
                                                  completed. Notice that this 
                                                  will prevent resumption from 
                                                  the stages that have their 
                                                  input files removed. 
                                                  --start-from Last will still 
                                                  work.
  --clip-overlapping arg (=1)                     When set, the pairs that have
                                                  read ends overlapping each 
                                                  other will have the 
                                                  lower-quality end 
                                                  soft-clipped.
  --clip-semialigned arg (=0)                     When set, reads have their 
                                                  bases soft-clipped on either 
                                                  sides until a stretch of 5 
                                                  matches is found
  -c [ --cluster ] arg                            Restrict the alignment to the
                                                  specified cluster Id 
                                                  (multiple entries allowed)
  --clusters-at-a-time arg (=8000000)             Bam and fastq only. When not 
                                                  set, number of clusters to 
                                                  process together when input 
                                                  is bam or fastq is computed 
                                                  automatically based on the 
                                                  amount of available RAM. Set 
                                                  to non-zero value to force 
                                                  deterministic behavior.
  --decoy-regex arg (=decoy)                      Contigs that have matching 
                                                  names are marked as decoys 
                                                  and enjoy reduced effort. In 
                                                  particular: 
                                                    - Smith waterman is not 
                                                  used for alignments
                                                    - Suspicious alignments are
                                                  marked dodgyFor example, to 
                                                  mark everything that does not
                                                  begin with chr as decoy use 
                                                  the following regex: 
                                                  ^(?!chr.*)
  --default-adapters arg                          Multiple entries allowed. 
                                                  Each entry is associated with
                                                  the corresponding base-calls.
                                                  Flowcells that don't have 
                                                  default-adapters provided, 
                                                  don't get adapters clipped in
                                                  the data. 
                                                  Each entry is a 
                                                  comma-separated list of 
                                                  adapter sequences written in 
                                                  the direction of the 
                                                  reference. Wildcard (* 
                                                  character) is allowed only on
                                                  one side of the sequence. 
                                                  Entries with * apply only to 
                                                  the alignments on the 
                                                  matching strand. Entries 
                                                  without * apply to all strand
                                                  alignments and are matched in
                                                  the order of appearance in 
                                                  the list.
                                                  Examples:
                                                    ACGT*,*TGCA       : Will 
                                                  clip ACGT and all subsequent 
                                                  bases in the forward-strand 
                                                  alignments and mirror the 
                                                  behavior for the 
                                                  reverse-strand alignments.
                                                    ACGT,TGCA         : Will 
                                                  find the following sequences 
                                                  in the reads: ACGT, TGCA, 
                                                  ACGTTGCA  (but not TGCAACGT!)
                                                  regardless of the alignment 
                                                  strand. Then will attempt to 
                                                  clip off the side of the read
                                                  that is shorter. If both 
                                                  sides are roughly equal 
                                                  length, will clip off the 
                                                  side that has less matches.
                                                    Standard          : 
                                                  Standard protocol adapters. 
                                                  Same as AGATCGGAAGAGC*,*GCTCT
                                                  TCCGATCT
                                                    Nextera           : Nextera
                                                  standard. Same as 
                                                  CTGTCTCTTATACACATCT*,*AGATGTG
                                                  TATAAGAGACAG
                                                    NexteraMp         : Nextera
                                                  mate-pair. Same as 
                                                  CTGTCTCTTATACACATCT,AGATGTGTA
                                                  TAAGAGACAG
  --description arg                               Free form text to be stored 
                                                  in the Isaac @PG DS bam 
                                                  header tag
  --detect-template-block-size arg (=10000)       Number of pairs to use as a 
                                                  single block for template 
                                                  length statistics detection
  --disable-resume arg (=0)                       If eanbled, Isaac does not 
                                                  persist the state of the 
                                                  analysis on disk. This might 
                                                  save noticeable amount of 
                                                  runtime at the expense of not
                                                  being able to use 
                                                  --start-from option.
  --dodgy-alignment-score arg (=0)                Controls the behavior for 
                                                  templates where alignment 
                                                  score is impossible to 
                                                  assign:
                                                   - Unaligned        : marks 
                                                  template fragments as 
                                                  unaligned
                                                   - 0-254            : exact 
                                                  MAPQ value to be set in bam
                                                   - Unknown          : assigns
                                                  value 255 for bam MAPQ. 
                                                  Ensures SM and AS are not 
                                                  specified in the bam
  --enable-numa [=arg(=1)] (=0)                   Replicate static data across 
                                                  NUMA nodes, lock threads to 
                                                  their NUMA nodes, allocate 
                                                  thread private data on the 
                                                  corresponding NUMA node
  --expected-bgzf-ratio arg (=1)                  compressed = ratio * 
                                                  uncompressed. To avoid memory
                                                  overallocation during the bam
                                                  generation, Isaac has to 
                                                  assume certain compression 
                                                  ratio. If Isaac estimates 
                                                  less memory than is actually 
                                                  required, it will fail at 
                                                  runtime. You can check how 
                                                  far you are from the 
                                                  dangerous zone by looking at 
                                                  the resident/swap memory 
                                                  numbers for your process 
                                                  during the bam generation. If
                                                  you see too much showing as 
                                                  'swap', it is safe to reduce 
                                                  the --expected-bgzf-ratio.
  --expected-coverage arg (=60)                   Expected coverage is required
                                                  for Isaac to estimate the 
                                                  efficient binning of the 
                                                  aligned data.
  --fastq-q0 arg (=!)                             Character to serve as base 
                                                  quality 0 in fastq input.
  --gap-scoring arg (=bwa)                        Gapped alignment algorithm 
                                                  parameters:
                                                   - eland            : 
                                                  equivalent of 2:-1:-15:-3:-25
                                                   - bwa              : 
                                                  equivalent of 0:-3:-11:-4:-20
                                                   - bwa-mem          : 
                                                  equivalent of 1:-4:-6:-1:-20
                                                   - m:mm:go:ge:me:gl : 
                                                  colon-delimited string of 
                                                  values where:
                                                       m              : match 
                                                  score
                                                       mm             : 
                                                  mismatch score
                                                       go             : gap 
                                                  open score
                                                       ge             : gap 
                                                  extend score
                                                       me             : min 
                                                  extend score (all gaps 
                                                  reaching this score will be 
                                                  treated as equal)
  --hash-table-buckets arg (=0)                   Number of buckets to use for 
                                                  reference hash table. Larger 
                                                  number of buckets requires 
                                                  more RAM but it tends to 
                                                  speed up the execution and 
                                                  improve sensitivity. Value of
                                                  0 indicates default bucket 
                                                  count: 2^({seed-length}*2)
  -h [ --help ]                                   produce help message and exit
  --help-defaults                                 produce tab-delimited list of
                                                  command line options and 
                                                  their default values
  --help-md                                       produce help message 
                                                  pre-formatted as a markdown 
                                                  file section and exit
  --ignore-missing-bcls arg (=0)                  When set, missing bcl files 
                                                  are treated as all clusters 
                                                  having N bases for the 
                                                  corresponding tile cycle. 
                                                  Otherwise, encountering a 
                                                  missing bcl file causes the 
                                                  analysis to fail.
  --ignore-missing-filters arg (=0)               When set, missing filter 
                                                  files are treated as if all 
                                                  clusters pass filter for the 
                                                  corresponding tile. 
                                                  Otherwise, encountering a 
                                                  missing filter file causes 
                                                  the analysis to fail.
  --input-concurrent-load arg (=64)               Maximum number of concurrent 
                                                  file read operations for 
                                                  --base-calls
  -j [ --jobs ] arg (=20)                         Maximum number of compute 
                                                  threads to run in parallel
  --keep-duplicates arg (=1)                      Keep duplicate pairs in the 
                                                  bam file (with 0x400 flag set
                                                  in all but the best one)
  --keep-unaligned arg (=back)                    Available options:
                                                   - discard          : discard
                                                  clusters where both reads are
                                                  not aligned
                                                   - front            : keep 
                                                  unaligned clusters in the 
                                                  front of the BAM file
                                                   - back             : keep 
                                                  unaligned clusters in the 
                                                  back of the BAM file
  --known-indels arg                              path to a VCF file containing
                                                  known indels fore 
                                                  realignment.
  --lane-number-max arg (=8)                      Maximum lane number to look 
                                                  for in --base-calls-directory
                                                  (fastq only).
  --mapq-threshold arg (=-1)                      If any fragment alignment in 
                                                  template is below the 
                                                  threshold, template is not 
                                                  stored in the BAM.
  --mark-duplicates arg (=1)                      If not set and --keep-duplica
                                                  tes is set, the duplicates 
                                                  are not discarded and not 
                                                  flagged.
  --match-finder-shadow-split-repeats arg (=100000)
                                                  Maximum number of seed 
                                                  candidate matches to be 
                                                  considered for finding a 
                                                  possible alignment split.
  --match-finder-too-many-repeats arg (=4000)     Maximum number of seed 
                                                  matches to be looked at for 
                                                  each attempted seed
  --match-finder-way-too-many-repeats arg (=100000)
                                                  Maximum number of seed 
                                                  matches to be looked at if in
                                                  a pair one read has candidate
                                                  alignments and the otherhas 
                                                  gone over match-finder-too-ma
                                                  ny-repeats on all seeds or 
                                                  over candidate-matches-max 
                                                  when seed position merge was 
                                                  attempted 
  --memory-control arg (=off)                     Define the behavior in case 
                                                  unexpected memory allocations
                                                  are detected: 
                                                    - warning         : Log 
                                                  WARNING about the allocation.
                                                    - off             : Don't 
                                                  monitor dynamic memory usage.
                                                    - strict          : Fail 
                                                  memory allocation. Intended 
                                                  for development use.
  -m [ --memory-limit ] arg (=0)                  Limits major memory 
                                                  consumption operations to a 
                                                  set number of gigabytes. 0 
                                                  means no limit, however 0 is 
                                                  not allowed as in such case 
                                                  Isaac will most likely 
                                                  consume all the memory on the
                                                  system and cause it to crash.
                                                  Default value is taken from 
                                                  ulimit -v.
  --neighborhood-size-threshold arg (=0)          Threshold used to decide if 
                                                  the number of reference 
                                                  32-mers sharing the same 
                                                  prefix (16 bases) is small 
                                                  enough to justify the 
                                                  neighborhood search. Use 
                                                  large enough value e.g. 10000
                                                  to enable alignment to 
                                                  positions where seeds don't 
                                                  match exactly.
  --output-concurrent-save arg (=120)             Maximum number of concurrent 
                                                  file write operations for 
                                                  --output-directory
  -o [ --output-directory ] arg (=./Aligned)      Directory where the final 
                                                  alignment data be stored
  --per-tile-tls arg (=0)                         Forces template length 
                                                  statistics(TLS) to be 
                                                  recomputed for each tile. 
                                                  When not set, the first tile 
                                                  that produces stable TLS will
                                                  determine TLS for the rest of
                                                  the tiles of the lane. Notice
                                                  that as the tiles are not 
                                                  guaranteed to be processed in
                                                  the same order between 
                                                  different runs, some pair 
                                                  alignments might vary between
                                                  two runs on the same data 
                                                  unless --per-tile-tls is set.
                                                  It is not recommended to set 
                                                  --per-tile-tls when input 
                                                  data is not randomly 
                                                  distributed (such as bam) as 
                                                  in such cases, the shadow 
                                                  rescue range will be biased 
                                                  by the input data ordering.
  --pf-only arg (=1)                              When set, only the fragments 
                                                  passing filter (PF) are 
                                                  generated in the BAM file
  --pre-allocate-bins arg (=0)                    Use fallocate to reduce the 
                                                  bin file fragmentation. Since
                                                  bin files are pre-allocated 
                                                  based on the estimation of 
                                                  their size, it is recommended
                                                  to turn bin pre-allocation 
                                                  off when using RAM disk as 
                                                  temporary storage.
  --pre-sort-bins arg (=1)                        Unset this value if you are 
                                                  working with references that 
                                                  have many contigs (1000+)
  --read-name-length arg (=0)                     Maximum read name length 
                                                  (fastq and bam only). Value 
                                                  of 0 causes the read name 
                                                  length to be determined by 
                                                  reading the first records of 
                                                  the input data. Shorter than 
                                                  needed read names can cause 
                                                  duplicate names in the output
                                                  bam files.
  --realign-dodgy arg (=0)                        If not set, the reads without
                                                  alignment score are not 
                                                  realigned against gaps found 
                                                  in other reads.
  --realign-gaps arg (=sample)                    For reads overlapping the 
                                                  gaps occurring on other 
                                                  reads, check if applying 
                                                  those gaps reduces mismatch 
                                                  count. Significantly reduces 
                                                  number of false SNPs reported
                                                  around short indels.
                                                    - no              : no gap 
                                                  realignment
                                                    - sample          : realign
                                                  against gaps found in the 
                                                  same sample
                                                    - project         : realign
                                                  against gaps found in all 
                                                  samples of the same project
                                                    - all             : realign
                                                  against gaps found in all 
                                                  samples
  --realign-mapq-min arg (=60)                    Gaps from alignments with 
                                                  lower MAPQ will not be used 
                                                  as candidates for gap 
                                                  realignment
  --realign-vigorously arg (=0)                   If set, the realignment 
                                                  result will be used to search
                                                  for more gaps and attempt 
                                                  another realignment, 
                                                  effectively extending the 
                                                  realignment over multiple 
                                                  deletions not covered by the 
                                                  original alignment.
  --realigned-gaps-per-fragment arg (=4)          Maximum number of gaps the 
                                                  realigner can introduce into 
                                                  a fragment. For 100 bases 
                                                  long DNA it is reasonable to 
                                                  keep it no bigger than 2. RNA
                                                  reads can overlap multiple 
                                                  introns. Therefore a larger 
                                                  number is probably required 
                                                  for RNA. Notice that bigger 
                                                  values can significantly slow
                                                  down the bam generation as 
                                                  there is a n choose k 
                                                  combination try with n being 
                                                  the number of gaps detected 
                                                  by all other fragment 
                                                  alignments that overlap the 
                                                  fragment being realigned.
  -r [ --reference-genome ] arg                   Full path to the reference 
                                                  genome XML descriptor.
  -n [ --reference-name ] arg (=default)          Unique symbolic name of the 
                                                  reference. Multiple entries 
                                                  allowed. Each entry is 
                                                  associated with the 
                                                  corresponding --reference-gen
                                                  ome and will be matched 
                                                  against the 'reference' 
                                                  column in the sample sheet. 
                                                  Special names:
                                                    - unknown         : default
                                                  reference to use with data 
                                                  that did not match any 
                                                  barcode.
                                                    - default         : 
                                                  reference to use for the data
                                                  with no matching value in 
                                                  sample sheet 'reference' 
                                                  column.
  --remap-qscores arg                             Replace the base calls 
                                                  qscores according to the 
                                                  rules provided.
                                                   - identity   : No remapping.
                                                  Original qscores are 
                                                  preserved
                                                   - bin:8      : Equivalent of
                                                  0-1:0,2-9:7,10-19:11,20-24:22
                                                  ,25-29:27,30-34:32,35-39:37,4
                                                  0-63:40
  --repeat-threshold arg (=100)                   Threshold used to decide if 
                                                  matches must be discarded as 
                                                  too abundant (when the number
                                                  of repeats is greater or 
                                                  equal to the threshold)
  --rescue-shadows arg (=1)                       Scan within dominant template
                                                  range off an orphan, for a 
                                                  possible shadow alignment
  --response-file arg                             file with more command line 
                                                  arguments
  -s [ --sample-sheet ] arg                       Multiple entries allowed. 
                                                  Each entry is applied to the 
                                                  corresponding base-calls.
                                                    - none            : process
                                                  flowcell as if there is no 
                                                  sample sheet
                                                    - default         : use 
                                                  <base-calls>/SampleSheet.csv 
                                                  if it exists. This is the 
                                                  default behavior.
                                                    - <file path>     : use 
                                                  <file path> as sample sheet 
                                                  for the flowcell.
  --scatter-repeats arg (=1)                      When set, extra care will be 
                                                  taken to scatter pairs 
                                                  aligning to repeats across 
                                                  the repeat locations 
  --seed-base-quality-min arg (=3)                Minimum base quality for the 
                                                  seed to be used in alignment 
                                                  candidate search.
  --seed-length arg (=16)                         Length of the seed in bases. 
                                                  Only 10 11 12 13 14 15 16 17 
                                                  18 19 20  are allowed. Longer
                                                  seeds reduce sensitivity on 
                                                  noisy data but improve repeat
                                                  resolution and run time.
  --shadow-scan-range arg (=-1)                   -1     - scan for possible 
                                                  mate alignments between 
                                                  template min and max
                                                  >=0    - scan for possible 
                                                  mate alignments in range of 
                                                  template median += 
                                                  shadow-scan-range
  --single-library-samples arg (=1)               If set, the duplicate 
                                                  detection will occur across 
                                                  all read pairs in the sample.
                                                  If not set, different lanes 
                                                  are assumed to originate from
                                                  different libraries and 
                                                  duplicate detection is not 
                                                  performed across lanes.
  --smith-waterman-gap-size-max arg (=16)         Maximum length of gap 
                                                  detectable by smith waterman 
                                                  algorithm.
  --smith-waterman-gaps-max arg (=4)              Maximum number of gaps that 
                                                  can be introduced into an 
                                                  alignment by Smith-Waterman 
                                                  algorithm. If the optimum 
                                                  alignment has more gaps, it 
                                                  is simply ignored as an 
                                                  alignment candidate.
  --split-alignments arg (=1)                     When set, alignments crossing
                                                  a structural variant are 
                                                  allowed to be split with SA 
                                                  tag.
  --split-gap-length arg (=10000)                 Maximum length of insertion 
                                                  or deletion allowed to exist 
                                                  in a read. If a gap exceeds 
                                                  this limit, the read gets 
                                                  broken up around the gap with
                                                  SA tag introduced
  --start-from arg (=Start)                       Start processing at the 
                                                  specified stage:
                                                    - Start            : don't 
                                                  resume, start from beginning
                                                    - Align            : same 
                                                  as Start
                                                    - AlignmentReports : 
                                                  regenerate alignment reports 
                                                  and bam
                                                    - Bam              : resume
                                                  at bam generation
                                                    - Finish           : Same 
                                                  as Bam.
                                                    - Last             : resume
                                                  from the last successful step
                                                  Note that although Isaac 
                                                  attempts to perform some 
                                                  basic validation, the only 
                                                  safe option is 'Start' The 
                                                  primary purpose of the 
                                                  feature is to reduce the time
                                                  required to diagnose the 
                                                  issues rather than be used on
                                                  a regular basis.
  --stats-image-format arg (=none)                Format to use for images 
                                                  during stats generation
                                                   - gif        : produce .gif 
                                                  type plots
                                                   - none       : no stat 
                                                  generation
  --stop-at arg (=Finish)                         Stop processing after the 
                                                  specified stage is complete:
                                                    - Start            : 
                                                  perform the first stage only
                                                    - Align            : same 
                                                  as Start
                                                    - AlignmentReports : don't 
                                                  perform bam generation
                                                    - Bam              : finish
                                                  when bam is done
                                                    - Finish           : stop 
                                                  at the end.
                                                    - Last             : 
                                                  perform up to the last 
                                                  successful step only
                                                  Note that although Isaac 
                                                  attempts to perform some 
                                                  basic validation, the only 
                                                  safe option is 'Finish' The 
                                                  primary purpose of the 
                                                  feature is to reduce the time
                                                  required to diagnose the 
                                                  issues rather than be used on
                                                  a regular basis.
  --target-bin-size arg (=0)                      Isaac will attempt to bin 
                                                  temporary data so that each 
                                                  bin is close to targetBinSize
                                                  in megabytes (1024 * 1024 
                                                  bytes). Value of 0 will cause
                                                  Isaac to compute the target 
                                                  bin size automatically based 
                                                  on the available memory.
  --temp-concurrent-load arg (=4)                 Maximum number of concurrent 
                                                  file read operations for 
                                                  --temp-directory
  --temp-concurrent-save arg (=680)               Maximum number of concurrent 
                                                  file write operations for 
                                                  --temp-directory
  -t [ --temp-directory ] arg (=./Temp)           Directory where the temporary
                                                  files will be stored 
                                                  (matches, unsorted 
                                                  alignments, etc.)
  --tiles arg                                     Comma-separated list of 
                                                  regular expressions to select
                                                  only a subset of the tiles 
                                                  available in the flow-cell.
                                                  - to select all the tiles 
                                                  ending with '5' in all lanes:
                                                  --tiles [0-9][0-9][0-9]5
                                                  - to select tile 2 in lane 1 
                                                  and all the tiles in the 
                                                  other lanes: --tiles 
                                                  s_1_0002,s_[2-8]
                                                  Multiple entries allowed, 
                                                  each applies to the 
                                                  corresponding base-calls.
  --tls arg                                       Template-length statistics in
                                                  the format 'min:median:max:lo
                                                  wStdDev:highStdDev:M0:M1', 
                                                  where M0 and M1 are the 
                                                  numeric value of the models 
                                                  (0=FFp, 1=FRp, 2=RFp, 3=RRp, 
                                                  4=FFm, 5=FRm, 6=RFm, 7=RRm)
  --trim-pe arg (=1)                              Trim overhanging ends of PE 
                                                  alignments
  --use-bases-mask arg                            Conversion mask characters:
                                                    - Y or y          : use
                                                    - N or n          : discard
                                                    - I or i          : use for
                                                  indexing
                                                  
                                                  If not given, the mask will 
                                                  be guessed from the 
                                                  config.xml file in the 
                                                  base-calls directory.
                                                  
                                                  For instance, in a 2x76 
                                                  indexed paired end run, the 
                                                  mask I<Y76,I6n,y75n> means:
                                                    use all 76 bases from the 
                                                  first end, discard the last 
                                                  base of the indexing read, 
                                                  and use only the first 75 
                                                  bases of the second end.
  --use-smith-waterman arg (=smart)               One of the following:
                                                   - always           : Use 
                                                  smith-waterman to reduce the 
                                                  amount of mismatches in 
                                                  aligned reads
                                                   - smart            : apply 
                                                  heuristics to avoid executing
                                                  costly smith-waterman on 
                                                  sequences that are unlikely 
                                                  to produce gaps
                                                   - never            : Don't 
                                                  use smith-waterman
  --variable-read-length arg                      Unless set, Isaac will fail 
                                                  if the length of the sequence
                                                  changes between the records 
                                                  of a fastq or a bam file.
  --verbosity arg (=2)                            Verbosity: FATAL(0), 
                                                  ERRORS(1), WARNINGS(2), 
                                                  INFO(3), DEBUG(4) (not 
                                                  supported yet)
  -v [ --version ]                                print program version 
                                                  information


Failed to parse the options: /opt/conda/conda-bld/isaac4_1595676738617/work/src/c++/lib/options/AlignOptions.cpp(614): Throw in function void isaac::options::AlignOptions::verifyMandatoryPaths(boost::program_options::variables_map&)
Dynamic exception type: boost::wrapexcept<isaac::common::InvalidOptionException>
std::exception::what: 
   *** The 'reference-genome' option is required ***
```

