## Updates

---

Feb 14, 2020   RSEM v1.3.3 is online now. Added HISAT2 option (--hisat2-hca) using Human Cell Atlas SMART-Seq2 pipeline parameters. Fixed a bug in RSEM simulator.

Apr 6, 2019   RSEM v1.3.2 is online now. Prevented RSEM from crashing when there is 0 aligned reads. Outputted theta and model files even there is no aligned reads.

Jun 27, 2018   RSEM v1.3.1 is online now. Added `--gff3-genes-as-transcripts` option for `rsem-prepare-reference`. This option will allow RSEM to treat genes as transcripts.

Oct 3, 2016   RSEM v1.3.0 is online now. Added Prior-Enhanced RSEM (pRSEM) as a submodule. Introduced `--strandedness <none|forward|reverse>` option, `--strand-specific` and `--forward-prob` are deprecated (but still supported). Revised documentation for `rsem-plot-model`, maked it clear that in alignment statistics, isoform-level (instead of genome-level) multi-mapping reads are shown. Significantly improved the output information of `rsem-sam-validator`: if indels/clippings/skips are detected in alignments or alignments exceed transcript boundaries, `rsem-sam-validator` will report them instead of telling you the input is valid. Updated the warning message to ask users to make sure that they align their reads agains a set of transcripts instead of genome when RSEM finds less sequences in the BAM file than RSEM's indices.

Jun 4, 2016   RSEM v1.2.31 is online now. Rewrote 'rsem-gff3-to-gtf' to handle a more general set of GFF3 files. Added safety checks to make sure poly(A) tails are not added to the reference when '--star' is set.

Apr 24, 2016   Notification: Since RSEM v1.2.27, '--sort-bam-by-coordinate' needs to be set if sorted BAMs are required.

Apr 20, 2016   RSEM v1.2.30 is online now. Fixed a bug that can cause SAMtools sort to fail. Improved the appearance of warning messages: for the same type of warning messages, only show the first 50 messages and then provide the total number of such warnings.

Mar 6, 2016   RSEM v1.2.29 is online now. Reformatted Makefile to be more professional, and `make install` is ready to use. Enabled `./configure --without-curses` for configuring SAMtools to avoid potential compilation problems due to curses library. Fixed bugs for installing EBSeq. Improved the readability of RSEM documentation.

Feb 2, 2016   RSEM v1.2.28 is online now. Fixed a bug in RSEM v1.2.27 that can lead to assertion errors for parsing GTF files.

Feb 1, 2016   RSEM v1.2.27 is online now. Upgraded SAMtools to v1.3; RSEM now supports input alignments in SAM/BAM/CRAM format. '--sam/--bam' options of 'rsem-calculate-expression' are obsoleted; use '--alignments' instead; '--sam/--bam' can still be used for compatibility with previous versions. Some 'rsem-calculate-expression' options are renamed for better interpretability. Documents are updated to reflect the SAMtools upgrade. Fixed a bug for parsing GTF files. Fixed a bug for generating transcript wiggle plots.

Jan 7, 2016   RSEM v1.2.26 is online now. RSEM supports GFF3 annotation format now. Added instructions to build RSEM references using RefSeq, Ensembl, or GENCODE annotations. Added an option to extract only transcripts from certain resources given a GTF/GFF3 file. Fixed a bug and improved the clarity of error messages for extracting transcripts from genome.

Nov 11, 2015   RSEM v1.2.25 is online now. RSEM will extract gene\_name/transcript\_name from GTF file when possible; however, it only appends them to the 'sample\_name.\*.results' files if '--append-names' option is specified; unlike v1.2.24, this version is compatible with STAR aligner even when '--append-names' is set.

Nov 6, 2015   RSEM v1.2.24 is online now. RSEM will extract gene\_name/transcript\_name from GTF file when possible; if extracted, gene\_name/transcript\_name will append at the end of gene\_id/transcript\_id with an underscore in between. Modified 'rsem-plot-model' to indicate the modes of fragment length and read length distributions. Modified 'rsem-plot-model' to present alignment statistics better using both barplot and pie chart. Updated 'EBSeq' to version 1.2.0. Added coefficient of quartile variation in addition to credibility intervals when '--calc-ci' is turned on. Added '--single-cell-prior' option to notify RSEM to use a sparse prior (Dir(0.1)) for single cell data; this option only makes sense if '--calc-pme' or '--calc-ci' is set.

Oct 19, 2015   RSEM v1.2.23 is online now. Moved version information from WHAT\_IS\_NEW to rsem\_perl\_utils.pm in order to make sure the '--version' option always output the version information. Fixed a typo in 'rsem-calculate-expression' that can lead an error when '--star' is set and '--star-path' is not set. Fixed a bug that can occasionally crash the RSEM simulator. Added user-friendly error messages that are triggered when RSEM detects invalid bases in the input FASTA file during reference building.

Jul 27, 2015   RSEM v1.2.22 is online now. Added options to run the STAR aligner.

May 6, 2015   RSEM v1.2.21 is online now. Strip read names of extra words to avoid mismatches of paired-end read names.

