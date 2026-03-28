![](img/qualimap_logo_small.png)
Evaluating next generation
sequencing alignment data

## Version History

### Version 2.3 - May 19, 2023

[qualimap\_v2.3.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.3.zip)

Changes:

* BAM QC: include support in region text report* Allow 3-column BED file parsing (suggested by Alex Peltzer)* BAM QC: report secondary alignments and ignore them from main coverage analysis (reported by Sonia Agrawal)* BAM QC: fix Ns collection from RNA-seq alignment (reported by C. Ruckert)* BAM QC: fix counts of supplementary alignemnts (reporeted by Alexander Seitz)* Adjust Qualimap non-zero code return (implemented by Valentin Krasontovitsch)* BAM QC: fix issue with plotting from OpenJDK (reported by Adrian Garcia Moreno)* RNA-seq QC: fix error reports for missing chromosomes* Multi BAM QC: fix OpenJDK issue (reported by Marcel Kucharik and Michal Lichvar)* BAM QC: fix reverse strand specificity issue (reported by Florian Pflug)* BAM QC: add coverage std to text report* RNA-seq QC: add settings control for 5'-3' bias comptuation (suggestion from Ryoji Amamoto)* BAM QC: allow set maxium coverage size in zoom-in histogram* BAM QC: add option to control maximum duplication rate in the plot (suggestion from Xiao Lei)* CountsQC: Added header detection ( implemented by Viktor Horvath)* BAM QC: add hg38 for GC content inspection

### Version 2.2.1 - October 4, 2016

[qualimap\_v2.2.1.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip)

[qualimap\_v2.2.1\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1_src.zip)

Changes:

* BAM QC: fixed issue with paired-end reads only singletons (reported by Anrold Liao)* BAM QC: adapted novel SAM flag for multiple alignment segments ( reported by Alexis Groppi)* BAM QC: fixed issue with mapping quality report inside regions (reported by Teresa Requena)* BAM QC: added support for counting Ns in read alignments* BAM QC: fixed issue with chromosome limit in coverage plot* RNA-seq QC: strand-specificity is estimated in case default non-strand-specific protocol stated in the settings* RNA-seq QC: fixed problem with incorrect BAM records* RNA-seq QC: number of correctly marked reads without proper pair reported in a single warning* Allowed names with spaces in provided file/folder path for analysis* Multi-BAM QC: include strand specificity option for estimation of valid strand reads in each BAM QC report

### Version 2.2 - January 29, 2016

[qualimap\_v2.2.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.zip)

[qualimap\_v2.2\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2_src.zip)

Changes:

* BAM QC: added a novel option to control the skipping of duplicate alignments (reported by Patrik Smeds and Vlad Saveliev ) The default mode was switched to skip marked duplicates only.* BAM QC: fixed issue with processing alignments (reported by Roberto Spreafico)* BAM QC: fixed fail when zero mapped reads inside of region (reported by Jochen Singer)* BAM QC: improved the number of windows output (reported by Alexander Peltzer)* BAM QC: integrate mm10 support to command line* BAM QC: fixed insert size histogram computation* Multisample BAM QC: implmeneted support for per sample groups/conditions* Multisample BAM QC: added novel statistics report and global coverage plot (suggested by Angela Heck )* RNA-seq QC: fixed the numbers of reads computation for paired-end reads (reported by Priyanka Jain )* Documentation: updates in BAM QC, Multisample BAM QC, RNA-seq QC

### Version 2.1.3 - October 29, 2015

[qualimap\_v2.1.3.zip](release/qualimap_v2.1.3.zip)

[qualimap\_v2.1.3\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1.3_src.zip)

Changes:

* Fixed a problem with removal of provided existing output folder in command line mode (reported by Nathan McNeil)* BAM QC: added the mm10 GC-content distribution template (suggested by Priyank Shukla )* BAM QC: fixed issue with report of duplication rate in regions ( thanks to Christian for the report )* BAM QC: stabilzed default text output number format (reported by Max Koeppel and Henri-Jean Garchon )* Counts QC: fixed issues with single sample adaption ( reported by Yung-Chih Lai )* Documentation: update introudction, BAM QC, RNA-seq QC and F.A.Q. blocks

### Version 2.1.2 - September 23, 2015

[qualimap\_v2.1.2.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1.2.zip)

[qualimap\_v2.1.2\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1.2_src.zip)

