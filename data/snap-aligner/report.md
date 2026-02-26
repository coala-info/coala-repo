# snap-aligner CWL Generation Report

## snap-aligner_index

### Tool Description
Build an index for the SNAP aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/snap-aligner:2.0.5--h077b44d_2
- **Homepage**: http://snap.cs.berkeley.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/snap-aligner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snap-aligner/overview
- **Total Downloads**: 105.7K
- **Last updated**: 2025-09-17
- **GitHub**: https://github.com/amplab/snap
- **Stars**: N/A
### Original Help Text
```text
Welcome to SNAP version 2.0.5.

Usage: snap-aligner index <input.fa> <output-dir> [<options>]
Options:
 -s                Seed size (default: 24)
 -h                Hash table slack (default: 0.3)
 -t                Specify the maximum number of threads to use. Default is the number of cores. Do not leave a space after the -t, e.g., -t16
 -B<chars>         Specify characters to use as chromosome name terminators in the FASTA header line; these characters and anything after are
                   not part of the chromosome name.  You must specify all characters on a single -B switch.  So, for example, with -B_|,
                   the FASTA header line '>chr1|Chromosome 1' would generate a chromosome named 'chr1'.  There's a separate flag for
                   indicating that a space is a terminator.
 -bSpace           Indicates that the space and tab characters are terminators for chromosome names (see -B above).  This may be used in addition
                   to other terminators specified by -B.  -B and -bSpace are case sensitive.  This is the default.
 -bSpace-          Indicates that space and tab characters should be included in chromosome names.
 -p                Specify the number of Ns to put as padding between chromosomes.  This must be as large as the largest
                   edit distance you'll ever use, and there's a performance advantage to have it be bigger than any
                   read you'll process or gap between paired-end reads.  Default is 2000.  Specify the amount of padding directly after -p without a space.
 -H                Build a histogram of seed popularity.  This is just for information, it's not used by SNAP.
                   Specify the histogram file name directly after -H without leaving a space.
 -exact            Compute hash table sizes exactly.  This will slow down index build, but usually will result in smaller indices.
 -keysize          The number of bytes to use for the hash table key.  Larger values increase SNAP's memory footprint, but allow larger seeds.
                   By default it's autoselected based on the seed size.
 -large            Build a larger index that's a little faster, particularly for runs with quick/inaccurate parameters.  Increases index size by
                   about 30%, depending on the other index parameters and the contents of the reference genome
 -locationSize     The size of the genome locations stored in the index.  This can be from 4 to 8 bytes.  The locations need to be big enough
                   not only to index the genome, but also to allow some space for representing seeds that occur multiple times.  For the
                   human genome, it will fit with four byte locations if the seed size is 20 or larger, but needs 5 (or more) for smaller
                   seeds.  Making the location size bigger than necessary will just waste (lots of) space, so unless you're doing something
                   quite unusual, the right answer is 4 or 5.  Default is based on seed size: 4 if it's 20 or greater, 5 otherwise.
 -sm               Use a temp file to work better in smaller memory.  This only helps a little, but can be the difference if you're close.
                   In particular, this will generally use less memory than the index will use once it's built, so if this doesn't work you
                   won't be able to use the index anyway. However, if you've got sufficient memory to begin with, this option will just
                   slow down the index build by doing extra, useless IO.
 -AutoAlt-         Don't automatically mark ALT contigs.  Otherwise, any contig whose name ends in '_alt' (regardless of captialization) or starts
                   with HLA- will be marked ALT.  Others will not.
 -maxAltContigSize Specify a size at or below which all contigs are automatically marked ALT, unless overridden by name using the args below
 -altContigName    Specify the (case independent) name of an alt to mark a contig.  You can supply this parameter as often as you'd like
 -altContigFile    Specify the name of a file with a list of alt contig names, one per line.  You may specify this as often as you'd like
 -nonAltContigName Specify the name of a contig that's not an alt, regardless of its size
 -nonAltContigFile Specify the name of a file that contains a list of contigs (one per line) that will not be marked ALT regardless of size
 -altLiftoverFile  Specify the file containing ALT-to-REF mappings (SAM format). e.g., hs38DH.fa.alt from bwa-kit
 -q                Quiet mode: don't print status messages (other than the welcome message which is printed prior to parsing args).  Error messages
                   are still printed.
 -qq               Super quiet mode: don't print status or error messages
```