Mar 23, 2015   RSEM v1.2.20 is online now. Fixed a problem that can lead to assertion error if any paired-end read's insert size > 32767 (by changing the type of insertL in PairedEndHit.h from short to int).

Nov 5, 2014   RSEM v1.2.19 is online now. Modified 'rsem-prepare-reference' such that by default it does not add any poly(A) tails. To add poly(A) tails, use '--polyA' option. Added an annotation of the 'sample\_name.stat/sample\_name.cnt' file, see 'cnt\_file\_description.txt'.

Sept 29, 2014   RSEM v1.2.18 is online now. Only generate warning message if two mates of a read pair have different names. Only parse attributes of a GTF record if its feature is "exon" to avoid unnecessary warning messages.

Sept 4, 2014   RSEM v1.2.17 is online now. Added error detection for cases such as a read's two mates having different names or a read is both alignable and unalignable.

Aug 18, 2014   RSEM v1.2.16 is online now. Corrected a typo in 'rsem-generate-data-matrix', this script extracts 'expected\_count' column instead of 'TPM' column.

Jun 16, 2014   RSEM v1.2.15 is online now. Allowed for a subset of reference sequences to be declared in an input SAM/BAM file. For any transcript not declared in the SAM/BAM file, its PME estimates and credibility intervals are set to zero. Added advanced options for customizing Gibbs sampler and credibility interval calculation behaviors. Splitted options in 'rsem-calculate-expression' into basic and advanced options.

Jun 8, 2014   RSEM v1.2.14 is online now. Changed RSEM's behaviors for building Bowtie/Bowtie 2 indices. In 'rsem-prepare-reference', '--no-bowtie' and '--no-ntog' options are removed. By default, RSEM does not build either Bowtie or Bowtie 2 indices. Instead, it generates two index Multi-FASTA files, 'reference\_name.idx.fa' and 'reference\_name.n2g.idx.fa'. Compared to the former file, the latter one in addition converts all 'N's into 'G's. These two files can be used to build aligner indices for customized aligners. In addition, 'reference\_name.transcripts.fa' does not have poly(A) tails added. To enable RSEM build Bowtie/Bowtie 2 indices, '--bowtie' or '--bowtie2' must be set explicitly. The most significant benefit of this change is that now we can build Bowtie and Bowtie 2 indices simultaneously by turning both '--bowtie' and '--bowtie2' on. Type 'rsem-prepare-reference --help' for more information. If transcript coordinate files are visualized using IGV, 'reference\_name.idx.fa' should be imported as a genome (instead of 'reference\_name.transcripts.fa'). For more information, see the third subsection of Visualization in 'README.md'. Modified RSEM perl scripts so that RSEM directory will be added in the beginning of the PATH variable. This also means RSEM will try to use its own samtools first. Added --seed option to set random number generator seeds in 'rsem-calculate-expression'. Added posterior standard deviation of counts as output if either '--calc-pme' or '--calc-ci' is set. Updated boost to v1.55.0. Renamed makefile as Makefile. If '--output-genome-bam' is set, in the genome BAM file, each alignment's 'MD' field will be adjusted to match the CIGAR string. 'XS:A:value' field is required by Cufflinks for spliced alignments. If '--output-genome-bam' is set, in the genome BAM file, first each alignment's 'XS' filed will be deleted. Then if the alignment is an spliced alignment, a 'XS:A:value' field will be added accordingly. Added instructions for users who want to put all RSEM executables into a bin directory (see Compilation & Installation section of 'README.md').

May 26, 2014   RSEM v1.2.13 is online now. Allowed usersto use the SAMtools in the PATHfirst and enabled RSEM to find its executables via a symbolic link. Changed the behavior of parsing GTF file. Now if a GTF line's feature is not "exon" and it does not contain a "gene\_id" or "transcript\_id" attribute, only a warning message will be produced (instead of failing the RSEM).

Mar 27, 2014   RSEM v1.2.12 is online now. Enabled allele-specific expression estimation. Added '--calc-pme' option for 'rsem-calculate-expression' to calculate posterior mean estimates only (no credibility intervals). Modified the shebang line of RSEM perl scripts to make them more portable. Added '--seed' option for 'rsem-simulate-reads' to enable users set the seed of random number generator used by the simulation. Modified the transcript extraction behavior of 'rsem-prepare-reference'. For transcripts that cannot be extracted, instead of failing the whole script, warning information is produced. Those transcripts are ignored.

Feb 14, 2014   RSEM v1.2.11 is online now. Enabled RSEM to use Bowtie 2 aligner (indel, local and discordant alignments are not supported yet). Changed option names '--bowtie-phred33-quals', '--bowtie-phred64-quals' and '--bowtie-solexa-quals' back to '--phred33-quals', '--phred64-quals' and '--solexa-quals'.

Jan 31, 2014   RSEM v1.2.10 is online now. Fixed a bug which will lead to out-of-memory error when RSEM computes ngvector for EBSeq.

