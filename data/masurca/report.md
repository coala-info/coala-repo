# masurca CWL Generation Report

## masurca

### Tool Description
Create the assembly script from a MaSuRCA configuration file. A sample configuration file can be generated with the -g switch. The assembly script assemble.sh will run the assembly proper. For a quick run without creating a configuration file, and with two Illumina paired end reads files (forward/reverse) and (optionally) a long reads (Nanopore/PacBio) file use -i switch, setting the number of threads with -t:

### Metadata
- **Docker Image**: quay.io/biocontainers/masurca:4.1.4--h6b3f7d6_0
- **Homepage**: http://masurca.blogspot.co.uk/
- **Package**: https://anaconda.org/channels/bioconda/packages/masurca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/masurca/overview
- **Total Downloads**: 84.3K
- **Last updated**: 2025-06-26
- **GitHub**: https://github.com/alekseyzimin/masurca
- **Stars**: N/A
### Original Help Text
```text
Create the assembly script from a MaSuRCA configuration file. A
sample configuration file can be generated with the -g switch. The
assembly script assemble.sh will run the assembly proper. For a 
quick run without creating a configuration file, and with two Illumina 
paired end reads files (forward/reverse) and (optionally) a 
long reads (Nanopore/PacBio) file use -i switch, setting the number of threads with -t:

masurca -i paired_ends_fwd.fastq.gz -t 32
or
masurca -i paired_ends_fwd.fastq.gz,paired_ends_rev.fastq.gz -t 32

,and for a hybrid assembly you can also add the long Nanopore or PacBio reads with -r switch:

masurca -i paired_ends_fwd.fastq.gz,paired_ends_rev.fastq.gz -r nanopore.fa.gz -t 32

this will run paired-ends Illumina or hybrid assembly with CABOG contigger and default settings.  
This is suitable for small assembly projects.

Options:
 -t, --threads             ONLY to use with -i option, number of threads
 -i, --illumina            Run assembly without creating configuration file, argument can be 
                              illumina_paired_end_forward_reads 
                                or 
                              illumina_paired_end_forward_reads,illumina_paired_end_reverse_reads
                           Illumina read file names must be comma-separated, without a space in the middle.
                           Illumina read files must be fastq, with valid quality values, can be gzipped.
 -r, --reads               ONLY to use with -i option, single long reads file for hybrid assembly, can be Nanopore or PacBio, 
                           fasta or fastq, can be gzipped

 -v, --version             Report version
 -o, --output              Assembly script (assemble.sh)
 -g, --generate            Generate example configuration file
 -p, --path                Prepend to PATH in assembly script
 -l, --ld-library-path     Prepend to LD_LIBRARY_PATH in assembly script
     --skip-checking       Skip checking availability of other executables
 -h, --help                This message
```