## snap-aligner_single

### Tool Description
Aligns reads to a SNAP index.

### Metadata
- **Docker Image**: quay.io/biocontainers/snap-aligner:2.0.5--h077b44d_2
- **Homepage**: http://snap.cs.berkeley.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/snap-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Welcome to SNAP version 2.0.5.

Too few parameters
Usage: 
snap-aligner single <index-dir> <inputFile(s)> [<options>] where <input file(s)> is a list of files to process.

Options:
  -o   filename  output alignments to filename in SAM or BAM format, depending on the file extension or
       explicit type specifier (see below).  Use a dash with an explicit type specifier to write to
       stdout, so for example -o -sam - would write SAM output to stdout
  -d   maximum edit distance allowed per read or pair absent indels (default: 27)
  -i   maximum distance allowed per read for indels (default: 40)
  -n   number of seeds to use per read
  -sc  Seed coverage (i.e., readSize/seedSize).  Floating point.  Exclusive with -n.  (default uses -n)
  -h   maximum hits to consider per seed (default: 300)
  -ms  minimum seed matches per location (default: 1)
  -t   number of threads (default is one per core)
  -b-  Don't bind each thread to its processor (--b (with two dashes) does the smae thing)
  -P   disables cache prefetching in the genome; may be helpful for machines
       with small caches or lots of cores/cache
  -so  sort output file by alignment location
  -sm  memory to use for sorting in Gbytes.  Default is 1 Gbyte/thread.
 -sid  Specifies the sort intermediate directory.  When SNAP is sorting, it aligns the reads in the order in which they come in, and writes
       the aligned reads in batches to a temporary file.  When the aligning is done, it does a merge sort from the temporary file into the
       final output file.  By default, the intermediate file is in the same directory as the output file, but for performance or space
       reasons, you might want to put it elsewhere.  If so, use this option.
  -x   explore some hits of overly popular seeds (useful for filtering)
  -S   suppress additional processing (sorted BAM output only)
       i=index, d=duplicate marking
  -f   stop on first match within edit distance limit (filtering mode, single-end only)
  -F   filter output (a=aligned only, s=single hit only (MAPQ >= 10), u=unaligned only, l=long enough to align (see -mrl))
  -E   an alternate (and fully general) way to specify filter options.  Emit only these types s = single hit (MAPQ >= 10), m = multiple hit (MAPQ < 10),
       x = not long enough to align, u = unaligned, b = filter must apply to both ends of a paired-end read.  Combine the letters after
       -E, so for example -E smu will emit all reads that aren't too short/have too many Ns (because it leaves off l).  -E smx is the same
       as -F a, -E ux is the same as -F u, and so forth.
       When filtering in paired-end mode (either with -F or -E) unless you specify the b flag a read will be emitted if it's mate pair passes the filter
       Even if the read itself does not.  If you specify b mode, then a read will be emitted only if it and its partner both pass the filter.
  -I   ignore IDs that don't match in the paired-end aligner
 -Cxx  must be followed by two + or - symbols saying whether to clip low-quality
       bases from front and back of read respectively; default: back only (-C-+)
 -cc   Specifies the min and max quality score to clip in Phred 33 format.  Must be followed by
       two characters.  The default is ##.
 -=    use the new style CIGAR strings with = and X rather than M.  The opposite of -M
 -pf   specify the name of a file to contain the run speed
 -hp   Indicates to use huge pages (this may speed up alignment and slow down index load).
 -D    Specifies the extra search depth (the edit distance beyond the best hit that SNAP uses to compute MAPQ).  Default 1
 -rg   Specify the default read group if it is not specified in the input file
 -R    Specify the entire read group line for the SAM/BAM output.  This must include an ID tag.  If it doesn't start with
       '@RG' SNAP will add that.  Specify tabs by \t.  Two backslashes will generate a single backslash.
       backslash followed by anything else is illegal.  So, '-R @RG\tID:foo\tDS:my data' would generate reads
       with default tag foo, and an @RG line that also included the DS:my data field.
 -sa   Include reads from SAM or BAM files with the secondary (0x100) or supplementary (0x800) flag set; default is to drop them.
 -om   Output multiple alignments.  Takes as a parameter the maximum extra edit distance relative to the best alignment
       to allow for secondary alignments
 -omax Limit the number of alignments per read generated by -om.  This means that if -om would generate more
       than -omax secondary alignments, SNAP will write out only the best -omax of them, where 'best' means
       'with the lowest edit distance'.  Ties are broken arbitrarily.
 -mpc  Limit the number of alignments generated by -om to this many per contig (chromosome/FASTA entry);
       'mpc' means 'max per contig; default unlimited.  This filter is applied prior to -omax.  The primary alignment
       is counted.
 -pc   Preserve the soft clipping for reads coming from SAM or BAM files
 -xf   Increase expansion factor for BAM and GZ files (default 1.0)
 -hdp  Use Hadoop-style prefixes (reporter:status:...) on error messages, and emit hadoop-style progress messages
 -mrl  Specify the minimum read length to align, reads shorter than this (after clipping) stay unaligned.  This should be
       a good bit bigger than the seed length or you might get some questionable alignments.  Default 50
 -map  Use file mapping to load the index rather than reading it.  This might speed up index loading in cases
       where SNAP is run repatedly on the same index, and the index is larger than half of the memory size
       of the machine.  On some operating systems, loading an index with -map is much slower than without if the
       index is not in memory.  You might consider adding -pre to prefetch the index into system cache when loading
       with -map when you don't expect the index to be in cache.  This is the default
 -map- Do not map the index, read it using standard read/write calls.
 -pre  Prefetch the index into system cache.  This is only meaningful with -map, and only helps if the index is not
       already in memory and your operating system is slow at reading mapped files (i.e., some versions of Linux,
       but not Windows).  This is the default on Linux.
 -pre- Do not prefetch the index into system cache.  This is the default on Windows.
 -lp   Run SNAP at low scheduling priority (Only implemented on Windows)
 -nu   No Ukkonen: don't reduce edit distance search based on prior candidates. This option is purely for
       evaluating the performance effect of using Ukkonen's algorithm rather than Smith-Waterman, and specifying
       it will slow down execution without improving the alignments.
 -no   No Ordering: don't order the evalutation of potential alignments so as to select more likely candidates first.  This option
       is purely for evaluating the performance effect of the read evaluation order, and specifying it will slow
       down execution without improving alignments.
 -nt   Don't truncate searches based on missed seed hits.  This option is purely for evaluating the performance effect
       of candidate truncation, and specifying it will slow down execution without improving alignments.
 -ne   Don't try edit distance scoring before doing affine gap.  This option is to evaluate the aligner and isn't
       intended to be used for ordinary alignments.  It turns off normal affine gap scoring (like -G-) and so will
       have significant effects on the alignment results.
 -nb   Don't use the banded affine gap optimization.  This option is to evaluate the aligner and will just
       result in slower alignments.
 -wbs  Write buffer size in megabytes.  Don't specify this unless you've gotten an error message saying to make it bigger.  Default 16.
  -di  Drop the index after aligning and before sorting.  This frees up memory for the sort at the expense of not having the index loaded for your next run.
 -kts  Kill if too slow.  Monitor our progress and kill ourself if we're not moving fast enough.  This is intended for use on machines
       with limited memory, where some alignment tasks will push SNAP into paging, and take disproportinaltely long.  This allows the script
       to move on to the next alignment.  Only works when generating output, and not during the sort phase.  If you're running out of memory
       sorting, try using -di.
 -pro  Profile alignment to give you an idea of how much time is spent aligning and how much waiting for IO
 -proAg Profile affine-gap scoring to show how often it forces single-end alignment
 -ae   Apply the end-of-contig soft clipping before the -om processing rather than after it.  A read that's soft clipped because of hanging off one end or the other
       of a contig does not have a penalty in its NM tag, but it does in SNAP's internal scoring.  This flag says to use the NM value for -om processing
       rather than SNAP's internal score.
 -is   Write SNAP's internal score for an alignment into the output.  The value following -is specifies the tag to use, and must be a two letter
       value starting with X, Y or Z.  So, -is ZQ will cause SNAP to write ZQ:i:3 on a read with internal score 3.  Generally, the internal scores
       are the same as the NM values, except that they contain penalties for soft clipping reads that hang over the end of contigs (but not for
       soft clipping that's due to # quality scores or that was present in the input SAM/BAM file and retained due to -pc)
 -G-   disable affine gap scoring
       Affine gap scoring parameters (works only when -G- is not used):
 -gm   cost for match (default: 1)
 -gs   cost for substitution (default: 4)
 -go   cost for opening a gap (default: 6)
 -ge   cost for extending a gap (default: 1)
 -g5   bonus for alignment reaching 5' end of read (default: 10)
 -g3   bonus for alignment reaching 3' end of read (default: 7)

 -A-   Disable ALT awareness.  The default is to try to map reads to the primary assembly and only to choose ALT alignments when they're much better,
       and to compute MAPQ for non-ALT alignments using only non-ALT hits. This flag disables that behavior and results in ALT-oblivious behavior.
 -ea   Emit ALT alignments.  When the aligner is ALT aware (i.e., -A- isn't specified) if it finds an ALT alignment that would have been
       the primary alignment if -A- had been specified but isn't without -A-, SNAP will emit the read with the supplementary alignment
       flag set and MAPQ computed across all potential mappings, both primary and ALT
 -asg  Maximum score gap to prefer a non-ALT alignment.  If the best non-ALT alignment is more than this much worse than the best ALT alignment
       emit the ALT alignment as the primary result rather than as a supplementary result. (default: 64)
 -fmb  Force MAPQ below this value to zero.  By the strict definition of MAPQ a read with two equally good alignments should have MAPQ 3
       Other aligners, however, will score these alignments at MAPQ 0 and some variant callers depend on that behavior.  Setting this will
       force any MAPQ value at or below the parameter value to zero.  (default:3)
 -hc   Enable SNAP mode optimized for use with GATK HaplotypeCaller.
 -hc-  Turn off optimizations specific to GATK HaplotypeCaller (e.g., when using the DRAGEN variant caller on SNAP aligned output)
       In this mode, when a read (or pair) doesn't align, try soft clipping the read (or pair) to find an alignment.  This is the default.
 -at   Attach AT:i: tags to each read showing the alignment time in microseconds.  For paired-end reads this is the time for the pair.
 -pfc  Preserve FASTQ comments.  Anything after the first white space on the FASTQ ID line is appended to the SAM/BAM line.  If this is not
       in valid SAM/BAM format it will produce incorrect output.
 -q    Quiet mode: don't print status messages (other than the welcome message which is printed prior to parsing args).  Error messages
       are still printed.
 -qq   Super quiet mode: don't print status or error messages.


You may process more than one alignment without restarting SNAP, and if possible without reloading
the index.  In order to do this, list on the command line all of the parameters for the first
alignment, followed by a comma (separated by a space from the other parameters) followed by the
parameters for the next alignment (including single or paired).  You may have as many of these
as you please.  If two consecutive alignments use the same index, it will not be reloaded.
So, for example, you could do 'snap-aligner single hg19-20 foo.fq -o foo.sam , paired hg19-20 end1.fq end2.fq -o paired.sam'
and it would not reload the index between the single and paired alignments.
SNAP doesn't parse the options for later runs until the earlier ones have completed, so if you make
an error in one, it may take a while for you to notice.  So, be careful (or check back shortly after
you think each run will have completed).

When specifying an input or output file, you can simply list the filename, in which case
SNAP will infer the type of the file from the file extension (.sam or .bam for example),
or you can explicitly specify the file type by preceding the filename with one of the
 following type specifiers (which are case sensitive):
    -fastq
    -compressedFastq
    -sam
    -bam
    -pairedFastq
    -pairedInterleavedFastq
    -pairedCompressedInterleavedFastq

So, for example, you could specify -bam input.file to make SNAP treat input.file as a BAM file,
even though it would ordinarily assume a FASTQ file for input or a SAM file for output when it
doesn't recoginize the file extension.
In order to use a file name that begins with a '-' and not have SNAP treat it as a switch, you must
explicitly specify the type.  But really, that's just confusing and you shouldn't do it.
Input and output may also be from/to stdin/stdout. To do that, use a - for the input or output file
name and give an explicit type specifier.  So, for example, 
snap-aligner single myIndex -fastq - -o -sam -
would read FASTQ from stdin and write SAM to stdout.
```


## snap-aligner_paired

### Tool Description
Align paired-end reads using SNAP.

### Metadata
- **Docker Image**: quay.io/biocontainers/snap-aligner:2.0.5--h077b44d_2
- **Homepage**: http://snap.cs.berkeley.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/snap-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Welcome to SNAP version 2.0.5.

Too few parameters
Usage: 
snap-aligner paired <index-dir> <inputFile(s)> [<options>] where <input file(s)> is a list of files to process.

Options:
  -o   filename  output alignments to filename in SAM or BAM format, depending on the file extension or
       explicit type specifier (see below).  Use a dash with an explicit type specifier to write to
       stdout, so for example -o -sam - would write SAM output to stdout
  -d   maximum edit distance allowed per read or pair absent indels (default: 27)
  -i   maximum distance allowed per read for indels (default: 40)
  -n   number of seeds to use per read
  -sc  Seed coverage (i.e., readSize/seedSize).  Floating point.  Exclusive with -n.  (default uses -n)
  -h   maximum hits to consider per seed (default: 300)
  -ms  minimum seed matches per location (default: 1)
  -t   number of threads (default is one per core)
  -b-  Don't bind each thread to its processor (--b (with two dashes) does the smae thing)
  -P   disables cache prefetching in the genome; may be helpful for machines
       with small caches or lots of cores/cache
  -so  sort output file by alignment location
  -sm  memory to use for sorting in Gbytes.  Default is 1 Gbyte/thread.
 -sid  Specifies the sort intermediate directory.  When SNAP is sorting, it aligns the reads in the order in which they come in, and writes
       the aligned reads in batches to a temporary file.  When the aligning is done, it does a merge sort from the temporary file into the
       final output file.  By default, the intermediate file is in the same directory as the output file, but for performance or space
       reasons, you might want to put it elsewhere.  If so, use this option.
  -x   explore some hits of overly popular seeds (useful for filtering)
  -S   suppress additional processing (sorted BAM output only)
       i=index, d=duplicate marking
  -f   stop on first match within edit distance limit (filtering mode, single-end only)
  -F   filter output (a=aligned only, s=single hit only (MAPQ >= 10), u=unaligned only, l=long enough to align (see -mrl))
  -E   an alternate (and fully general) way to specify filter options.  Emit only these types s = single hit (MAPQ >= 10), m = multiple hit (MAPQ < 10),
       x = not long enough to align, u = unaligned, b = filter must apply to both ends of a paired-end read.  Combine the letters after
       -E, so for example -E smu will emit all reads that aren't too short/have too many Ns (because it leaves off l).  -E smx is the same
       as -F a, -E ux is the same as -F u, and so forth.
       When filtering in paired-end mode (either with -F or -E) unless you specify the b flag a read will be emitted if it's mate pair passes the filter
       Even if the read itself does not.  If you specify b mode, then a read will be emitted only if it and its partner both pass the filter.
  -I   ignore IDs that don't match in the paired-end aligner
 -Cxx  must be followed by two + or - symbols saying whether to clip low-quality
       bases from front and back of read respectively; default: back only (-C-+)
 -cc   Specifies the min and max quality score to clip in Phred 33 format.  Must be followed by
       two characters.  The default is ##.
 -=    use the new style CIGAR strings with = and X rather than M.  The opposite of -M
 -pf   specify the name of a file to contain the run speed
 -hp   Indicates to use huge pages (this may speed up alignment and slow down index load).
 -D    Specifies the extra search depth (the edit distance beyond the best hit that SNAP uses to compute MAPQ).  Default 1
 -rg   Specify the default read group if it is not specified in the input file
 -R    Specify the entire read group line for the SAM/BAM output.  This must include an ID tag.  If it doesn't start with
       '@RG' SNAP will add that.  Specify tabs by \t.  Two backslashes will generate a single backslash.
       backslash followed by anything else is illegal.  So, '-R @RG\tID:foo\tDS:my data' would generate reads
       with default tag foo, and an @RG line that also included the DS:my data field.
 -sa   Include reads from SAM or BAM files with the secondary (0x100) or supplementary (0x800) flag set; default is to drop them.
 -om   Output multiple alignments.  Takes as a parameter the maximum extra edit distance relative to the best alignment
       to allow for secondary alignments
 -omax Limit the number of alignments per read generated by -om.  This means that if -om would generate more
       than -omax secondary alignments, SNAP will write out only the best -omax of them, where 'best' means
       'with the lowest edit distance'.  Ties are broken arbitrarily.
 -mpc  Limit the number of alignments generated by -om to this many per contig (chromosome/FASTA entry);
       'mpc' means 'max per contig; default unlimited.  This filter is applied prior to -omax.  The primary alignment
       is counted.
 -pc   Preserve the soft clipping for reads coming from SAM or BAM files
 -xf   Increase expansion factor for BAM and GZ files (default 1.0)
 -hdp  Use Hadoop-style prefixes (reporter:status:...) on error messages, and emit hadoop-style progress messages
 -mrl  Specify the minimum read length to align, reads shorter than this (after clipping) stay unaligned.  This should be
       a good bit bigger than the seed length or you might get some questionable alignments.  Default 50
 -map  Use file mapping to load the index rather than reading it.  This might speed up index loading in cases
       where SNAP is run repatedly on the same index, and the index is larger than half of the memory size
       of the machine.  On some operating systems, loading an index with -map is much slower than without if the
       index is not in memory.  You might consider adding -pre to prefetch the index into system cache when loading
       with -map when you don't expect the index to be in cache.  This is the default
 -map- Do not map the index, read it using standard read/write calls.
 -pre  Prefetch the index into system cache.  This is only meaningful with -map, and only helps if the index is not
       already in memory and your operating system is slow at reading mapped files (i.e., some versions of Linux,
       but not Windows).  This is the default on Linux.
 -pre- Do not prefetch the index into system cache.  This is the default on Windows.
 -lp   Run SNAP at low scheduling priority (Only implemented on Windows)
 -nu   No Ukkonen: don't reduce edit distance search based on prior candidates. This option is purely for
       evaluating the performance effect of using Ukkonen's algorithm rather than Smith-Waterman, and specifying
       it will slow down execution without improving the alignments.
 -no   No Ordering: don't order the evalutation of potential alignments so as to select more likely candidates first.  This option
       is purely for evaluating the performance effect of the read evaluation order, and specifying it will slow
       down execution without improving alignments.
 -nt   Don't truncate searches based on missed seed hits.  This option is purely for evaluating the performance effect
       of candidate truncation, and specifying it will slow down execution without improving alignments.
 -ne   Don't try edit distance scoring before doing affine gap.  This option is to evaluate the aligner and isn't
       intended to be used for ordinary alignments.  It turns off normal affine gap scoring (like -G-) and so will
       have significant effects on the alignment results.
 -nb   Don't use the banded affine gap optimization.  This option is to evaluate the aligner and will just
       result in slower alignments.
 -wbs  Write buffer size in megabytes.  Don't specify this unless you've gotten an error message saying to make it bigger.  Default 16.
  -di  Drop the index after aligning and before sorting.  This frees up memory for the sort at the expense of not having the index loaded for your next run.
 -kts  Kill if too slow.  Monitor our progress and kill ourself if we're not moving fast enough.  This is intended for use on machines
       with limited memory, where some alignment tasks will push SNAP into paging, and take disproportinaltely long.  This allows the script
       to move on to the next alignment.  Only works when generating output, and not during the sort phase.  If you're running out of memory
       sorting, try using -di.
 -pro  Profile alignment to give you an idea of how much time is spent aligning and how much waiting for IO
 -proAg Profile affine-gap scoring to show how often it forces single-end alignment
 -ae   Apply the end-of-contig soft clipping before the -om processing rather than after it.  A read that's soft clipped because of hanging off one end or the other
       of a contig does not have a penalty in its NM tag, but it does in SNAP's internal scoring.  This flag says to use the NM value for -om processing
       rather than SNAP's internal score.
 -is   Write SNAP's internal score for an alignment into the output.  The value following -is specifies the tag to use, and must be a two letter
       value starting with X, Y or Z.  So, -is ZQ will cause SNAP to write ZQ:i:3 on a read with internal score 3.  Generally, the internal scores
       are the same as the NM values, except that they contain penalties for soft clipping reads that hang over the end of contigs (but not for
       soft clipping that's due to # quality scores or that was present in the input SAM/BAM file and retained due to -pc)
 -G-   disable affine gap scoring
       Affine gap scoring parameters (works only when -G- is not used):
 -gm   cost for match (default: 1)
 -gs   cost for substitution (default: 4)
 -go   cost for opening a gap (default: 6)
 -ge   cost for extending a gap (default: 1)
 -g5   bonus for alignment reaching 5' end of read (default: 10)
 -g3   bonus for alignment reaching 3' end of read (default: 7)

 -A-   Disable ALT awareness.  The default is to try to map reads to the primary assembly and only to choose ALT alignments when they're much better,
       and to compute MAPQ for non-ALT alignments using only non-ALT hits. This flag disables that behavior and results in ALT-oblivious behavior.
 -ea   Emit ALT alignments.  When the aligner is ALT aware (i.e., -A- isn't specified) if it finds an ALT alignment that would have been
       the primary alignment if -A- had been specified but isn't without -A-, SNAP will emit the read with the supplementary alignment
       flag set and MAPQ computed across all potential mappings, both primary and ALT
 -asg  Maximum score gap to prefer a non-ALT alignment.  If the best non-ALT alignment is more than this much worse than the best ALT alignment
       emit the ALT alignment as the primary result rather than as a supplementary result. (default: 64)
 -fmb  Force MAPQ below this value to zero.  By the strict definition of MAPQ a read with two equally good alignments should have MAPQ 3
       Other aligners, however, will score these alignments at MAPQ 0 and some variant callers depend on that behavior.  Setting this will
       force any MAPQ value at or below the parameter value to zero.  (default:3)
 -hc   Enable SNAP mode optimized for use with GATK HaplotypeCaller.
 -hc-  Turn off optimizations specific to GATK HaplotypeCaller (e.g., when using the DRAGEN variant caller on SNAP aligned output)
       In this mode, when a read (or pair) doesn't align, try soft clipping the read (or pair) to find an alignment.  This is the default.
 -at   Attach AT:i: tags to each read showing the alignment time in microseconds.  For paired-end reads this is the time for the pair.
 -pfc  Preserve FASTQ comments.  Anything after the first white space on the FASTQ ID line is appended to the SAM/BAM line.  If this is not
       in valid SAM/BAM format it will produce incorrect output.
 -q    Quiet mode: don't print status messages (other than the welcome message which is printed prior to parsing args).  Error messages
       are still printed.
 -qq   Super quiet mode: don't print status or error messages.


You may process more than one alignment without restarting SNAP, and if possible without reloading
the index.  In order to do this, list on the command line all of the parameters for the first
alignment, followed by a comma (separated by a space from the other parameters) followed by the
parameters for the next alignment (including single or paired).  You may have as many of these
as you please.  If two consecutive alignments use the same index, it will not be reloaded.
So, for example, you could do 'snap-aligner single hg19-20 foo.fq -o foo.sam , paired hg19-20 end1.fq end2.fq -o paired.sam'
and it would not reload the index between the single and paired alignments.
SNAP doesn't parse the options for later runs until the earlier ones have completed, so if you make
an error in one, it may take a while for you to notice.  So, be careful (or check back shortly after
you think each run will have completed).

When specifying an input or output file, you can simply list the filename, in which case
SNAP will infer the type of the file from the file extension (.sam or .bam for example),
or you can explicitly specify the file type by preceding the filename with one of the
 following type specifiers (which are case sensitive):
    -fastq
    -compressedFastq
    -sam
    -bam
    -pairedFastq
    -pairedInterleavedFastq
    -pairedCompressedInterleavedFastq

So, for example, you could specify -bam input.file to make SNAP treat input.file as a BAM file,
even though it would ordinarily assume a FASTQ file for input or a SAM file for output when it
doesn't recoginize the file extension.
In order to use a file name that begins with a '-' and not have SNAP treat it as a switch, you must
explicitly specify the type.  But really, that's just confusing and you shouldn't do it.
Input and output may also be from/to stdin/stdout. To do that, use a - for the input or output file
name and give an explicit type specifier.  So, for example, 
snap-aligner single myIndex -fastq - -o -sam -
would read FASTQ from stdin and write SAM to stdout.

  -s   min and max spacing to allow between paired ends (default: 0 1000).
       If it can't find an alignment in that range, it will run both reads
       through  the single-end aligner.
  -ins Infer inter-read spacing by periodially looking at the observed distances
  -fs  force spacing to lie between min and max.
  -H   max hits for intersecting aligner (default: 4000).
  -mcp specifies the maximum candidate pool size (An internal data structure. 
       Only increase this if you get an error message saying to do so. If you're running
       out of memory, you may want to reduce it.  Default: 1000000)
  -F b additional option to -F to require both mates to satisfy filter (default is just one)
       If you specify -F b together with one of the other -F options, -F b MUST be second
  -ku  Keep unpaired-looking reads in SAM/BAM input.  Ordinarily, if a read doesn't specify
       mate information (RNEXT field is * and/or PNEXT is 0) then the code that matches reads will immdeiately
       discard it.  Specifying this flag may cause large memory usage for some input files,
       but may be necessary for some strangely formatted input files.  You'll also need to specify this
       flag for SAM/BAM files that were aligned by a single-end aligner.
  -N   max seeds when falling back to the single-end mode when doing paired-end. Default: 25
  -en  min edit distance for a read aligned as non-ALT by the paired-end aligner to be reconsidered
       for a better alignment by the single-end aligner. Default: 3
  -es  min total edit distance by which a read pair aligned as ALT needs to be better than non-ALT alignments
       to skip single-end realignment. Default: 3
  -eg  min affine gap score improvement needed for single-end alignments to be considered over
       paired-end alignments. Default: 24
  -eh  perform Hamming distance scoring to try and map reads that cannot be mapped by both the paired-end
       and the single-end aligner.  This is the default.
 -eh-  Do not perform Hamming distance scoring to try and map reads that cannot be mapped by both the paired-end
       and the single-end aligner.
```


## Metadata
- **Skill**: generated