Jan 8, 2014   RSEM v1.2.9 is online now. Fixed a compilation error problem in Mac OS. Fixed a problem in makefile that affects 'make ebseq'. Added 'model\_file\_description.txt', which describes the format and meanings of file 'sample\_name.stat/sample\_name.model'. Updated samtools to version 0.1.19.

Nov 22, 2013   RSEM v1.2.8 is online now. Provided a more detailed description for how to simulate RNA-Seq data using 'rsem-simulate-reads'. Provided more user-friendly error message if RSEM fails to extract transcript sequences due to the failure of reading certain chromosome sequences.

Sept 25, 2013   RSEM v1.2.7 has a minor update. One line is added to the 'WHAT\_IS\_NEW' file to reflect a change made but forgotten to put in to 'WHAT\_IS\_NEW'. The line added is "Renamed '--phred33-quals', '--phred64-quals', and '--solexa-quals' in 'rsem-calculate-expression' to '--bowtie-phred33-quals', '--bowtie-phred64-quals', and '--bowtie-solex-quals' to avoid confusion".

Sept 7, 2013   RSEM v1.2.7 is online now. 'rsem-find-DE' is replaced by 'rsem-run-ebseq' and 'rsem-control-fdr' for a more friendly user experience. Added support for differential expression testing on more than 2 conditions in RSEM's EBSeq wrappers 'rsem-run-ebseq' and 'rsem-control-fdr'.

Jul 31, 2013   RSEM v1.2.6 is online now. Install the latest version of EBSeq from Bioconductor and if fails, try to install EBSeq v1.1.5 locally. Fixed a bug in 'rsem-gen-transcript-plots', which makes 'rsem-plot-transcript-wiggles' fail.

Jun 26, 2013   RSEM v1.2.5 is online now. Updated EBSeq from v1.1.5 to v1.1.6 . Fixed a bug in 'rsem-generate-data-matrix', which can cause 'rsem-find-DE' to crash.

Apr 15, 2013   RSEM v1.2.4 is online now. Fixed a bug that leads to poor parallelization performance in Mac OS systems. Fixed a problem that may halt the 'rsem-gen-transcript-plots', thanks Han Lin for pointing out the problem and suggesting possible fixes. Added some user-friendly error messages for converting transcript BAM files into genomic BAM files. Modified rsem-tbam2gbam so that the original alignment quality MAPQ will be preserved if the input bam is not from RSEM. Added user-friendly error messages if users forget to compile the source codes.

Jan 8, 2013   RSEM v1.2.3 is online now. Fixed a bug in 'EBSeq/rsem-for-ebseq-generate-ngvector-from-clustering-info' which may crash the script.

Jan 8, 2013   RSEM v1.2.2 is online now. Updated EBSeq to v1.1.5 . Modified 'rsem-find-DE' to generate extra output files (type 'rsem-find-DE' to see more information).

Nov 29, 2012   RSEM v1.2.1 is online now. Added poly(A) tails to 'reference\_name.transcripts.fa' so that the RSEM generated transcript unsorted BAM file can be fed into RSEM as an input file. However, users need to **rebuild** their references if they want to visualize the transcript level wiggle files and BAM files using IGV. Modified 'rsem-tbam2gbam' to convert users' alignments from transcript BAM files into genome BAM files, provided users use 'reference\_name.idx.fa' to build indices for their aligners. Updated EBSeq from v1.1.3 to v1.1.4. Corrected several typos in warning messages.

Sept 11, 2012   RSEM v1.2.0 is online now. Changed output formats, added FPKM field etc. . Fixed a bug related to paired-end reads data. Added a script to run EBSeq automatically and updated EBSeq to v1.1.3 .

Jul 2, 2012   RSEM v1.1.21 is online now. Removed optional field "Z0:A:!" in the BAM outputs. Added --no-fractional-weight option to rsem-bam2wig, if the BAM file is not generated by RSEM, this option is recommended to be set. Fixed a bug for generating transcript level wiggle files using 'rsem-plot-transcript-wiggles'.

Jun 5, 2012   RSEM v1.1.20 is online now. Added an option to set the temporary folder name. Removed sample\_name.sam.gz. Instead, RSEM uses samtools to convert bowtie outputted SAM file into a BAM file under the temporary folder. RSEM generated BAM files now contains all alignment lines produced by bowtie or user-specified aligners, including unalignable reads. Please note that for paired-end reads, if one mate has alignments but the other does not, RSEM will mark the alignable mate as "unmappable" (flag bit 0x4) and append an optional field "Z0:A:!".

Apr 26, 2012   RSEM v1.1.19 is online now. Allowed > 2^31 hits. Added some instructions on how to visualize transcript coordinate BAM/WIG files using IGV. Included EBSeq for downstream differential expression analysis.

Mar 11, 2012   RSEM v1.1.18-modified is online now. This modified version solved a compilation problem for GCC version 4.5.3 or higher.

Mar 11, 2012   RSEM v1.1.18 is online now. Added some user-friendly error messages. Added program 'rsem-sam-validator', users can use this program to check if RSEM can process their SAM/BAM files. Modified 'convert-sam-for-rsem' so that this prog