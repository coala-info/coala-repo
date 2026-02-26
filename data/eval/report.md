# eval CWL Generation Report

## eval_evaluate_gtf.pl

### Tool Description
Run the evaluation code in text mode for GTF annotations and predictions.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/evaluate_gtf.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.26.2.

Usage: evaluate_gtf.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	Boolean (without arguments): -g -h -v -q -A

Options may be merged together.  -- stops processing of options.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
/usr/local/bin/evaluate_gtf.pl <annotation list> <prediction list 1> [prediction list 2] ...
Run the evaluation code in text mode.
Options:
  -g: Input files are gtf not lists
  -q: Quick load the gtf file.  Do not check them for errors.
  -A: Do not evaluate for alternative splicing events. (Faster)
  -v: Verbose mode
  -h: Display this help message and exit
```


## eval_validate_gtf.pl

### Tool Description
Validates a GTF file against a chromosome sequence to identify genes with in-frame stops, reading frame changes, and other incorrectible problems, generating a 'badlist' of genes to be removed.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
To generate an evaluation set, three steps are needed:
1. Download the annotation file from UCSC to the proper /bio/db/ directory
2. Convert the file to GTF and split per chromosome
3. Clean the set using this program

STEP 1. Downloading
Put the files in the correct /bio/db directory. The convention is:
/bio/db/<SPECIES>/assembly/<assembly id>/annotation/<downloaded set_version>
For Refseq, this would be:
/bio/db/Homo_sapiens/assembly/hg17/annotation/refseq_v1
Use ftp for downloading the annotation for the latest genome build:
>ftp hgdownload.cse.ucsc.edu 
>cd goldenPath/currentGenomes/<species>/database
>get <file>
Eg for getting human RefSeqs:
>cd goldenPath/currentGenomes/Homo_sapiens/database
>get refGene.gtf.gz

If you're unsure of the filename you can find it in UCSC's Table Browser
(http://genome.ucsc.edu/cgi-bin/hgTables), select the Track (RefSeq)
and see the name that pops up under Table.

STEP 2. Converting
Unzip the file, convert to gtf, split per chromosome
>gunzip <file>
>/bio/bin/ucsc2gtf.pl <file> > <file.gtf>
This command may generate some "skipping <gene>" error messages.
In those cases, no CDS can be found.
>/bio/bin/divide_gtfs_in_chrs.pl <file.gtf>
...patience...

STEP 3. Cleaning
First, create a badlist containing genes with inframe stops,
reading frame changes and other incorrectible problems. Then,
remove those genes from the files. After that, merge any 
overlapping transcripts into one gene model and remove all
transcripts that are identical to other transcripts:
The first step needs the chromosome sequence. Get this
from /bio/db/<SPECIES>/assembly/<assembly id>/chr_seq/chrN.fa
For every chromosome:
>/bio/bin/validate_gtf.pl -m chrN.gtf /bio/db/<SPECIES>/assembly/<assembly id>/chr_seq/chrN.fa > chrN.badlist.txt 
run this on the queue!
>/bio/bin/filter_badlist.pl chrN.gtf chrN.badlist.txt > chrN.filtered.gtf
>/bio/bin/merge_gtf_transcripts.py chrN.filtered.gtf > chrN.eval.gtf
The last two commands can be run locally

Cleanup: cat all *.badlist.txt into a file called Badlist.txt
Remove all intermediate gtf files, including <file.gtf>
Create a directory /info and move Badlist.txt, and the downloaded file into it
```


## eval_get_distribution.pl

### Tool Description
Takes the maximum value to report in the distribution, the size of bins to report data in, and one of more gtf sets and creates outputs the distribution to standard out.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/get_distribution.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.26.2.

Usage: get_distribution.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -m
	Boolean (without arguments): -g -h -q

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
/usr/local/bin/get_distribution.pl [-g] [-m mode] <max val> <bin size> <pred gtf 1> [pred gtf 2] ...
Takes the maximum value to report in the distribution, the size of bins to 
report data in, and one of more gtf sets and creates outputs the distribution 
to standard out.
Options: 
  -m <mode>: Specify distribution mode.  Must be a number selected from the 
      list below.  Default is mode 1.
  -g: Inputs are gtf files instead of list files
  -q: Quick load the gtf file.  Do not check them for errors.
  -h: Display this help message
Distribution Modes:
  1) Transcripts_Per_Gene
  2) Transcript_Length
  3) Transcript_Coding_Length
  4) Exons_Per_Transcript
  5) Exon_Length
  6) Exon_Score
```

