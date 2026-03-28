# msamtools CWL Generation Report

## msamtools_filter

### Tool Description
Filter alignments from BAM/SAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
- **Homepage**: https://github.com/arumugamlab/msamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/msamtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msamtools/overview
- **Total Downloads**: 15.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arumugamlab/msamtools
- **Stars**: N/A
### Original Help Text
```text
Usage:
------

msamtools filter [-buhSkv] <bamfile> [--help] [-l <int>] [-p <int>] [--ppt=<int>] [-z <int>] [--rescore] [--besthit] [--uniqhit]

General options:
----------------

These options specify the input/output formats of BAM/SAM files 
(same meaning as in 'samtools view'):
  -b                        output BAM (default: false)
  -u                        uncompressed BAM output (force -b) (default: false)
  -h                        print header for the SAM output (default: false)
  -S                        input is SAM (default: false)
  <bamfile>                 input SAM/BAM file
  --help                    print this help and exit

Specific options:
-----------------

  -l <int>                  min. length of alignment (default: 0)
  -p <int>                  min. sequence identity of alignment, in percentage, integer between 0 and 100; requires NM field to be present (default: 0)
  --ppt=<int>               min/max sequence identity of alignment, in parts per thousand, integer between -1000 and 1000; requires NM field to be present (default: 0)
                            NOTE:
                            -----
                                  When using --ppt, +ve values mean minimum ppt and -ve values mean maximum ppt.
                                  E.g., '--ppt 950' will report alignments with ppt>950,
                                  and '--ppt -950' will report alignments with ppt<=950.
  -z <int>                  min. percent of the query that must be aligned, between 0 and 100 (default: 0)
  -k, --keep_unmapped       report unmapped reads, when filtering using upper-limit thresholds (default: false)
  -v, --invert              invert the effect of the filter (default: false)
                            CAUTION:
                            --------
                                  When using --invert or -v, be precise in what needs to be inverted.
                                  Adding -v gives you the complement of what you get without -v.
                                  Sometimes, this might be counter-intuitive.
                                  E.g., '-l 65 -p 95' will report alignments that are (>65bp AND >95%).
                                        '-l 65 -p 95 -v' will not report (<65bp AND <95%), as one might think.
                                        '-l 65 -p 95 -v' will report NOT(>65bp AND >95%) which is (<65bp OR <95%).
                                        Notice the 'OR' in the final logical operation. This means that
                                        an alignment that fails one condition will still be reported if it
                                        satisfies the other condition.
                                        If you only wanted alignments that are below 95%, then specify '-p 95 -v'
  --rescore                 rescore alignments using MD or NM fields, in that order (default: false)

Special filters:
----------------

The following special filters cannot be combined with -v, but require:
  (1) the alignments to be sorted by name,
  (2) AS field (alignment score) to be present.
You can usually achieve sorting by:
  samtools sort -n -T tmp.sort input.bam  | msamtools -m filter --besthit -
If AS is missing, you can rescore alignments by:
  samtools sort -n -T tmp.sort input.bam | msamtools -m filter --rescore --besthit -

  --besthit                 keep all highest scoring hit(s) per read (default: false)
  --uniqhit                 keep only one highest scoring hit per read, only if it is unique (default: false)
```


## msamtools_profile

### Tool Description
Produces an abundance profile of all reference sequences in a BAM file based on the number of read-pairs (inserts) mapping to each reference sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
- **Homepage**: https://github.com/arumugamlab/msamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/msamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
------

msamtools profile [-S] <bamfile> [--help] -o <file> --label=<string> [--genome=<string>] [--total=<int>] [--mincount=<int>] [--unit=<string>] [--pandas] [--nolen] [--multi=<string>]

General options:
----------------

These options specify the input/output formats of BAM/SAM files 
(same meaning as in 'samtools view'):
  -S                        input is SAM (default: false)
  <bamfile>                 input SAM/BAM file
  --help                    print this help and exit

Specific options:
-----------------

  -o <file>                 name of output file (required)
  --label=<string>          label to use for the profile; typically the sample id (required)
  --genome=<string>         tab-delimited genome definition file - 'genome-id<tab>seq-id' (default: none)
  --total=<int>             number of high-quality inserts (mate-pairs/paired-ends) that were input to the aligner (default: 0)
  --mincount=<int>          minimum number of inserts mapped to a feature, below which the feature is counted as absent (default: 0)
  --unit=<string>           unit of abundance to report {ab | rel | fpkm | tpm} (default: rel)
  --pandas                  print two columns (ID, sample-label) as header compatible with python pandas (default: only sample label)
  --nolen                   do not normalize the abundance (only relevant for ab or rel) for sequence length (default: normalize)
  --multi=<string>          how to deal with multi-mappers {all | equal | proportional} (default: proportional)

Description
-----------

Produces an abundance profile of all reference sequences in a BAM file
based on the number of read-pairs (inserts) mapping to each reference sequence.
It can work with genome-scale reference sequences while mapping to a database 
of sequenced genomes, but can also work with gene-scale sequences such as in the
Integrated Gene Catalog from human gut microbiome (Li et al, Nat biotech 2014).

In the output file, each sequence in the BAM file gets a line with its abundance.
They are presented in the order in which they appear in the BAM header. <label>
is used as the first line, so that reading or 'joining' these files is easier.

