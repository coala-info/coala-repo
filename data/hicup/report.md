# hicup CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hicup | PASS |  |
| hicup_capture | PASS | synthetic data: baits planted on two regions of the real yeast Hi-C di-tags |
| hicup_checker | Failed | tool bug: hicup_checker 0.9.2 dies with Illegal division by zero when an expected value is 0, even when both inputs are the same real HiCUP summary report (it needs --expected and --new, not the positional files shown in its help) |
| hicup_deduplicator | PASS |  |
| hicup_digester | PASS |  |
| hicup_filter | PASS |  |
| hicup_find_common_fragment_interactions | PASS | compared the fragment matrices of the full and a partial real yeast Hi-C run: 1491 common, 1566 not common, matching the file sizes |
| hicup_hicup2fithic | PASS |  |
| hicup_hicup2gothic | PASS |  |
| hicup_hicup2hicpipe | PASS |  |
| hicup_hicup2homer | Failed | tool bug: hicup2homer 0.9.2 crashes with Undefined subroutine get_csome_position (not exported by hicup_module) and writes an empty file |
| hicup_hicup2juicer | PASS |  |
| hicup_hicup2ncc | PASS |  |
| hicup_make_hic_array | PASS | real yeast Hi-C reads (hicup output, 3076 pairs) turned into a fragment interaction matrix with counts summing to 3076 |
| hicup_mapper | PASS |  |
| hicup_reporter | PASS | collated the real yeast Hi-C run summaries (20000 pairs) into HiCUP_summary_report text files; the HTML step fails in the image (pandoc lacks libgmp) but the tool still exits 0 |
| hicup_scribl_capture | PASS | synthetic data: baits planted on two regions of the real yeast Hi-C di-tags (hicup run on 20000 read pairs); summary reports 3076 di-tags (38 both, 67 forward, 56 reverse captured) |
| hicup_scribl_capture_ditag_sorter | PASS | synthetic data: baits planted on two regions of the real yeast Hi-C di-tags (hicup run on 20000 read pairs); summary counts 6152 reads and per-bait read files were written (the tool's header has one column fewer than its values) |
| hicup_scribl_capture_region_breakdown | PASS | synthetic data: baits planted on two regions of the real yeast Hi-C di-tags (hicup run on 20000 read pairs); summary counts 6152 reads per bait region |
| hicup_scribler | PASS | synthetic data: baits planted on two regions of the real yeast Hi-C di-tags (hicup run on 20000 read pairs); both/one/no-read captured counts add up to the 3076 di-tags and a SeqMonk digest annotation was written |
| hicup_truncater | PASS |  |

## hicup

### Tool Description
The HiCUP pipeline receives FASTQ files and generates Hi-C paired read (di-tag) files. The hicup script regulates the pipeline, passing output from one script to the next.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

SYNOPSIS

hicup is used to run the whole HiCUP pipeline

hicup [OPTIONS]... --config [CONFIGURATION FILE]...
hicup [OPTIONS]... [FILES]

FUNCTION

The HiCUP pipeline receives FASTQ files and generates Hi-C paired read (di-tag)
files. The hicup script regulates the pipeline, passing output from one script to 
the next. 

The HiCUP pipeline uses a configuration file to set the mapping and filtering 
parameters. To produce an example configuration file:

hicup --example

Parameters may also be passed to HiCUP via the command line, overriding those 
specified in the configuration file. FASTQ file pairs should be place next to 
each other when using the command line, or on adjacent lines in the configuration 
file.

COMMAND LINE OPTIONS

--bowtie       Specify the path to Bowtie
--bowtie2      Specify the path to Bowtie 2
--config       Specify the configuration file
--digest       Specify the digest file listing restriction fragment co-ordinates
--example      Produce an example configuration file
--format       Specify FASTQ format
               Options: Sanger, Solexa_Illumina_1.0, Illumina_1.3, Illumina_1.5
--help         Print help message and exit
--index        Path to the relevant reference genome Bowtie/Bowtie2 indices
--keep         Keep intermediate pipeline files
--longest      Maximum allowable insert size (bps)
--nofill       Hi-C protocol did NOT include a fill-in of sticky ends prior to 
               ligation step and therefore FASTQ reads shall be truncated at the 
               Hi-C restriction enzyme cut site (if present) sequence is 
               encountered
--outdir       Directory to write output files
--quiet        Suppress progress reports (except warnings)
--shortest     Minimum allowable insert size (bps)
--temp         Write intermediate files (i.e. all except summary files and files
               generated by HiCUP Deduplicator) to a specified directory
--threads      Specify the number of threads, allowing simultaneous processing 
               of multiple files
--version      Print the program version and exit
--zip          Compress output

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```


## hicup_digester

### Tool Description
The 'hicup_digester' script creates a reference genome, cut with a specified restriction enzyme.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The 'hicup_digester' script creates a reference genome, cut with a
specified restriction enzyme

SYNOPSIS

hicup_digester [OPTIONS]... -config [CONFIGURATION FILE]
hicup_digester [OPTIONS]... [FASTA FILES]...

FUNCTION

The HiCUP pipeline removes Hi-C artefacts, requiring a reference digested 
genome. HiCUP Digester identifies the cut sites in FASTA files. The script 
prints the results to file for subsequent processing by HiCUP Filter.

The names of the files to be processed and the digestion parameters may be 
passed to the script by a configuration file or command line arguments. 

COMMAND LINE OPTIONS

--arima         Set the --re1 option to that used by the Arima protocol: 
                ^GATC,DpnII:G^ANTC,Arima
--re1           Restriction enzyme used to digest the genome (the enzyme 
                that forms the ligation junction) e.g. A^GATCT,BglII. 
                Some Hi-C protocols may use several enzymes.
                To specify several enzymes, use the ":" to separate them
                e.g. A^GATCT,BglII:A^AGCTT,HindIII:^GATC,DpnII.
                HiCUP accomodates N in restriction enzyme: e.g. :A^ANCTT
--re2           To specify a restriction enzyme instead of sonication to shorten
                di-tags. This restriction site does NOT form a Hi-C ligation 
                junction. 2 e.g. AG^CT,AluI. Typically the sonication
                protocol is followed.
--config        Specify the name of the optional configuration file
--genome        Name of the genome to be digested (not the path to the genome file
                or files, but the genome name to include in the output file) 
--help          Print program help and exit
--outdir        Specify the directory to which the output files should be 
                written
--quiet         Suppress all progress reports
--version       Print the program version and exit
--zip           Print the results to a gzip file

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_truncater

### Tool Description
The hicup_truncater script terminates reads at Hi-C ligation junctions.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

SYNOPSIS

hicup_truncater script terminates reads at Hi-C ligation junctions

hicup_truncater [OPTIONS]... -config [CONFIGURATION FILE]...
hicup_truncater [OPTIONS]... [FASTQ FILE PAIRS]...

FASTQ file pairs should be place next to each other when using the command line, or
on adjacent lines in the configuration file.

FUNCTION

Valid Hi-C pairs comprise two DNA fragments from different regions of the genome 
ligated together. The hicup_truncater script identifies ligation junctions within 
reads and deletes sequences downstream of the restriction enzyme recognition 
sequence. 

The names of the files to be processed and the restriction enzyme recogniton site 
may be passed tonthe scrip using a configuration file or command line arguments.

COMMAND LINE OPTIONS

--config         Name of the optional configuration file
--help           Print program help and exit
--nofill         Hi-C protocol did NOT include a fill-in of sticky ends prior to 
                 re-ligation and therefore reads shall be truncated at
                 the restriction site sequence. This feature is only supported for 
                 single restriction enzyme Hi-C.
--outdir         Directory to write output files
--quiet          Suppress all progress reports
--re1            Restriction enzyme recognition sequence. e.g. A^GATCT,BglII
                 HiCUP can accomodate more than one enzyme and N nucleotides
                 e.g. A^GATCT,BglII:A^AGCTT,HindIII:^GANTC,myRE.
--sequences      Instead of specifying a restriction enzyme recognition sequence,
                 specify the ligation sequences directly
--threads        Number of threads to use, allowing simultaneous processing  of 
                 different files
--version        Print the program version and exit
--zip            Compress output using gzip

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_mapper

### Tool Description
The hicup_mapper script aligns paired-end read files to a specified reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

SYNOPSIS

The hicup_mapper script aligns paired-end read files to a specified reference genome

hicup_mapper [OPTIONS]... -config [CONFIGURATION FILE]...
hicup_mapper [OPTIONS]... [FASTQ FILES]...

FUNCTION

Maps putative Hi-C di-tags against a reference genome. Forward and reverse reads
are aligned independently and then paired i.e. two input files result in one 
output file. The aligners Bowtie or Bowtie2 may be called to perform the mapping.

Parameters may be passed to HiCUP Mapper using a configuration file and/or 
via the command line (thereby overriding settings specified in the 
configuration file). FASTQ file pairs should be placed next to each other when 
using the command line, or on adjacent lines in the configuration file.


COMMAND LINE OPTIONS

--bowtie         Specify the path to Bowtie
--bowtie2        Specify the path to Bowtie 2
--config         Specify the configuration file
--format         Specify FASTQ format
                 Options: Sanger, Solexa_Illumina_1.0, Illumina_1.3, Illumina_1.5
--help           Print help message and exit
--index          Path to the relevant reference genome Bowtie/Bowtie2 indices
--outdir         Directory to write output files
--quiet          Suppress progress reports (except warnings)
--threads        Specify the number of threads, allowing simultaneous processing 
                 of different files (default: 1)
--version        Print the program version and exit
--zip            Compress output

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_filter

### Tool Description
The hicup_filter script classifies read pairs, identifying valid Hi-C di-tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup_filter script classifies read pairs, identifying valid Hi-C di-tags 

SYNOPSIS

hicup_filter [OPTIONS] -config [CONFIGURATION FILE]…
hicup_filter [OPTIONS] [hicup_mapper output file]

FUNCTION
A substantial number of read pairs will represent Hi-C artefacts and not the
three-dimensional conformation of the genome. HiCUP Filter categorises and
removes such read pairs.

Parameters may be passed to HiCUP Filter using a configuration file and/or 
via the command line (thereby overriding settings specified in the 
configuration file).

OPTIONS

--config       Specify the optional configuration file
--digest       Specify the genome digest file (created by hicup_digester)
--help         Print program help and exit
--longest      Maximum allowable insert size (bps)
--outdir       Directory to write output files
--quiet        Suppress all progress reports
--shortest     Minimum allowable insert size (bps)
--threads      Specify the number of threads, allowing simultaneous processing 
               of multiple files
--version      Print the program version and exit
--zip          Compress final output files using gzip, or if SAMtools is 
               installed, to BAM format

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_deduplicator

### Tool Description
The hicup_deduplicator script removes duplicated di-tags (retaining one copy of each) from the data set.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup_deduplicator script removes duplicated di-tags (retaining one 
copy of each) from the data set

SYNOPSIS
hicup_deduplicator [OPTIONS]... -config [CONFIGURATION FILE]...
hicup_deduplicator [OPTIONS]... [SAM/BAM FILES]...

FUNCTION
The Hi-C experimental protocol involves a PCR amplification step to generate 
enough material for sequencing. These PCR duplicates could result in incorrect 
inferences being drawn regarding the genomic conformation and so are removed.

Parameters may be passed to HiCUP Deduplicator using a configuration file and/or 
via the command line (thereby overriding settings specified in the 
configuration file).

COMMAND LINE OPTIONS

--config       Specify the configuration file
--help         Print help message and exit
--outdir       Directory to write output files
--quiet        Suppress progress reports (except warnings)
--threads      Number of threads to use, allowing simultaneous processing  of 
               different files
--version      Print the program version and exit
--zip          Compress output

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_capture

### Tool Description
Separates captured from uncaptured di-tags of Capture Hi-C (CHiC) experiments, using a baits file and HiCUP BAM/SAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS

hicup_capture

hicup_capture [OPTIONS] --baits [baits file] [BAM/SAM files]
hicup_capture [OPTIONS]

FUNCTION

For Capture Hi-C (CHiC) experiments. Takes a baits file and 
BAM/SAM HiCUP file(s) and separates 'captured' di-tags from
'uncaptured' di-tags, writing the output into two different 
BAM files. Reports summary statistics on the results.

The baits file should be a tab-delimited file of format:
Chromosome    Start    End
 
COMMAND LINE OPTIONS

--baits            Baits format file
--header           Specify number of header lines in the baits 
                   file (i.e. skip these) [Default 0]
--help             Print help message and exit
--interactions     Calculate interaction frequecies between 
                   baits
--version          Print the program version and exit

Steven Wingett
Babraham Institute, Cambridge, UK
The MRC Laboratory of Molecular Biology, Cambridge, UK
```

## hicup_hicup2homer

### Tool Description
The hicup2homer script converts HiCUP BAM/SAM files to a format compatible with Homer (7 columns, with read pairs on the same line).

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup2homer script converts HiCUP BAM/SAM files to a format compatible 
with Homer (Homer Hi-C pages found at: http://homer.salk.edu/homer/interactions).

SYNOPSIS

hicup2homer [OPTIONS]
hicup2homer [SAM/BAM FILES]...

FUNCTION

HiCUP generates SAM/BAM files of mapped, filtered paired-end reads 
constituting the sequenced valid Hi-C di-tags. These may then be analysed by a 
variety of specialised tools, but before this is possible the datasets will 
need parsing into an appropriate format.

The hicup2homer script converts HiCUP BAM/SAM files to a format compatible with 
Homer i.e. 7 columns, with read pairs on the same line:

Column1: index number (integer 1, 2, 3,..)
Column2: forward read chromosome name
Column3: forward read position
Column4: forward read strand (0 = positive strand, 1 = negative strand)
Column5: reverse read chromosome name 
Column6: reverse read position
Column7: reverse read strand (0 = positive strand, 1 = negative strand)

COMMAND LINE OPTIONS

--help         Print help message and exit
--version      Print the program version and exit
--zip          Write output to a gzip file

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_hicup2juicer

### Tool Description
The hicup2juicer script converts HiCUP BAM/SAM files to a format compatible with Juicer and JuiceBox.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup2juicer script converts HiCUP BAM/SAM files to a format compatible 
with Juicer and JuiceBox( https://github.com/aidenlab/juicer ).
Outputfiles generated by this script may be converted to Juicer ".hic" files 
using the "pre" command as described at: https://github.com/aidenlab/juicer/wiki/Pre

The script does not use restriction site coordinates when generating output.

SYNOPSIS

hiup2juicer [OPTIONS]
hicup2juicer [OPTIONS] [SAM/BAM FILES]...

FUNCTION

HiCUP generates SAM/BAM files of mapped, filtered paired-end reads 
constituting the sequenced valid Hi-C di-tags. These may then be analysed by a 
variety of specialised tools, but before this is possible the datasets will 
need parsing into an appropriate format.

The hicup2juicer script converts HiCUP BAM/SAM files to a tab-delimited format 
comprising 7 columns, with read pairs on the same line:

<readname> <str1> <chr1> <pos1> <frag1> <str2> <chr2> <pos2> <frag2> <mapq1> <mapq2>
str = strand (0 for forward, anything else for reverse)
chr = chromosome (must be a chromosome in the genome)
pos = position
frag = restriction site fragment
mapq = mapping quality score

Column1: Readpair index number (starting at 1)
Column2: forward read strand (0 = positive strand, 1 = negative strand)
Column3: forward read chromosome name
Column4: forward read position (or position of the middle of the fragment)
Column5: forward read fragment id (set to the dummy value 0 unless digest file provided)
Column6: reverse read strand (0 = positive strand, 1 = negative strand)
Column7: reverse read chromosome name
Column8: reverse read position (or position of the middle of the fragment)
Column9: reverse read fragment id (set to the dummy value 1 unless digest file provided)
Column10: forward read MAPQ score
Column11: reverse read MAPQ score


COMMAND LINE OPTIONS

--help         Print help message and exit
--version      Print the program version and exit
--zip          Write output to a gzip file
--digest       Specify the genome digest file (created by hicup_digester) this allows to get the fragment id
--usemid       Use the middle of the fragment as position instead of the 5' end.

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_hicup2fithic

### Tool Description
The hicup2fithic script converts HiCUP BAM/SAM files to a format compatible with Fit-Hi-C.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup2fithic script converts HiCUP BAM/SAM files to a format compatible 
with Fit-Hi-C (Fit-Hi-C pages found at:
https://noble.gs.washington.edu/proj/fit-hi-c).

SYNOPSIS

hicup2fithic [OPTIONS]
hicup2fithic [OPTIONS] [SAM/BAM FILES]...

FUNCTION

HiCUP generates SAM/BAM files of mapped, filtered paired-end reads 
constituting the sequenced valid Hi-C di-tags. These may then be analysed by a 
variety of specialised tools, but before this is possible the datasets will 
need parsing into an appropriate format.

The hicup2fithic script converts HiCUP BAM/SAM files to a format compatible 
with Fit-Hi-C. The script produces two output files, the first lists all 
restriction fragments:

Column1: chromosome name
Column2: extra field (set to 0)
Column3: fragment midpoint
Column4: number of mid-range contacts
Column5: mapability

The second contains a list of mid-range contacts. Only the fragment pairs with 
non-zero contact counts are listed.

Column1: fragment1 chromosome name
Column2: fragment1 midpoint
Column3: fragment2 chromosome name
Column4: fragment2 midpoint
Column5: contact count

(Note: At present this only allows production of datasets that have not been normalised.)

If no --maximum or --minimum parameters are specified, all contacts will
be written to the final files.

COMMAND LINE OPTIONS

--help         Print help message and exit
--digest       HiCUP Digester generated digest file 
--maximum      The maximum allowed distance separation (bps) between contacts
               (selecting this option also removes trans contacts)
--minimum      The maximum allowed distance separation (bps) between contacts
               (selecting this option also removes trans contacts)
--version      Print the program version and exit

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_hicup2gothic

### Tool Description
The hicup2gothic script converts HiCUP BAM/SAM files to a format compatible with GOTHiC (4 columns, with reads on separate lines: read ID, SAM flag, chromosome name, position).

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup2gothic script converts HiCUP BAM/SAM files to a format compatible 
with GOTHiC (GOTHiC Hi-C pages found at:
http://master.bioconductor.org/packages/release/bioc/html/GOTHiC.html).

SYNOPSIS

hicup2gothic [OPTIONS]
hicup2gothic [SAM/BAM FILES]...

FUNCTION

HiCUP generates SAM/BAM files of mapped, filtered paired-end reads 
constituting the sequenced valid Hi-C di-tags. These may then be analysed by a 
variety of specialised tools, but before this is possible the datasets will 
need parsing into an appropriate format.

The hicup2gothic script converts HiCUP BAM/SAM files to a format compatible with 
GOTHiC i.e. 4 columns, with reads on separate lines:

Column1: read ID
Column2: SAM flag
Column3: chromosome name
Column4: position

COMMAND LINE OPTIONS

--help         Print help message and exit
--version      Print the program version and exit

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_hicup2ncc

### Tool Description
The hicup2ncc script converts HiCUP BAM/SAM files to NCC format, which is generated by the NucProcess pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup2ncc script converts HiCUP BAM/SAM files to NCC format, which is 
generated by the NucProcess pipeline:
https://github.com/tjs23/nuc_processing/wiki/NCC-data-format

SYNOPSIS

hicup2ncc [OPTIONS]
hicup2ncc [SAM/BAM FILES]...

FUNCTION

HiCUP generates SAM/BAM files of mapped, filtered paired-end reads 
constituting the sequenced valid Hi-C di-tags. These may then be analysed by a 
variety of specialised tools, but before this is possible the datasets will 
need parsing into an appropriate format.

The hicup2ncc script converts HiCUP BAM/SAM files to NCC format compatible which 
is genetated by the NucProcess pipeline:

The columns of NCC files correspond to:

- Name of chromosome A
- First base position of sequence read A
- Last base position of sequence read A
- 5' base position of primary RE fragment containing read A
- 3' base position of primary RE fragment containing read A
- The strand of sequence read A
- Name of chromosome B
- First base position of sequence read B
- Last base position of sequence read B
- 5' base position of primary RE fragment containing read B
- 3' base position of primary RE fragment containing read B
- The strand of sequence read B
- The number of the ambiguity group to which the paired reads belong
- The ID number of the read pair in the original FASTQ files
- Whether read pairs are swapped relative to original FASTQ files

This script expects the sonication protocol to have been followed in the Hi-C 
library construction, rather than the legacy double-digest protocol.

IMPORTANT NOTE: The order of the --aligned, --fastq1 and --fastq2 files need to
correspond exactly to one another for correct processing.

COMMAND LINE OPTIONS

--aligned      Whitespace-separated list of HiCUP BAM/SAM files
--digest       HiCUP digest file used in HiCUP analysis
--fastq1       Whitespace-separated list of FASTQ (read1) files
--fastq2       Whitespace-separated list of FASTQ (read2) files
               The order of the aligned, fastq1 and fastq2 files
               should correspond to one another - you may use
               wildcards or a space-sepatated list between quotation
               marks
--help         Print help message and exit
--version      Print the program version and exit
--zip          Write output to a gzip file

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, The MRC Laboratory of Molecular Biology, Cambridge, UK 
(steven.wingett@mrc-lmb.cam.ac.uk)
```

## hicup_hicup2hicpipe

### Tool Description
The hicup2hicpipe script converts HiCUP BAM/SAM files to a format compatible with Hicpipe, termed a RAW data format file (6 columns for each di-tag).

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup2hicpipe script converts HiCUP BAM/SAM files to a format compatible 
with Hicpipe (Hicpipe pages found at: http://compgenomics.weizmann.ac.il/tanay).

SYNOPSIS

hicup2hicpipe [OPTIONS]
hicup2hicpipe [SAM/BAM FILES]...

FUNCTION

HiCUP generates SAM/BAM files of mapped, filtered paired-end reads 
constituting the sequenced valid Hi-C di-tags. These may then be analysed by a 
variety of specialised tools, but before this is possible the datasets will 
need parsing into an appropriate format.

The hicup2hicpipe script converts HiCUP BAM/SAM files to a format compatible with 
Hicpipe, termed a RAW data format file. The fomrat comprises 6 columns for each
di-tag.

Column1: forward read chromosome name
Column2: forward read position
Column3: forward read strand (+ = positive strand, - = negative strand)
Column4: reverse read chromosome name 
Column5: reverse read position
Column6: reverse read strand (+ = positive strand, - = negative strand)

COMMAND LINE OPTIONS

--help         Print help message and exit
--version      Print the program version and exit

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_checker

### Tool Description
The hicup_checker script confirms that two different HiCUP summary results files correspond exactly (or match approximately).

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

The hicup_checker script confirms that two different HiCUP summary results 
files correspond exactly (or match approximately)

SYNOPSIS
hicup_checker [OPTIONS]... [HiCUP Results File1] [HiCUP Results File2]

FUNCTION
The hicup_checker script confirms that two different HiCUP summary results 
files correspond exactly (or match approximately).  This is for use in
unit testing to check that updated versions of HiCUP do not generate
substantially different results.  The script also confirms that header
lines match exactly

COMMAND LINE OPTIONS

--help         Print help message and exit
--threshold    Maximum percentage by which results may differ [default: 0]
--version      Print the program version and exit

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_reporter

### Tool Description
hicup_reporter generates summary results for the whole HiCUP pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
HiCUP homepage: www.bioinformatics.babraham.ac.uk/projects/hicup

SYNOPSIS

hicup_reporter generates summary results for the whole HiCUP pipeline

hicup_reporter [OPTIONS]... [Folder]
hicup_reporter [Folder]

FUNCTION

The hicup_reporter script collates the summary reports generated by the HiCUP 
pipeline scripts (hicup_truncater, hicup_mapper etc.) and converts them into 
collated summary text files and interactive documents containing tables and 
plots.

To run the script, pass as an argument the path to the folder containing the 
summary files generated by the HiCUP pipeline scripts.

COMMAND LINE OPTIONS

--help         Print help message and exit
--quiet        Suppress progress reports (except warnings)
--version      Print the program version and exit

Full instructions on running the pipeline can be found at:
www.bioinformatics.babraham.ac.uk/projects/hicup

Steven Wingett, Babraham Institute, Cambridge, UK
```

## hicup_scribler

### Tool Description
Perl script that creates a SeqMonk data file for SCRiBL datasets; each bait region is imported as a separate chromosome.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
scribler (version $VERSION)	
	
Perl script to be used on SCRiBL datasets to create a Seqmonk data file for SCRiBL datasets. 
Each bait region will be imported into Seqmonk as a separate chromosome.

For this script, reads are only considered captured if ALL of BOTH
reads in a di-tag overlap the SCRiBL capture region.

Input files:
i) 		BAM/SAM HiCUP output file(s)
ii) 	SCRIBL bait co-ordinates
iii) 	EMBL format genome annotation file(s) [optional]

Usage:
scribler [options] <HiCUP BAM/SAM output>

Options
--baits         To specifiy the name of the baits file. Baits should be in the format:
                Chromosome	Bait_Start	Bait_End	Bait_Name
                As a tab-delimited file
--annotation    Create a custom annotation for the SCRiBL baits (compatible with SeqMonk)
                The annotation files need to be named as follows: [chromosome name].dat
                The chromosome names in the '.dat' file need to be identical
                to those found in the SCRiBL bait file
                This parameter takes no arguments
				
                Output files will be of the format:
                [bait name].dat
				
                The chromosome names will be change to those of the bait in the captured di-tags 
                BAM file

                This is an optional parameter
 
                EMBL format is the standard format produced by the EMBL nucleotide
                sequence database at:
                http://www.ebi.ac.uk/embl/
                Specifically there is a list of completed genomes at:
                http://www.ebi.ac.uk/genomes/
                ..which contains links to EMBL formatted files of the final 
                annotated genome assemblies
--digest        Specify HiCUP digest file used to create a SCRiBL digest annotation file for
                SeqMonk. This is an optional parameter
--seqmonk       Edits the annotation file to remove common irregularities rendering the
                file incompatible with BioPerl 
                Can only be use in conjuction with "--annotation"
                This parameter take no arguments
--sam         	Do not compress the captured reads files (i.e. write to SAM format
                not BAM format)
--autoedit      Bait names may only contain alphanumeric characters. This argument will cause
                the program to intelligently rename baits that contain prohibited characters
--help          Print help and exit
--version       Print version and exit

Steven Wingett, Babraham Institute, Cambridge UK
```

## hicup_scribl_capture

### Tool Description
Determines capture efficiencies of SCRiBL datasets from bait coordinates and HiCUP BAM/SAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
Perl script to be used on SCRiBL datasets to determine capture efficiencies. Receives
SCRIBL coordinates and a HiCUP BAM file as input.
(The script prints no help; this text is its header comment and usage error.)

Usage:
scribl_capture.pl --baits [SCRIBL capture positions file] [--zip] [HiCUP BAM/SAM files]

Please specify a SCRIBL capture positions file (--baits) and at least 1 HiCUP output file

--baits   Tab-delimited bait file: Chromosome, Start, End (no header)
--zip     Write the captured and uncaptured files as BAM (always on in the script)
```

## hicup_scribl_capture_ditag_sorter

### Tool Description
Determines SCRiBL capture efficiencies by region and writes the reads of each bait to its own file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
Perl script to be used on SCRiBL datasets to determine capture efficiencies by scribl region.
Receives SCRIBL coordinates and a HiCUP BAM file as input. Counts the number of READS that
fall in each region.
(The script prints no help; this text is its header comment and usage error.)

Usage:
scribl_capture_ditag_sorter.pl --baits [SCRIBL capture positions file] [HiCUP BAM/SAM files]

Please specify a SCRIBL capture positions file (--baits) and at least 1 HiCUP output file

--baits   Tab-delimited bait file with one header line: Bait_Name, Chromosome, Start, End
```

## hicup_scribl_capture_region_breakdown

### Tool Description
Determines SCRiBL capture efficiencies by region; counts the reads that fall in each bait region.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
Perl script to be used on SCRiBL datasets to determine capture efficiencies by scribl region.
Receives SCRIBL coordinates and a HiCUP BAM file as input. Counts the number of READS that
fall in each region.
(The script prints no help; this text is its header comment and usage error.)

Usage:
scribl_capture_region_breakdown.pl --baits [SCRIBL capture positions file] [HiCUP BAM/SAM files]

Please specify a SCRIBL capture positions file (--baits) and at least 1 HiCUP output file

--baits   Tab-delimited bait file: Chromosome, Start, End (no header)
```

## hicup_make_hic_array

### Tool Description
Converts HiCUP BAM/SAM reads to restriction fragments and counts fragment-fragment interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
Perl script that converts the reads of HiCUP BAM/SAM files into restriction fragments and
counts the fragment-fragment interactions (writes <file>.fragment_interaction_matix.txt.gz).
(The script prints no help; this text is its usage errors and options.)

Usage:
make_hic_array.pl --digest [HiCUP digest file] [HiCUP BAM/SAM files]

Please specify files to process.
Please specify a HiCUP --digest file.

--digest   HiCUP digest file (made by hicup_digester)
```

## hicup_find_common_fragment_interactions

### Tool Description
Compares pairs of interaction matrix files and reports the interactions common and not common to both.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
- **Homepage**: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
- **Package**: https://anaconda.org/channels/bioconda/packages/hicup/overview
- **Validation**: PASS

### Original Help Text
```text
Perl script takes interaction matrix file pairs and reports the interactions common/not
common to both files.
(The script prints no help; this text is its header comment and usage errors.)

Usage:
find_common_fragment_interactions.pl [file1 file2] [file3 file4] ...

Please specify files to process.
Please sepcifiy an even number of files.

Files are fragment interaction matrices (from make_hic_array.pl), compared in pairs. For each
pair it writes <file1>.AND.<file2>.gz, <file1>.NOT.<file2>.gz, <file2>.NOT.<file1>.gz and
common_fragment_interactions_summary.txt.
```

## Metadata
- **Skill**: generated
