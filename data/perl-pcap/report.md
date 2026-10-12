# perl-pcap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-pcap_bamToBw.pl | Failed | image problem: bam2bw is not installed in the image |
| perl-pcap_bam_stats.pl | PASS |  |
| perl-pcap_bam_to_sra_sub.pl | Not completed | needs a PCAP-made BAM with PM read-group tag and a GNOS server; no such data (bwa missing) |
| perl-pcap_bwa_aln.pl | Failed | image problem: bwa is not installed in the image (script stops with 'Failed to find bwa') |
| perl-pcap_bwa_mem.pl | Failed | image problem: bwa is not installed in the image (script stops with 'Failed to find bwa') |
| perl-pcap_detectExtremeDepth.pl | Failed | image problem: Perl module Bio::DB::BigWig is missing |
| perl-pcap_diff_bams.pl | Failed | tool bug: reports one matching record too many (201 for a 200-read BAM) |
| perl-pcap_gnos_pull.pl | Not completed | needs GNOS repositories, network and permission keys |
| perl-pcap_monitor.pl | PASS |  |
| perl-pcap_xam_coverage_bins.pl | PASS |  |
| perl-pcap_xml_to_bas.pl | Not completed | needs GNOS analysis XML from a GNOS server; no local test data |

## perl-pcap_bwa_mem.pl

### Tool Description
BWA MEM alignment wrapper for processing BAM, CRAM, or FASTQ files, including support for duplicate marking and CRAM conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Total Downloads**: 20.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Stars**: N/A
### Original Help Text
```text
Usage:
    bwa_mem.pl [options] [file(s)...]

      Required parameters:
        -outdir      -o   Folder to output result to.
        -reference   -r   Path to reference genome file *.fa[.gz]
        -sample      -s   Sample name to be applied to output file.
        -threads     -t   Number of threads to use. [1]

      Optional parameters:
        -fragment    -f   Split input into fragements of X million repairs [10]
        -nomarkdup   -n   Don't mark duplicates
        -cram        -c   Output cram, see '-sc'
        -scramble    -sc  Single quoted string of parameters to pass to Scramble when '-c' used
                          - '-I,-O' are used internally and should not be provided
        -bwa         -b     Single quoted string of additional parameters to pass to BWA
                             - '-t,-p,-R' are used internally and should not be provided
        -map_threads -mt  Number of cores applied to each parallel BWA job when '-t' exceeds this value and '-i' is not in use[6]

      Targeted processing:
        -process     -p   Only process this step then exit, optionally set -index
                            bwamem - only applicable if input is bam
                              mark - Run duplicate marking (-index N/A)
                             stats - Generates the *.bas file for the final BAM.

        -index       -i   Optionally restrict '-p' to single job
                            bwamem - 1..<lane_count>

      Performance variables
        -bwa_pl      -l   BWA runs ~8% quicker when using the tcmalloc library from
                          https://github.com/gperftools/ (assuming number of cores not exceeded)
                          If available specify the path to 'gperftools/lib/libtcmalloc_minimal.so'.

      Other:
        -jobs        -j   For a parallel step report the number of jobs required
        -help        -h   Brief help message.
        -man         -m   Full documentation.

    File list can be full file names or wildcard, e.g.

    mutiple BAM inputs
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.bam

    multiple paired fastq inputs
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*_[12].fq[.gz]

    multiple interleaved paired fastq inputs
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.fq[.gz]

    mixture of BAM and CRAM
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.bam input/*.cram
```


## perl-pcap_gnos_pull.pl