Changes:

* BAM QC: added an option to analyze overlapping paired-end read alignments (suggested by Eva Koenig)* BAM QC: fixed processing of incorrect alignments (reported by Alexander Peltzer)* BAM QC: improved paired reads statistics description (suggested by Jochen Singer)* RNA-seq QC: fixed issue with transcript high coverage (reported by Daniel Barrel)* RNA-seq QC: added to statistcs number of intronic/intergenic reads overlapping exons* RNA-seq QC: minor fix of coverage plot* Counts QC: fixed an issue due to update of NOISeq package* Multisample BAM QC: corrected labels in coverage and GC-content plots (reported by Franziska Singer)* Multisample BAM QC: fixed issue with min X-value in insert size plots (reported by Roland Schmucki)* Improved PDF format output* Documentation: update BAM QC, RNA-seq QC descriptions

### Version 2.1.1 - June 15, 2015

[qualimap\_v2.1.1.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1.1.zip)

[qualimap\_v2.1.1\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1.1_src.zip)

Changes:

* BAM QC: added chromosome names when drawing chromosome limits* BAM QC: fixed fail when no mapped reads; add warning* BAM QC: fixed computing coverage standard deviation (reported by Charlotte Peeters)* BAM QC: by default duplicates (secondary alignments) are skipped if marked* BAM QC: addded report for "OutOfMemory" error* RNA-seq QC: added support for computing number of read pairs* Counts QC: fix fail when sample name starts from number (reported by Alena Dobiasova)* Documentation: updated BAM QC, RNA-seq QC* Documnetation: added special solution regarding DISPLAY issue on Linux server (suggested by Roberto Spreafico)

### Version 2.1 - March 18, 2015

[qualimap\_v2.1.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1.zip)

[qualimap\_v2.1\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.1_src.zip)

Changes:

* BAM QC: added percentage of mapped reads with at least one insertion or deletion* BAM QC: added an option to skip duplicates when running analysis (suggested by Johan Dalberg)* RNA-seq QC: add text report of results (suggested by Lorena Pantano)* BAM QC: fixed issue with inRegionReferenceSize outside of regions (reported by Tristan Carland)* comp-counts: fixed bug when output file path is wrong (reported by Stephane Plaisance)* RNA-seq QC: fixed issue with no-sorting required, improved statistics and input description (thanks to Priyanka Jain for report)* RNA-seq QC: fixed issue when num reads equals zero* RNA-seq QC: improved logging (implemented by Lorena Pantano)* Feature reader: improved exception processing* Fixed an issue with output folder when outformat is PDF

### Version 2.0.2 - February 10, 2015

[qualimap\_v2.0.2.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.0.2.zip)

[qualimap\_v2.0.2\_src.zip](https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.0.2_src.zip)

Changes:

* Compute counts: fixed issue with GTF file analysis and added support for single-end reads strand specificity (thanks to Roberto Spreafico for reports)* BAM QC: added support of mismatches and indels in the text report (thanks to Nils for report)* RNA-seq QC: fixed issue with loading GTF files with strange names (thanks to Haroon Kalam for report)* RNA-seq QC: fixed crash when there are no junctions detected (thanks to François Lefebvre and Larry Willhelm for reports)* Multi-BamQC: fixed issue with max coverage of BAM file supported

### Version 2.0.1 - January 6, 2015

[qualimap\_v2.0.1.zip](release/qualimap_v2.0.1.zip)

[qualimap\_v2.0.1\_src.zip](release/qualimap_v2.0.1_src.zip)

Changes:

* BAM QC: fixed problem with nucleotide content (thanks to Travis Collier)* RNA-seq QC: fixed issue with chromosomes* RNA-seq QC: add support for paired-end reads* countsQC: fixed bug when population less than sample size* Fixed issue with default outdir name

### Version 2.0 - August 28, 2014

[qualimap\_v2.0.zip](release/qualimap_v2.0.zip)

[qualimap\_v2.0\_src.zip](release/qualimap_v2.0_src.zip)

Changes:

* New mode: multi-sample BAM QC* Counts QC: completely redesigned, add support for multi-sample input* RNA-seq QC: add new plots (coverage across genebody, reads genomic origin, junction analysis)* Command line interface improved* BAM QC: changed order of plots* BAM QC: fix insert size overflow* BAM QC: add insert size info to plain text report* BAM QC: fix bug with stats inside of regions* BAM QC: performance improved for long genomes* RNA-seq QC: fix default protocol* Add utility script to create species annotations for Counts QC* Add condtion to exit on error in main script (suggestion from Johan Dahlberg)* Fix coverage quota in plain text report (bugfix from John Budde)* Major documentation update