--total option:      In metagenomics, an unmapped insert could still be a valid
                     sequence, just missing in the database being mapped against.
                     This is the purpose of the '--total' option to track the
                     fraction of 'unknown' entities in the sample. If --total
                     is ignored or specified as --total=0, then tracking the 
                     'unknown' fraction is disabled. However, if the total 
                     sequenced inserts were given, then there will be a new
                     feature added to denote the 'unknown' fraction.
Units of abundance:  Currently four different units are available.
                          'ab': raw insert-count abundance
                         'rel': relative abundance (default)
                        'fpkm': fragments per kilobase of sequence per million reads
                         'tpm': transcripts per million
                     If number of inserts input to the aligner is given via --total,
                     fpkm and tpm will behave differently than in RNAseq data,
                     as there is now a new entity called 'unknown'.
Alignment filtering: 'profile' expects that every alignment listed is considered 
                     valid. For example, if one needs to filter alignments 
                     based on alignment length, read length, alignment percent
                     identity, etc, this should have been done prior to 
                     'profile'. Please see 'filter' for such filtering.
Multi-mapper inserts: Inserts mapping to multiple references need to be considered
                     carefully, as spurious mappings of promiscuous regions or
                     short homology could lead to incorrect abundances of 
                     sequences. 'profile' offers three options for this purpose.
                     If an insert maps to N references at the same time:
                'ignore': insert is ignored.
                   'all': each reference gets 1 insert added.
                 'equal': each reference gets 1/N insert added.
          'proportional': each reference gets a fraction proportional to its 
                          reference-sequence-length-normalized relative 
                          abundance estimated only based on uniquely
                          mapped inserts.
```


## msamtools_coverage

### Tool Description
Produces per-position sequence coverage information for all reference sequences
in the BAM file. Output is similar to old-style quality files from the Sanger 
sequencing era, with a fasta-style header followed by lines of space-delimited 
numbers.

### Metadata
- **Docker Image**: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
- **Homepage**: https://github.com/arumugamlab/msamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/msamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
------

msamtools coverage [-Sxz] <bamfile> [--help] -o <file> [--summary] [-w <int>]

General options:
----------------

These options specify the input/output formats of BAM/SAM files 
(same meaning as in 'samtools view'):
  -S                        input is SAM (default: false)
  <bamfile>                 input SAM/BAM file
  --help                    print this help and exit

Specific options:
-----------------

  -o <file>                 name of output file (required)
  --summary                 do not report per-position coverage but report fraction of sequence covered (default: false)
  -x, --skipuncovered       do not report coverage for sequences without aligned reads (default: false)
  -w, --wordsize=<int>      number of words (coverage values) per line (default: 17)
  -z, --gzip                compress output file using gzip (default: true)

Description:
------------

Produces per-position sequence coverage information for all reference sequences
in the BAM file. Output is similar to old-style quality files from the Sanger 
sequencing era, with a fasta-style header followed by lines of space-delimited 
numbers.

For large datasets, option '-x' comes in handy when only a small fraction of 
reference sequences are covered.

If using '-z', output file does NOT automatically get '.gz' extension. This is 
up to the user to specify the correct full output file name.
```


## msamtools_summary

### Tool Description
Prints summary of alignments in the given BAM/SAM file. By default, it prints a summary line per alignment entry in the file. The summary is a tab-delimited line with the following fields: qname,aligned_qlen,target_name,glocal_align_len,matches,percent_identity glocal_align_len includes the unaligned qlen mimicing a global alignment in the query and local alignment in target, thus glocal. With --stats option, summary is consolidated as distribution of read counts for a given measure. --stats=mapped   - distribution for number of mapped query bases --stats=unmapped - distribution for number of unmapped query bases --stats=edit     - distribution for edit distances --stats=score    - distribution for score=match-edit

### Metadata
- **Docker Image**: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
- **Homepage**: https://github.com/arumugamlab/msamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/msamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
------

msamtools summary [-Sc] <bamfile> [--help] [-e <num>] [--stats=<string>]

General options:
----------------

These options specify the input/output formats of BAM/SAM files 
(same meaning as in 'samtools view'):
  -S                        input is SAM (default: false)
  <bamfile>                 input SAM/BAM file
  --help                    print this help and exit

Specific options:
-----------------

  -e, --edge=<num>          ignore alignment if reads map to <num> bases at the edge of target sequence (default: 0)
  -c, --count               count number of unique inserts in BAM file (default: false)
  --stats=<string>          {mapped|unmapped|edit|score} only report readcount distribution for specified stats, not read-level stats (default: none)

Description
-----------
Prints summary of alignments in the given BAM/SAM file. By default, it prints
a summary line per alignment entry in the file. The summary is a tab-delimited
line with the following fields:
	qname,aligned_qlen,target_name,glocal_align_len,matches,percent_identity
glocal_align_len includes the unaligned qlen mimicing a global alignment 
in the query and local alignment in target, thus glocal.

With --stats option, summary is consolidated as distribution of read counts
for a given measure. 
   --stats=mapped   - distribution for number of mapped query bases
   --stats=unmapped - distribution for number of unmapped query bases
   --stats=edit     - distribution for edit distances
   --stats=score    - distribution for score=match-edit
```


## Metadata
- **Skill**: generated
