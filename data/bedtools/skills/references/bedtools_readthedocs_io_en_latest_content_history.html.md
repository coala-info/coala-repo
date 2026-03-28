### Navigation

* [index](../genindex.html "General Index")
* [next](bedtools-suite.html "The BEDTools suite") |
* [previous](general-usage.html "General usage") |
* [bedtools v2.31.0](../index.html) »

# Release History[¶](#release-history "Permalink to this headline")

## Version 2.30.0 (23-Dec-2021)[¶](#version-2-30-0-23-dec-2021 "Permalink to this headline")

1. Thanks to Hao Hou (github: @38), we have substantial improvements in the speed associated with parsing input files and in printing results. It turns our that these tasks consume a large proportion of run time, especially as input files increase in size. These changes result in a 2-3X improvement in speed, depending on input types, options, etc.
2. Thanks to John Marshall (github: @jmarshall), who improved the stability and cleanliness of the code used for random number generation. These changes also squash a bug that arises on Debian systems.
3. John Marshall cleaned up some lingering data type problems in the slop tool.
4. Thanks to @gringer for adding teh -ignoreD option to the genomecov tool, which allows D CIGAR operations to be ignored when calculating coverage. This is useful for long-read technologies with high INDEL error rates.
5. Added a fix for a [bug](https://github.com/arq5x/bedtools2/issues/865) that did not properly handle the splitting of intervals in BED12 records with one block.
6. Thanks to John Marshall (github: @jmarshall), we have addressed numerical instability issues in the fisher tool.
7. Thanks to Hao Hou (github: @38), reference genomes can be read as an environment variable (CRAM\_REFERENCE) when using CRAM input files.
8. Added a -rna option to the getfasta tool to allow support for RNA genomes.
9. Thanks to Hao Hou (github: @38), we fixed input file format detection bugs arising in ZSH.
10. Thanks to Josh Shapiro (github:@jashapiro) for clarifying a confusing inconcistency in the documentation for the coverage tool.
11. Thanks to Hao Hou (github: @38), we suppressed unnecessary warnings when reading GZIPP’ed files.
12. Thanks to Hao Hou (github: @38), we fixed an overflow bug in the shuffle tool.
13. Thanks to Hao Hou (github: @38), we fixed an data type bug in the shift tool.
14. Thanks to John Marshall (github: @jmarshall) and Hao Hou (github: @38), we have cleaned up the internal support for htslib.

## Version 2.29.2 (17-Dec-2019)[¶](#version-2-29-2-17-dec-2019 "Permalink to this headline")

1. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/803) that mistakenly removed a BAM/CRAM header line (sorting criteria).

## Version 2.29.1 (9-Dec-2019)[¶](#version-2-29-1-9-dec-2019 "Permalink to this headline")

1. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/773) that now allows blocked intersection to be counted based on unique base pairs of overlap. The resolution for [issue 750](https://github.com/arq5x/bedtools2/issues/750) in version 2.29.0 mistakenly allowed for fractional overlap to be counted based upon redundant overlap.
2. Moved to Github Continuous Integration for automatic testing.
3. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/799) that injected erroneous quality values with BAM records had no valid quality values.
4. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/609) that destroyed backwards compatibility in the getfasta tool. Thanks to Torsten Seeman for reporting this.
5. Fixed a corner case [bug](https://github.com/arq5x/bedtools2/issues/711) in the reldist tool.
6. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/788) in the bedtobam tool that caused the last character in read names to be removed.
7. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/779) causing a segfault in the jaccard tool.
8. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/777) causing a corner case issue in the way coordinates are reported in the flank tool.

## Version 2.29.0 (3-Sep-2019)[¶](#version-2-29-0-3-sep-2019 "Permalink to this headline")