### Version 1.0 - May 29, 2014

[qualimap\_v1.0.zip](release/qualimap_v1.0.zip)

[qualimap\_v1.0\_src.zip](release/qualimap_v1.0_src.zip)

Changes:

* BAM QC: add computation of mismatches and error rate* BAM QC: add new metrics for insert size* BAM QC: contig coverage added to text report (patch from Johan Dahlberg)* BAM QC: add option to output per-base coverage* Compute counts: add full support for paired-end reads* RNA-seq QC: add new plots and statistics* Updated documentation

### Version 0.8.1 - May 5, 2014 (a bug fix release)

[qualimap\_v0.8.1.zip](release/qualimap_v0.8.1.zip)

[qualimap\_v0.8.1\_src.zip](release/qualimap_v0.8.1_src.zip)

Changes:

* Fixed bug with CountsQC and R version 3* Fixed bug with reference size being computed twice in BamQC

### Version 0.8 - March 5, 2014

[qualimap\_v0.8.zip](release/qualimap_v0.8.zip)

[qualimap\_v0.8\_src.zip](release/qualimap_v0.8_src.zip)

Changes:

* Added new mode: "RNA-Seq QC"* Fixed a number of bugs, including R-version issues and crash with insert size

### Version 0.7.1 - April 19, 2013 (a bug fix release)

[qualimap\_v0.7.1.zip](release/qualimap_v0.7.1.zip)

[qualimap\_v0.7.1\_src.zip](release/qualimap_v0.7.1_src.zip)

Changes:

* Fixed bug with "Coverage Across Reference" plot* Fixed bug in BAM QC when regions don't have any coverage

### Version 0.7 - April 10, 2013

[qualimap\_v0.7.zip](release/qualimap_v0.7.zip)

[qualimap\_v0.7\_src.zip](release/qualimap_v0.7_src.zip)

Changes:

* Fixed bug in per chromosome coverage report (https://groups.google.com/d/msg/qualimap/AO\_6111Gg1E/21SdvEWeAfUJ)* Deletions are now properly computed when calculating coverage* Fixed bug in renaming of tabs* Added global parameter to set Rscript path* Minor fixes in command line tools argument parsing* Improved handling of discordant regions between the BED/GFF and BAM files in BAM QC* Updated documentation

### Version 0.6 - October 30, 2012

[qualimap\_v0.6.zip](release/qualimap_v0.6.zip)

[qualimap\_v0.6\_src.zip](release/qualimap_v0.6_src.zip)

Changes:

* Fixed bug with small homopolymer indels estimation* CIGAR flags "=" and "X" are now parsed properly in BAM QC* BAM QC: added option to set minimum homopolymer size* BAM QC: added option to open SAM files along with BAM files from GUI

### Version 0.5 - July 25, 2012

[qualimap\_v0.5.zip](release/qualimap_v0.5.zip)

[qualimap\_v0.5\_src.zip](release/qualimap_v0.5_src.zip)

Changes:

* BED format is now supported throughout application* Raw data from BAM QC and Counts QC plots can be exported* BAM QC: Added homopolymer indels estimation* BAM QC: Added strand specificity calculation* BAM QC: Added clipping profile and number of clipped reads statistics* Compute counts: Added 5' to 3' prime bias calculation* Allow to set java memory size from launching script* Fixed problem with upperCoverageBound in Coverage Across Reference chart* Fixed issue with insert size limits* Added missing qualimap.bat to launch application on MS Windows

### Version 0.4 - June 4, 2012

[qualimap\_v0.4\_04-06-12.zip](release/qualimap_v0.4_04-06-12.zip)

Changes:

* Fixed problem with chromsome limits in Insert Size chart* Fixed issue with "compute counts" when regions are having several intersecting reads* Fixed crash with Coverage Histogram 0-50X for high coverage samples* Fixed Coverage Histogram when minimal coverage is more than zero* Fixed issue with GFF files, containing empty lines

### Version 0.3 - May 18, 2012

[qualimap\_v0.3\_18-05-12.zip](release/qualimap_v0.3_18-05-12.zip)

First public release.