### Tool Description
PCAP GNOS pull tool for retrieving ALIGNMENTS or CALLS metadata and data from GNOS repositories.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    ./gnos_pull.pl [-h] -u http://pancancer.info/gnos_metadata/latest/ -c
    gnos_pull.ini -o local_mirror/

      Required input:

        --analysis  (-a)  ALIGNMENTS or CALLS

        --outdir    (-o)  Where to save jsonl and resulting GNOS downloads

        --config    (-c)  Mapping of GNOS repos to permissions keys

      Other options:

        --symlinks  (-s)  Rebuild symlinks only.

        --threads   (-t)  Number of parallel GNOS retrievals.

        --url       (-u)  The base URL to retrieve jsonl file from
                            [http://pancancer.info/gnos_metadata/latest/]

        --info      (-i)  Just prints how many donor's will be included in pull and some stats.

        --debug     (-d)  prints extra debug information

        --help      (-h)  Brief documentation

        --man       (-m)  More verbose usage info
```

## perl-pcap_bam_stats.pl

### Tool Description
Generate a .bas statistics file for a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    bam_stats.pl [options] [file...]

      Required parameters:
        -input    -i   File path to read in.
        -output   -o   File path to output. Defaults to STDOUT.

      Optional parameters:
        -plots    -p   Folder to contain quality score plots.
                        - not available with '-t'
        -threads  -t   Use multiple threads to process the input
                        - warning the complete file is read for each thread.

      Other:
        -help     -h   Brief help message.
        -man      -m   Full documentation.
        -version  -v   Prints the version number.

        bam_stats.pl -i my.bam -o my.bam.bas
        bam_stats.pl -i my.bam > my.bam.bas

Options:
    -input  File path to read. Accepts only .bam files.

    -output File path to output data. If this option is omitted the script
            will attempt to write to STDOUT. The

    -plots  Directory to place quality plot images. If omitted no
            information about base qualities will be collected, thus
            speeding up the stats collection.

    -help   Print a brief help message and exits.

    -man    Prints the manual page and exits.

    -version
            Prints the version number and exits.
```

## perl-pcap_xam_coverage_bins.pl

### Tool Description
Coverage of target regions from a BAM/CRAM file in depth bins

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    xam_coverage_bins.pl [options]

      Required parameters:
        -xam_file              -f    bam|cram file to check coverage.
        -target_file           -r    bed|gff3 file of targets.
        -output_file           -o    file to write JSON string output of coverage
        -type                  -t    Type of target file provided [bed|gff3]

      Other:
        -version               -v   Print version and exit.
        -help                  -h   Brief help message.
        -man                   -m   Full documentation.

Options:
    -type   Type of target file passed [bed|gff]

    -xam_files
            bam|cram file to check coverage.

    -target_file
            bed|gff3 file of targets.

    -help   Prints the help for this script

    -man    Prints the man page for this script
```

## perl-pcap_monitor.pl

### Tool Description
Run a command and report wall time, CPU time and peak memory

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
monitor.pl COMMAND [ARGS...]

Runs the command and prints a job summary with wall time, CPU time and peak memory of all processes.
(The script has no help option; usage taken from its source.)
```

## perl-pcap_diff_bams.pl

### Tool Description
Compare two BAM/CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    diff_bams.pl 1.bam 2.bam or diff_bams.pl -a 1.bam -b 2.bam

    It is rare that BAM files can be compared via MD5 due to various
    processing information being incorporated into the header such as
    input/output paths. This program works around this by only comparing
    relevant information such as:

      1. Same number and order of @SQ headers.
      2. All reads are in same order.

    You are able to compare a BAM vs it's corresponding CRAM

      Required parameters:
        -bam_a    -a    The first BAM|CRAM file.
        -bam_b    -b    The second BAM|CRAM file.

      Other:
        -ref      -r    Required for CRAM, genome.fa with co-located fai.
        -count    -c    Count flag differences
        -skipz    -s    Don't include reads with MAPQ=0 in comparison
        -help     -h    Brief help message.
        -man      -m    Full documentation.

      Run with '-m' for more detail

Options:
    -bam_a  A valid readable BAM file

    -bam_b  A valid readable BAM file (different to bam_a)

    -skipz  As reads with MAPQ zero can end up in multiple locations don't
            consider them as a mismatch.

    -help   Print a brief help message and exits.

    -man    Prints the manual page and exits.
```

## perl-pcap_bwa_aln.pl

### Tool Description
Align reads with BWA aln/sampe using the PCAP pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    bwa_aln.pl [options] [file(s)...]

      Required parameters:
        -outdir    -o   Folder to output result to.
        -reference -r   Path to reference genome file *.fa[.gz]
        -sample    -s   Sample name to be applied to output file.
        -threads   -t   Number of threads to use. [1]

      Targeted processing:
        -process   -p   Only process this step then exit, optionally set -index
                          bam2fq - only applicable if input is bam
                             aln - Run 'bwa aln'
                           sampe - Run 'bwa sampe' and sorting to BAM
                            mark - Run duplicate marking (-index N/A)

        -index     -i   Optionally restrict '-p' to single job
                          bam2fq - 1..<lane_count>
                             aln - 1..<lane_count*2>
                           sampe - 1..<lane_count>

      Other:
        -help      -h   Brief help message.
        -man       -m   Full documentation.

      File list can be full file names or wildcard, e.g.
        bwa_aln.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.fq.gz

      Run with '-m' for possible input file types.

Options:
    -outdir Directory to write output to. During processing a temp folder
            will be generated in this area, should the process fail only
            delete this if you are unable to resume the process.

            Final output files include: <SAMPLE>.bam, <SAMPLE>.bam.bai,
            <SAMPLE>.md5, <SAMPLE>.met

    -reference
            Path to genome.fa[.gz] file and associated indexes for BWA.

    -sample Name to be applied to output files. Special characters will not
            be magically fixed.

    -threads
            Number of threads to be used in processing.

            If perl is not compiled with threading some steps will not run
            in parallel, however much of the script calls other tools that
            will still utilise this appropriately.

    -help   Print a brief help message and exits.

    -man    Prints the manual page and exits.

  Targeted Processing:
    -process
            If you want to run the code in a more efficient manner then this
            allows each procesing type to be executed in isolation. You can
            restrict to a single process within the block by specifying
            -index as well.

  Input File Types:
    There are several types of file that the script is able to process.

    f[ast]q A standard uncompressed fastq file. Requires a pair of inputs
            with standard suffix of '_1' and '_2' immediately prior to
            '.f[ast]q'.

    f[ast]q.gz
            As *.f[ast]q but compressed with gzip.

    bam     A list of single lane BAM files, no information is taken from
            the headers.

            This method has additional processing converted to *.fq.gz to
            give common start point.
```

## perl-pcap_bamToBw.pl

### Tool Description
Convert a BAM/CRAM file to BigWig files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    bamToBw.pl [options] [file(s)...]

      Required parameters:
        -bam       -b   BAM/CRAM file to be processed.
        -outdir    -o   Folder to output result to.
        -reference -r   Path to genome.fa.
                         - Actually using fa.fai but for convention just provide '.fa' file

      Optional parameters:
        -threads   -t   Number of threads to use. [1]
        -filter    -f   Ignore reads with the filter flags [int]

      Targeted processing:
        -process   -p   Only process this step then exit, optionally set -index
                             bamToBw - Per chromosome BigWigs
                          generateBw - Generates merged BigWig

        -index     -i   Optionally restrict '-p' to single job
                          bwamem - 1..<lane_count>

      Other:
        -jobs      -j   For a parallel step report the number of jobs required
        -help      -h   Brief help message.
        -man       -m   Full documentation.

      Basic usage:
        bamToBw.pl -t 16 -b in.bam -o out.bw

      Advanced/farm usage:
        bamToBw.pl -b in.bam -o out.bw -p bamToBw -i 1..X
         # X can be determined with 'bamToBw.pl -b in.bam -o out.bw -j'
         # once all above steps completed
        bamToBw.pl -b in.bam -o out.bw -p generateBw -i 1


      Run with '-m' for possible input file types.

Options:
    -outdir Directory to write output to. During processing a temp folder
            will be generated in this area, should the process fail only
            delete this if you are unable to resume the process.

            Final output files include: <SAMPLE>.bam, <SAMPLE>.bam.bai,
            <SAMPLE>.md5, <SAMPLE>.met

    -threads
            Number of threads to be used in processing.

            If perl is not compiled with threading some steps will not run
            in parallel..

    -help   Print a brief help message and exits.

    -man    Prints the manual page and exits.

  Targeted Processing:
    -process
            If you want to run the code in a more efficient manner then this
            allows each procesing type to be executed in isolation. You can
            restrict to a single process within the block by specifying
            -index as well.
```

## perl-pcap_detectExtremeDepth.pl

### Tool Description
Find regions of extreme depth in a BigWig file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
detectExtremeDepth.pl -bigwig FILE -output DIR [-ref CHR] [-decode N:NAME] [-sd N]

Reads a BigWig file and writes a BED file of regions whose depth is more than -sd (default 12)
standard deviations above the per-chromosome mean.
(The script prints no help text without the Bio::DB::BigWig module; the options are taken from its
Getopt::Long specification.)
```

## perl-pcap_bam_to_sra_sub.pl

### Tool Description
Create SRA submission XML files for BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    bam_to_sra_sub.pl [options] [file(s)...]

      Required parameters:
        -outdir    -o   Folder to output result to.
        -gnos      -g   GNOS upload server, e.g.
                          https://gtrepo-ebi.annailabs.com

      Optional:
        -study     -s   Study reference in repository [icgc_pancancer]
        -type      -t   Only required if not encoded in readgroup LB tag.
                          [WGS|WXS|RNA-seq]
                          See '-m' for details

      Other:
        -help      -h   Brief help message.
        -man       -m   Full documentation.

      File list can be full file names, wildcards or combination, e.g.

        bam_to_sra_sub.pl -s icgc_pancancer -o myDonor/tumour_sra myDonor/tumour/*.bam

Options:
    -outdir Directory to write output to. All SRA XML files will be written
            to a 'sample' directory in this area, Associated BAM files and
            MD5s will be symlinked into this area for easy upload.

            Please ensure that you will be able to read from the area with
            GeneTorrent otherwise you will need to copy the data into an
            appropriate location (remembering to follow symlinks).

    -gnos   The path to the GNOS server that this data should be submitted
            to.

    -study  The STUDY_REF that this data is to be assigned to in the
            repository. Defaults to icgc_pancancer when not specified.

    -type   Added for convenience when sequencing type is not encoded into
            the RG:LB tag

              WGS     - Whole Genome Seq
              WXS     - Whole eXome Seq
              RNA-Seq - RNA seq

    -help   Print a brief help message and exits.

    -man    Prints the manual page and exits.
```

## perl-pcap_xml_to_bas.pl

### Tool Description
Convert GNOS analysis XML into a .bas statistics file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    xml_to_bas.pl [options]

      Required parameters:
        -uri        -d    Same URI used by gtdownload
        -output     -o    Name for output file. Defaults to STDOUT.

      Optional parameters:
        -bam       -b  BAM|CRAM file this data relates to
                       - checks retrieved data correlates with expected BAM
                       - additionally can correct read_group_id if other fields correlate when
                         clashes occur.
        -local-path -l Local file path for XML from GNOS.

      Other:
        -help     -h   Brief help message.
        -man      -m   Full documentation.
        -version  -v   Prints the version number.

      Example:
        xml_to_bas.pl -d https://gtrepo-ebi.annailabs.com/cghub/metadata/analysisFull/4e183691-ba1f-4103-a517-948f363928b8 -o file.bam.bas

Options:
    -uri    Which BAS data to download and convert.

    -output File path to output data. If this option is omitted the script
            will attempt to write to STDOUT.

    -help   Print a brief help message and exits.

    -man    Prints the manual page and exits.

    -version
            Prints the version number and exits.
```
