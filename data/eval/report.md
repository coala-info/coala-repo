# eval CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| eval_combine_eval_reports.pl | PASS |  |
| eval_evaluate_gtf.pl | PASS |  |
| eval_filter_badlist.pl | PASS |  |
| eval_filter_gtfs.pl | PASS |  |
| eval_get_distribution.pl | PASS |  |
| eval_get_general_stats.pl | PASS |  |
| eval_get_overlap_stats.pl | PASS |  |
| eval_graph_gtfs.pl | PASS |  |
| eval_make_intron_lenght_vs_performance_graph.pl | PASS |  |
| eval_validate_gtf.pl | PASS |  |
| eval_validate_splice_sites.pl | PASS |  |

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


## eval_filter_badlist.pl

### Tool Description
Removes the genes named in a gene list from a GTF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: h
usage: /usr/local/bin/filter_badlist.pl [-fl] <gtf file> <gene list>

Options:
     -f  Flag to fix the file.
     -l  Output those genes that are in the list.
```

## eval_combine_eval_reports.pl

### Tool Description
Combines several Eval reports or general statistics reports into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/combine_eval_reports.pl [-hes] <report 1> <report 2> [report 3] ...
This script combines several Eval reports or general statistics reports into one. 
  Options:
    -e: Eval report mode [default]
    -s: General statistics report mode.  Cannot be used with -e.
    -h: Display this help message and exit.
```

## eval_get_general_stats.pl

### Tool Description
Get general statistics on a list of gtf sets using the Eval package.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/get_general_stats.pl <list 1> <list 2> ...
Get general statistics on a list of gtf sets using the Eval package.
Options:
  -g: Input files are gtf not lists
  -q: Quick load the gtf file.  Do not check them for errors.
  -A: Do not get stats for alternative splices. (Faster)
  -v: Verbose mode
  -h: Display this help message and exit
```

## eval_graph_gtfs.pl

### Tool Description
Creates graph tables from a graph file, an annotation and predictions.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/graph_gtfs.pl [-gGh] [-r <file>] <graph file> <ann> <pred 1> [pred 2] ...
Takes a graph file (see below), and annotation and one or more predictions and 
creates each graph specified by the graph file for each pred.
  Options:
    -G: Display list of possible x and y values for graphs
    -g: Load GTFs instead of lists of GTFs
    -q: Quick load the gtf file.  Do not check them for errors.
    -r <resolution file>:  Load resolution from this file
        instead of users .eval.rc or default 
    -h: Display this help message
  Graph file format:
    Each line should be of the format:
    "y_level::y_type::y_stat vs x_type::x_level"
    where options for y_level,y_type_,y_stat, and x_type can be found by 
    giving the -G option
  Resolution file format:
    Each line should be in one of the following formats (all fields are  
    separated by tabs):
    1)"x_type User # # #"
      where values for 'x_type' can be found by using the -G option and bins of 
      values for 'x_type' are made from each '#' to the next '#'
    2)"x_type Uniform min size count"
      where 'min' is the minimum value of any bin, bins are of size 'size',
      and there are a total of 'count' bins, and 'x_type'is as above
```

## eval_get_overlap_stats.pl

### Tool Description
Computes overlap statistics using the Eval package.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/get_overlap_stats.pl [-ghv] [m mode] <list 1> <list 2> ...
Computes overlap statistics using the Eval package.  Inputs are gtf list files.
Options:
  -m <mode>: Specify overlap mode.  Must be a number selected from the list below.
      Default is mode 1.
  -g: Input files are in GTF format.
  -q: Quick load the gtf file.  Do not check them for errors.
  -v: Verbose mode.
  -h: Display this help message and exit.
Overlap Modes:
  1) Transcript_Exact_Overlap
  2) Transcript_Coding_Overlap
  3) Transcript_Region_Overlap
  4) Transcript_80p_Region_Overlap
  5) Transcript_80p_Both_Region_Overlap
  6) Transcript_Exact_Exon_Overlap
  7) Transcript_Exact_Intron_Overlap
  8) Exon_Exact_Overlap
  9) Exon_One_Base_Overlap
  10) Exon_80p_Overlap
  11) Exon_80p_Both_Overlap
```

## eval_validate_splice_sites.pl

### Tool Description
Checks the splice sites of the genes in a GTF file against the genome sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/validate_splice_sites.pl <gtf file> <sequence file> <bad genes list>
```

## eval_filter_gtfs.pl

### Tool Description
Filters prediction GTFs according to a filter file.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/filter_gtfs.pl [fg] <filter file> <ann gtf> <pred gtf 1> [pred gtf 2] ...
Takes a filter file (see below) a annotation gtf and one or more 
prediction gtfs and filters them according to the filter file.
Options: 
  -f: List filter types
  -g: Inputs are gtf files instead of list files
  -A: Do not check for alternative splices. (Faster)
  -q: Quick load the gtf file.  Do not check them for errors.  
  -h: Display this help message
Filter File Format:
  A list of filter types with a single character label for each:
    A - Gene Correct
    B - Transcript All_Introns
    C - Exon Correct
  This list is followed by one or more empty lines then the filter string:
    (A&&B)||!C
```

## eval_make_intron_lenght_vs_performance_graph.pl

### Tool Description
Create a graph of intron performance vs intron length.

### Metadata
- **Docker Image**: quay.io/biocontainers/eval:2.2.8--pl526_0
- **Homepage**: http://mblab.wustl.edu/software.html
- **Package**: https://anaconda.org/channels/bioconda/packages/eval/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/make_intron_lenght_vs_performance_graph.pl <annotation list> <prediction list 1> [prediction list 2] ...
Create a graph of intron performance vs intron length 
Options:
  -m <min_bin_start>: Sets the minimum bin start [default: min intron length];
  -x <max_bin_stop>: Sets the maximum bin end [default: max intron length];
  -b <bin_size>: Sets the bin size [default: 1/10 length range] 
                 Cannot be used with -B
  -B <bin_count>: Sets the number of bins [default: 10] 
                  Cannot be used with -b
  -g: Input files are gtf not lists
  -q: Quick load the gtf file.  Do not check them for errors.
  -v: Verbose mode
  -h: Display this help message and exit
```

## Metadata
- **Skill**: not generated
