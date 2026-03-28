[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## process\_radtags

This program examines raw reads from an Illumina sequencing run and first, checks that the barcode and the RAD cutsite
are intact, and demultiplexes the data. If there are errors in the barcode or the RAD site within a certain allowance
process\_radtags can correct them. Second, it slides a window down the length of the read and
checks the average quality score within the window. If the score drops below 90% probability of being correct (a raw
phred score of 10), the read is discarded. This allows for some sequencing errors while eliminating reads where the sequence
is degrading as it is being sequenced. By default the sliding window is 15% of the length of the read, but can be specified
on the command line (the threshold and window size can be adjusted). By default,process\_radtags
also looks for poly-G runs at the 3’ end of the reads, which are associated with synthesis termination in two-channel
sequencing platforms. Reads with excess poly-G runs are discarded.

The process\_radtags program can:

* handle data that is barcoded, either inline or using an index, or unbarcoded.
* use combinatorial barcodes.
* check and correct for a restriction enzyme cutsite for single or double-digested data.
* filter adapter sequence while allowing for sequencing error in the adapter pattern.
* process individual files or whole directories of files.
* directly read/write gzipped data
* filter reads based on Illumina’s Chastity filter.
* name output files according to their sample names instead of barcode names, if supplied.
* merge sets of barcodes into a single output file, named for a particular sample.

* For more information on barcode and index types, or how to write a barcodes file, see [this section of the manual](/stacks/manual/index.php#clean).

Below you will find additional information on how to:

1. [Run process\_radtags with Illumina HiSeq data.](#hiseq)
2. [Run process\_radtags with generic FASTQ data.](#generic)

## Program Options

process\_radtags -p in\_dir [-P] [-b barcode\_file] -o out\_dir -e enz [--threads num] [-c] [-q] [-r] [-t len]
process\_radtags -f in\_file [-b barcode\_file] -o out\_dir -e enz [--threads num] [-c] [-q] [-r] [-t len]
process\_radtags --in-path in\_dir [--paired] [--barcodes barcode\_file] --out-path out\_dir --renz-1 enz [--renz-2 enz] [--threads num] [-c] [-q] [-r] [-t len]
process\_radtags -1 pair\_1 -2 pair\_2 [-b barcode\_file] -o out\_dir -e enz [--threads num] [--basename name] [-c] [-q] [-r] [-t len]

* -p,--in-path — path to a directory of files.
* -P,--paired — files contained within the directory are paired.
* -I,--interleaved — specify that the paired-end reads are interleaved in single files.
* -b,--barcodes — path to a file containing barcodes for this run, omit to ignore any barcoding.
* -o,--out-path — path to output the processed files.
* -f — path to the input file if processing single-end sequences.
* -1 — first input file in a set of paired-end sequences.
* -2 — second input file in a set of paired-end sequences.
* --basename — specify the prefix of the output files when using -f or -1/-2.
* --threads — number of threads to run.
* -c,--clean — clean data, remove any read with an uncalled base.
* -q,--quality — discard reads with low quality scores.
* -r,--rescue — rescue barcodes and RAD-Tag cut sites.
* -t,--truncate — truncate final read length to this value.
* -D,--discards — capture discarded reads to a file.

### Barcode options:

* --inline-null: barcode is inline with sequence, occurs only on single-end read (default).
* --index-null: barcode is provded in FASTQ header, occurs only on single-end read.
* --inline-inline: barcode is inline with sequence, occurs on single and paired-end read.
* --index-index: barcode is provded in FASTQ header, occurs on single and paired-end read.
* --inline-index: barcode is inline with sequence on single-end read, occurs in FASTQ header for paired-end read.
* --index-inline: barcode occurs in FASTQ header for single-end read, is inline with sequence on paired-end read.

### Restriction enzyme options:

* -e [enz], --renz-1 [enz]: provide the restriction enzyme used (cut site occurs on single-end read)
* --renz-2 [enz]: if a double digest was used, provide the second restriction enzyme used (cut site occurs on the paired-end read).

  #### Currently supported enzymes include:

  'aciI', 'aclI', 'ageI', 'aluI', 'apaLI', 'apeKI', 'apoI', 'aseI',
  'bamHI', 'bbvCI', 'bfaI', 'bfuCI', 'bgIII', 'bsaHI', 'bspDI', 'bstYI',
  'btgI', 'cac8I', 'claI', 'csp6I', 'ddeI', 'dpnII', 'eaeI', 'ecoRI',
  'ecoRV', 'ecoT22I', 'haeII', 'haeIII', 'hhaI', 'hinP1I', 'hindIII', 'hpaII',
  'hpyCH4IV', 'kpnI', 'mluCI', 'mseI', 'mslI', 'mspI', 'ncoI', 'ndeI',
  'ngoMIV', 'nheI', 'nlaIII', 'notI', 'nsiI', 'nspI', 'pacI', 'pspXI',
  'pstI', 'pstIshi', 'rsaI', 'sacI', 'sau3AI', 'sbfI', 'sexAI', 'sgrAI',
  'speI', 'sphI', 'taqI', 'xbaI', or 'xhoI'

### Protocol-specific options:

* --bestrad: library was generated using BestRAD, check for restriction enzyme on either read and potentially transpose reads.
* --methylrad: library was generated using enzymatic methyl-seq (EM-seq) or bisulphite sequencing.

### Adapter options:

* --adapter-1 [sequence]: provide adaptor sequence that may occur on the single-end read for filtering.
* --adapter-2 [sequence]: provide adaptor sequence that may occur on the paired-read for filtering.
* --adapter-mm [mismatches]: number of mismatches allowed in the adapter sequence.

### Input/Output options:

* -i,--in-type — input file type, either 'fastq', 'gzfastq' (gzipped fastq), 'bam', or 'bustard' (default: guess, or gzfastq if unable to).
* -y,--out-type — output type, either 'fastq', 'gzfastq', 'fasta', or 'gzfasta' (default: match input type).
* --retain-header: retain unmodified FASTQ headers in the output.
* --merge: if no barcodes are specified, merge all input files into a single output file.

### Advanced options:

* --filter-illumina: discard reads that have been marked by Illumina’s chastity/purity filter as failing.
* --disable-rad-check: disable checking if the RAD site is intact.
* --force-poly-g-check: force a check for runs of poly-Gs (default: autodetect based on machine type in FASTQ header).
* --disable-poly-g-check: disable checking for runs of poly-Gs (default: autodetect based on machine type in FASTQ header).
* --encoding — specify how quality scores are encoded, 'phred33' (Illumina 1.8+/Sanger, default) or 'phred64' (Illumina 1.3-1.5).
* --window-size — set the size of the sliding window as a fraction of the read length, between 0 and 1 (default 0.15).
* --score-limit — set the phred score limit. If the average score within the sliding window drops below this value, the read is discarded (default 10).
* --len-limit [limit]: specify a minimum sequence length (useful if your data has already been trimmed).
* --barcode-dist-1: the number of allowed mismatches when rescuing single-end barcodes (default 1).
* --barcode-dist-2: the number of allowed mismatches when rescuing paired-end barcodes (defaults to --barcode-dist-1).

## Example Usage

The process\_radtags program is designed to work on several types of data. The latest
versions of the Illumina analysis pipeline output all reads from the sequencer in a series of FASTQ formatted files. The
FASTQ ID in these files contains a flag as to whether the read passed Illumina’s interal quality filters and may
contain a barcode (or index).

If your data **do not contain barcodes**, simply omit
the barcodes file, and process\_radtags
will place the filtered files in the output directory with the
same name as the input files.

### Illumina HiSeq Data

1. If your data are **single-end, single- or double-digested Illumina HiSeq data**, in a directory called raw:

   ~/raw% ls
   lane3\_NoIndex\_L003\_R1\_001.fastq.gz lane3\_NoIndex\_L003\_R1\_006.fastq.gz lane3\_NoIndex\_L003\_R1\_011.fastq.gz
   lane3\_NoIndex\_L003\_R1\_002.fastq.gz lane3\_NoIndex\_L003\_R1\_007.fastq.gz lane3\_NoIndex\_L003\_R1\_012.fastq.gz
   lane3\_NoIndex\_L003\_R1\_003.fastq.gz lane3\_NoIndex\_L003\_R1\_008.fastq.gz lane3\_NoIndex\_L003\_R1\_013.fastq.gz
   lane3\_NoIndex\_L003\_R1\_004.fastq.gz lane3\_NoIndex\_L003\_R1\_009.fastq.gz
   lane3\_NoIndex\_L003\_R1\_005.fastq.gz lane3\_NoIndex\_L003\_R1\_010.fastq.gz

   Then you can run process\_radtags in the following way:

   % process\_radtags -p ./raw/ -o ./samples/ -b ./barcodes/barcodes\_lane3 \
   -e sbfI -r -c -q

   Note that if your data are double-digested, but only single-end reads were sequenced, then you do not need to specify the second restriction enzyme used.
2. If your data are **paired-end, Illumina HiSeq data**, in a directory called raw:

   ~/raw% ls
   lane4\_NoIndex\_L004\_R1\_001.fastq.gz lane4\_NoIndex\_L004\_R1\_009.fastq.gz lane4\_NoIndex\_L004\_R2\_005.fastq.gz
   lane4\_NoIndex\_L004\_R1\_002.fastq.gz lane4\_NoIndex\_L004\_R1\_010.fastq.gz lane4\_NoIndex\_L004\_R2\_006.fastq.gz
   lane4\_NoIndex\_L004\_R1\_003.fastq.gz lane4\_NoIndex\_L004\_R1\_011.fastq.gz lane4\_NoIndex\_L004\_R2\_007.fastq.gz
   lane4\_NoIndex\_L004\_R1\_004.fastq.gz lane4\_NoIndex\_L004\_R1\_012.fastq.gz lane4\_NoIndex\_L004\_R2\_008.fastq.gz
   lane4\_NoIndex\_L004\_R1\_005.fastq.gz lane4\_NoIndex\_L004\_R2\_001.fastq.gz lane4\_NoIndex\_L004\_R2\_009.fastq.gz
   lane4\_NoIndex\_L004\_R1\_006.fastq.gz lane4\_NoIndex\_L004\_R2\_002.fastq.gz lane4\_NoIndex\_L004\_R2\_010.fastq.gz
   lane4\_NoIndex\_L004\_R1\_007.fastq.gz lane4\_NoIndex\_L004\_R2\_003.fastq.gz lane4\_NoIndex\_L004\_R2\_011.fastq.gz
   lane4\_NoIndex\_L004\_R1\_008.fastq.gz lane4\_NoIndex\_L004\_R2\_004.fastq.gz lane4\_NoIndex\_L004\_R2\_012.fastq.gz

   Then you simply add the -P flag. process\_radtags understands the Illumina naming scheme and will
   figure out how to properly pair the files together:

   % process\_radtags -P -p ./raw/ -o ./samples/ -b ./barcodes/barcodes\_lane4 \
   -e sbfI -r -c -q
3. If your data are **double-digested, paired-end, Illumina HiSeq data using combinatorial barcodes**, in a
   directory called raw:

   ~/raw% ls
   GfddRAD1\_005\_ATCACG\_L007\_R1\_001.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_001.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_002.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_002.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_003.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_003.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_004.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_004.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_005.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_005.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_006.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_006.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_007.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_007.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_008.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_008.fastq.gz
   GfddRAD1\_005\_ATCACG\_L007\_R1\_009.fastq.gz GfddRAD1\_005\_ATCACG\_L007\_R2\_009.fastq.gz

   Then you specify both restriction enzymes using the --renz-1 and --renz-2 flags.
   You must also specify the type combinatorial barcoding used, such as inline/inline, or inline/index, specifying
   the type of barcodes to look for on the single and paired-end read:

   % process\_radtags -P -p ./raw -b ./barcodes/barcodes\_lane4 -o ./samples/ \
   -c -q -r --inline-index --renz-1 nlaIII --renz-2 mluCI

   See below on how to format the barcodes file.
4. If your data **may contain adapter sequence**, and are **Illumina HiSeq data**, in a directory called raw:

   ~/raw% ls
   lane4\_NoIndex\_L004\_R1\_001.fastq.gz lane4\_NoIndex\_L004\_R1\_009.fastq.gz lane4\_NoIndex\_L004\_R2\_005.fastq.gz
   lane4\_NoIndex\_L004\_R1\_002.fastq.gz lane4\_NoIndex\_L004\_R1\_010.fastq.gz lane4\_NoIndex\_L004\_R2\_006.fastq.gz
   lane4\_NoIndex\_L004\_R1\_003.fastq.gz lane4\_NoIndex\_L004\_R1\_011.fastq.gz lane4\_NoIndex\_L004\_R2\_007.fastq.gz
   lane4\_NoIndex\_L004\_R1\_004.fastq.gz lane4\_NoIndex\_L004\_R1\_012.fastq.gz lane4\_NoIndex\_L004\_R2\_008.fastq.gz
   lane4\_NoIndex\_L004\_R1\_005.fastq.gz lane4\_NoIndex\_L004\_R2\_001.fastq.gz lane4\_NoIndex\_L004\_R2\_009.fastq.gz
   lane4\_NoIndex\_L004\_R1\_006.fastq.gz lane4\_NoIndex\_L004\_R2\_002.fastq.gz lane4\_NoIndex\_L004\_R2\_010.fastq.gz
   lane4\_NoIndex\_L004\_R1\_007.fastq.gz lane4\_NoIndex\_L004\_R2\_003.fastq.gz lane4\_NoIndex\_L004\_R2\_011.fastq.gz
   lane4\_NoIndex\_L004\_R1\_008.fastq.gz lane4\_NoIndex\_L004\_R2\_004.fastq.gz lane4\_NoIndex\_L004\_R2\_012.fastq.gz

   Then you specify the the adapter sequence you expext to be present in the front read and optionally the adapter seqeunce expected
   to be present on the paired-end read, and the number of mismatches you want to allow in the adapter sequence (if any):

   % process\_radtags -P -p ./raw/ -o ./samples/ -b ./barcodes/barcodes\_lane4 \
   -e sbfI -r -c -q \
   --adapter-1 GATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG \
   --adapter-2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT \
   --adapter-mm 2

### Generic FASTQ Data

1. If your data are **paired-end** but don’t use the Illumina naming scheme, were renamed,
   or were downloaded from NCBI’s Short Read Archive, you can specify the pairs explicitly. If your data are
   in a directory called raw:

   ~/raw% ls
   Raw\_Rad\_data\_R1.fastq.gz Raw\_Rad\_data\_R2.fastq.gz

   Then you use the -1 and -2 parameters to specify
   a pair of files. If you have multiple pairs of files, you can run process\_radtags
   multiple times (using a shell script) and concatenate the outputs together (or you can concatenate the input files together as well).

   % process\_radtags -1 ./raw/Raw\_Rad\_data\_R1.fastq.gz -2 ./raw/Raw\_Rad\_data\_R2.fastq.gz \
   -o ./samples/ -b ./barcodes/barcodes -e sbfI -r -c -q
2. If your data are **single-end** but don’t use the Illumina naming scheme, were renamed,
   or were downloaded from NCBI’s Short Read Archive, you can specify the single file explicitly. If the file
   is in a directory called raw:

   ~/raw% ls
   rad\_data.fq.gz

   Then you use the -f parameter.

   % process\_radtags -f ./raw/rad\_data.fq -o ./samples/ -b ./barcodes/barcodes -e sbfI -r -c -q

By default, these generic input options (-f for single-end, and -1 and
-2 for paired-end reads) use the name of the input file(s) as the name prefix of all the output
files and logs. The user can provide a specific prefix for all output files using the --basename
option.

## Other Pipeline Programs

|  |  |  |  |
| --- | --- | --- | --- |
| Raw reads  * [process\_radtags](/stacks/comp/process_radtags.php) * [process\_shortreads](/stacks/comp/process_shortreads.php) * [clone\_filter](/stacks/comp/clone_filter.php) * [kmer\_filter](/stacks/comp/kmer_filter.php) | Core  * [ustacks](/stacks/comp/ustacks.php) * [cstacks](/stacks/comp/cstacks.php) * [sstacks](/stacks/comp/sstacks.php) * [tsv2bam](/stacks/comp/tsv2bam.php) * [gstacks](/stacks/comp