1. Added a new -C option to the intersect tool that separately reports the count of intersections observed for each database (-b) file given. Formerly, the -c option reported to sum of all intersections observed across all database files.
2. Fixed an important [bug](https://github.com/arq5x/bedtools2/issues/750) in intersect that prevented some split reads from being counted properly with using the -split option with the -f option.
3. Fixed a bug in shuffle such that shuffled regions should have the same strand as the chose -incl region.
4. Added a new -L option to L`imit the output of the `complement tool to solely the chromosomes that are represented in the -i file.
5. Fixed a regression in the multicov tool introduced in 2.28 that caused incorrect counts.
6. Added support for multi-mapping reads in the bamtofastq tool.
7. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/301) that prevented the “window” tool from properly adding interval “slop” to BAM records.
8. Fixed a [bug](https://github.com/arq5x/bedtools2/issues/195) that caused the slop tool to not truncate an interval’s end coordinate when it overlapped the end of a chromosome.
9. Added support for the “=” and “X” CIGAR operations to bamtobed.
10. Various other minor bug fixes and improvements to documentation.

## Version 2.28.0 (23-Mar-2019)[¶](#version-2-28-0-23-mar-2019 "Permalink to this headline")

1. Included support for htslib to enable CRAM support and long-term stability (Thanks to Hao Hou!)
2. Included support for genomes with large chromosomes by moving to 64-bit integeres throughout the code base. Thanks to Brent Pedersen and John Marshall!
3. We now provide a statically-linked binary for LINUX (not OSX) systems.
4. Various minor bug fixes.

## Version 2.27.0 (6-Dec-2017)[¶](#version-2-27-0-6-dec-2017 "Permalink to this headline")

1. Fixed a big memory leak and algorithmic flaw in the split option. Thanks to Neil Kindlon!
2. Resolved compilation errors on OSX High Sierra. Many thanks to @jonchang!
3. Fixed a bug in the shift tool that caused some intervals to exceed the end of the chromosome. Thanks to @wlholtz
4. Fixed major bug in groupby that prevented proper functionality.
5. Speed improvements to the shuffle tool.
6. Bug fixes to the p-value calculation in the fisher tool. Thanks to Brent Pedersen.
7. Allow BED headers to start with chrom or chr
8. Fixes to the “k-closest” functionality in the closest tool. Thanks to Neil Kindlon.
9. Fixes to the output of the freqasc, freqdesc, distinct\_sort\_num and distinct\_sort, and num\_desc operations in the groupby tool. Thanks to @ghuls.
10. Many minor bug fixes and compilation improvements from Luke Goodsell.
11. Added the -fullHeader option to the maskfasta tool. Thanks to @ghuls.
12. Many bug fixes and performance improvements from John Marshall.
13. Fixed bug in the -N/-f behavior in subtract.
14. Full support for .fai files as genome (-g) files.
15. Many other minor bug fixes and functionality improvements.

## Version 2.26.0 (7-July-2016)[¶](#version-2-26-0-7-july-2016 "Permalink to this headline")

1. Fixed a major memory leak when using `-sorted`. Thanks to Emily Tsang and Stephen Montgomery.
2. Fixed a bug for BED files containing a single record with no newline. Thanks to @jmarshall.
3. Fixed a bug in the contigency table values for thr `fisher` tool.
4. The `getfasta` tool includes name, chromosome and position in fasta headers when the `-name` option is used. Thanks to @rishavray.
5. Fixed a bug that now forces the `coverage` tool to process every record in the `-a` file.
6. Fixed a bug preventing proper processing of BED files with consecutive tabs.
7. VCF files containing structural variants now infer SV length from either the SVLEN or END INFO fields. Thanks to Zev Kronenberg.
8. Resolve off by one bugs when intersecting GFF or VCF files with BED files.
9. The `shuffle` tool now uses roulette wheel sampling to shuffle to `-incl` regions based upon the size of the interval. Thanks to Zev Kronenberg and Michael Imbeault.
10. Fixed a bug in `coverage` that prevented correct calculation of depth when using the `-split` option.
11. The `shuffle` tool warns when an interval exceeds the maximum chromosome length.
12. The `complement` tool better checks intervals against the chromosome lengths.
13. Fixes for `stddev`, `min`, and `max` operations. Thanks to @jmarshall.
14. Enabled `stdev`, `sstdev`, `freqasc`, and `freqdesc` options for `groupby`.
15. Allow `-s` and `-w` to be used in any order for `makewindows`.
16. Added new `-bedOut` option to `getfasta`.
17. The `-r` option forces the `-F` value for `intersect`.
18. Add `-pc` option to the `genomecov` tool, allowing coverage to be calculated based upon paired-end fragments.

## Version 2.25.0 (3-Sept-2015)[¶](#version-2-25-0-3-sept-2015 "Permalink to this headline")

1. Added new -F option that allows one to set the minimum fraction of overlap required for the B interval. This complements the functionality of the -f option.Available for intersect, coverage, map, subtract, and jaccard.
2. Added new -e option that allows one to require that the minimum fraction overlap is achieved in either A \_OR\_ B, not A \_AND\_ B which is the behavior of the -r option. Available for intersect, coverage, map, subtract, and jaccard.
3. Fixed a longstanding bug that prevented genomecov from reporting chromosomes that lack a single interval.
4. Modified a src directory called “aux” to “driver” to prevent compilation errors on Windows machines. Thanks very much to John Marshall.
5. Fixed a regression that caused the coverage tool to complain if BED files had less than 5 columns.
6. Fixed a variable overload bug that prevented compilation on Debian machines.
7. Speedups to the groupby tool.
8. New -delim option for the groupby tool.
9. Fixed a bug in map that prevented strand-specifc overlaps from being reported when using certain BEDPLUS formats.
10. Prevented excessive memory usage when not using pre-sorted input.

## Version 2.24.0 (27-May-2015)[¶](#version-2-24-0-27-may-2015 "Permalink to this headline")

1. The coverage tool now takes advantage of pre-sorted intervals via the -sorted option. This allows the coverage tool to be much faster, use far less memory, and report coverage for intervals in their original order in the input file.
2. We have changed the behavior of the coverage tool such that it is consistent with the other tools. Specifically, coverage is now computed for the intervals in the A file based on the overlaps with the B file, rather than vice versa.
3. The `subtract` tool now supports pre-sorted data via the `-sorted` option and is therefore much faster and scalable.
4. The `-nonamecheck` option provides greater tolerance for chromosome labeling when using the `-sorted` option.
5. Support for multiple SVLEN tags in VCF format, and fixed a bug that failed to process SVLEN tags coming at the end of a VCF INFO field.
6. Support for reverse complementing IUPAC codes in the `getfasta` tool.
7. Provided greater flexibility for “BED+” files, where the first 3 columns are chrom, start, and end, and the remaining columns are free-form.
8. We now detect stale FAI files and recreate an index thanks to a fix from @gtamazian.
9. New feature from Pierre Lindenbaum allowing the `sort` tool to sort files based on the chromosome order in a `faidx` file.
10. Eliminated multiple compilation warnings thanks to John Marshall.
11. Fixed bug in handling INS variants in VCF files.

## Version 2.23.0 (22-Feb-2015)[¶](#version-2-23-0-22-feb-2015 "Permalink to this headline")

1. Added `-k` option to the closest tool to report the k-closest features in one or more -b files.
2. Added `-fd` option to the closest tool to for the reporting of downstream features in one or more -b files. Requires -D to dictate how “downstream” should be defined.
3. Added `-fu` option to the closest tool to for the reporting of downstream features in one or more -b files. Requires -D to dictate how “downstream” should be defined.
4. Pierre Lindenbaum added a new split tool that will split an input file into multiple sub files. Unlike UNIX split, it can balance the chunking of the sub files not just by number of lines, but also by total number of base pairs in each sub file.
5. Added a new spacing tool that reports the distances between features in a file.
6. Jay Hesselberth added a `-reverse` option to the makewindows tool that reverses the order of the assigned window numbers.
7. Fixed a bug that caused incorrect reporting of overlap for zero-length BED records. Thanks to @roryk.
8. Fixed a bug that caused the map tool to not allow `-b` to be specified before `-a`. Thanks to @semenko.
9. Fixed a bug in `makewindows` that mistakenly required `-s` with `-n`.

## Version 2.22.1 (01-Jan-2015)[¶](#version-2-22-1-01-jan-2015 "Permalink to this headline")

1. When using -sorted with intersect, map, and closest, bedtools can now detect and warn you when your input datasets employ different chromosome sorting orders.
2. Fixed multiple bugs in the new, faster closest tool. Specifically, the -iu, -id, and -D options were not behaving properly with the new “sweeping” algorithm that was implemented for the 2.22.0 release. Many thanks to Sol Katzman for reporting these issues and for providing a detailed analysis and example files.
3. We FINALLY wrote proper documentation for the closest tool (<http://bedtools.readthedocs.org/en/latest/content/tools/closest.html>)
4. Fixed bug in the tag tool when using -intervals, -names, or -scores. Thanks to Yarden Katz for reporting this.
5. Fixed issues with chromosome boundaries in the slop tool when using negative distances. Thanks to @acdaugherty!
6. Multiple improvements to the fisher tool. Added a -m option to the fisher tool to merge overlapping intervals prior to comparing overlaps between two input files. Thanks to@brentp
7. Fixed a bug in makewindows tool requiring the use of -b with -s.
8. Fixed a bug in intersect that prevented -split from detecting complete overlaps with -f 1. Thanks to @tleonardi .
9. Restored the default decimal precision to the groupby tool.
10. Added the -prec option to the merge and map tools to specific the decimal precision of the output.

## Version 2.22.0 (12-Nov-2014)[¶](#version-2-22-0-12-nov-2014 "Permalink to this headline")

1. The “closest” tool now requires sorted files, but this requirement now enables it to simultaneously find the closest intervals from many (not just one) files.
2. We now have proper support for “imprecise” SVs in VCF format. This addresses a long standing (sorry) limitation in the way bedtools handles VCF files.

## Version 2.21.0 (18-Sep-2014)[¶](#version-2-21-0-18-sep-2014 "Permalink to this headline")

1. Added ability to intersect against multiple -b files in the intersect tool.
2. Fixed a bug causing slowdowns in the -sorted option when using -split with very large split alignments.
3. Added a new fisher tool to report a P-value associated with the significance of the overlaps between two in