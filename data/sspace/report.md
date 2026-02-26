# sspace CWL Generation Report

## sspace

### Tool Description
SSPACE Basic is a tool for scaffolding genome assemblies using paired-end sequencing data.

### Metadata
- **Docker Image**: biocontainers/sspace:v2.1.1dfsg-4-deb_cv1
- **Homepage**: https://github.com/imhuay/sspace
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sspace/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/imhuay/sspace
- **Stars**: N/A
### Original Help Text
```text
/usr/share/sspace/SSPACE_Basic_v2.0.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.28.1.

Usage: SSPACE_Basic_v2.0.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -m -o -v -p -k -a -z -s -b -n -l -x -u -t -T -g -r

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
ERROR: Parameter -l is required. Please insert a library file
ERROR: Parameter -s is required. Please insert a contig FASTA file

Usage:

============ General Parameters ============

-l  Library file containing two paired read files with insert size, error and either mate pair or paired end indication (REQUIRED)

-s  FASTA file containing contig sequences used for extension. Inserted pairs are mapped to extended and non-extended contigs (REQUIRED)

-x  Indicate whether to extend the contigs of -s using paired reads in -l (-x 1=extension, -x 0=no extension, default -x 0)

============ Extension Parameters ============

-m  Minimum number of overlapping bases with the seed/contig during overhang consensus build up (default -m 32)

-o  Minimum number of reads needed to call a base during an extension (default -o 20)

-t  Trim up to -t base(s) on the contig end when all possibilities have been exhausted for an extension (default -t 0)

-u  FASTA/FASTQ file containing unpaired sequence reads (optional)

-r  Minimum base ratio used to accept a overhang consensus base (default -r 0.9)

============ Scaffolding Parameters ============

-z  Minimum contig length used for scaffolding. Filters out contigs below this value (default -z 0)

-k  Minimum number of links (read pairs) to compute scaffold (default -k 5)

-a  Maximum link ratio between two best contig pairs. *Higher values lead to least accurate scaffolding* (default -a 0.7)

-n  Minimum overlap required between contigs to merge adjacent contigs in a scaffold (default -n 15)

============ Bowtie Parameters ============

-g  Maximum number of allowed gaps during mapping with Bowtie. Corresponds to the -v option in Bowtie. *Higher number of allowed gaps can lead to least accurate scaffolding* (default -g 0)

-T  Specify the number of threads in Bowtie. Corresponds to the -p/--threads option in Bowtie (default -T 1)

============ Additional Parameters ============

-b  Base name for your output files (default -b standard_output)

-v  Runs in verbose mode (-v 1=yes, -v 0=no, default -v 0)

-p  Make .dot file for visualisation (-p 1=yes, -p 0=no, default -p 0)
```


## Metadata
- **Skill**: generated

## sspace

### Tool Description
SSPACE Basic is a tool for scaffolding genome assemblies using paired-end sequencing data.

### Metadata
- **Docker Image**: biocontainers/sspace:v2.1.1dfsg-4-deb_cv1
- **Homepage**: https://github.com/imhuay/sspace
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
/usr/share/sspace/SSPACE_Basic_v2.0.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.28.1.

Usage: SSPACE_Basic_v2.0.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -m -o -v -p -k -a -z -s -b -n -l -x -u -t -T -g -r

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
ERROR: Parameter -l is required. Please insert a library file
ERROR: Parameter -s is required. Please insert a contig FASTA file

Usage:

============ General Parameters ============

-l  Library file containing two paired read files with insert size, error and either mate pair or paired end indication (REQUIRED)

-s  FASTA file containing contig sequences used for extension. Inserted pairs are mapped to extended and non-extended contigs (REQUIRED)

-x  Indicate whether to extend the contigs of -s using paired reads in -l (-x 1=extension, -x 0=no extension, default -x 0)

============ Extension Parameters ============

-m  Minimum number of overlapping bases with the seed/contig during overhang consensus build up (default -m 32)

-o  Minimum number of reads needed to call a base during an extension (default -o 20)

-t  Trim up to -t base(s) on the contig end when all possibilities have been exhausted for an extension (default -t 0)

-u  FASTA/FASTQ file containing unpaired sequence reads (optional)

-r  Minimum base ratio used to accept a overhang consensus base (default -r 0.9)

============ Scaffolding Parameters ============

-z  Minimum contig length used for scaffolding. Filters out contigs below this value (default -z 0)

-k  Minimum number of links (read pairs) to compute scaffold (default -k 5)

-a  Maximum link ratio between two best contig pairs. *Higher values lead to least accurate scaffolding* (default -a 0.7)

-n  Minimum overlap required between contigs to merge adjacent contigs in a scaffold (default -n 15)

============ Bowtie Parameters ============

-g  Maximum number of allowed gaps during mapping with Bowtie. Corresponds to the -v option in Bowtie. *Higher number of allowed gaps can lead to least accurate scaffolding* (default -g 0)

-T  Specify the number of threads in Bowtie. Corresponds to the -p/--threads option in Bowtie (default -T 1)

============ Additional Parameters ============

-b  Base name for your output files (default -b standard_output)

-v  Runs in verbose mode (-v 1=yes, -v 0=no, default -v 0)

-p  Make .dot file for visualisation (-p 1=yes, -p 0=no, default -p 0)
```

