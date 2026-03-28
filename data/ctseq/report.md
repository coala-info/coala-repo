# ctseq CWL Generation Report

## ctseq_make_methyl_ref

### Tool Description
Build a reference methylation genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ryanhmiller/ctseq
- **Stars**: N/A
### Original Help Text
```text
usage: ctseq make_methyl_ref [-h] [-r REFDIR]

optional arguments:
  -h, --help            show this help message and exit
  -r REFDIR, --refDir REFDIR
                        Path to the directory where you want to build your
                        reference methylation genome. Must contain a reference
                        file for your intended targets with extension (.fa).
                        If this flag is not used, it is assumed that your
                        current working directory contains your reference file
                        and that you want to build your reference in your
                        current working directory.
```


## ctseq_add_umis

### Tool Description
Add UMIs to fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq add_umis [-h] --umiType {separate,inline} -l UMILENGTH [-d DIR]
                      --forwardExt FORWARDEXT --reverseExt REVERSEEXT
                      [--umiExt UMIEXT]

optional arguments:
  -h, --help            show this help message and exit
  --umiType {separate,inline}
                        Choose 'separate' if the UMIs for the reads are
                        contained in a separate fastq file where the line
                        after the read name is the UMI. Choose 'inline' if the
                        UMIs are already included in the forward/reverse read
                        fastq files in the following format: '@M01806:488:0000
                        00000-J36GT:1:1101:15963:1363:GTAGGTAAAGTG
                        1:N:0:CGAGTAAT' where 'GTAGGTAAAGTG' is the UMI
  -l UMILENGTH, --umiLength UMILENGTH
                        Length of UMI sequence, e.g. 12 (required)
  -d DIR, --dir DIR     Path to directory containing fastq files;
                        forward/reverse reads and umi files. If no '--dir' is
                        specified, ctseq will look in your current directory.
  --forwardExt FORWARDEXT
                        Unique extension of fastq files containing FORWARD
                        reads. Make sure to include '.gz' if your files are
                        compressed (required)
  --reverseExt REVERSEEXT
                        Unique extension of fastq files containing REVERSE
                        reads. Make sure to include '.gz' if your files are
                        compressed (required)
  --umiExt UMIEXT       Unique extension of fastq files containing the UMIs
                        (This flag is REQUIRED if UMIs are contained in
                        separate fastq file). Make sure to include '.gz' if
                        your files are compressed.
```


## ctseq_align

### Tool Description
Aligns sequencing reads to a reference genome and prepares methylation calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq align [-h] [-r REFDIR] [-d DIR] [--forwardAdapter FORWARDADAPTER]
                   [--reverseAdapter REVERSEADAPTER] [-c CUTADAPTCORES]
                   [-b BISMARKCORES] [--readsPerFile READSPERFILE]

optional arguments:
  -h, --help            show this help message and exit
  -r REFDIR, --refDir REFDIR
                        Full path to directory where you have already built
                        your methylation reference files. If no '--refDir' is
                        specified, ctseq will look in your current directory.
  -d DIR, --dir DIR     Path to directory where you have your fastq files. If
                        no '--dir' is specified, ctseq will look in your
                        current directory.
  --forwardAdapter FORWARDADAPTER
                        adapter sequence to remove from FORWARD reads
                        (default=AGTGTGGGAGGGTAGTTGGTGTT)
  --reverseAdapter REVERSEADAPTER
                        adapter sequence to remove from REVERSE reads
                        (default=ACTCCCCACCTTCCTCATTCTCTAAGACGGTGT)
  -c CUTADAPTCORES, --cutadaptCores CUTADAPTCORES
                        number of cores to use with Cutadapt. Default=1.
                        Highly recommended to run with more than 1 core, try
                        starting with 18 cores
  -b BISMARKCORES, --bismarkCores BISMARKCORES
                        number of cores to use to align with Bismark.
                        Default=1. Highly recommended to run with more than 1
                        core, try starting with 6 cores
  --readsPerFile READSPERFILE
                        number of reads to analyze per fastq file (should only
                        adjust this if you think you are too big of a file
                        through bismark). Default=5000000 (5 million)
```


## ctseq_call_molecules

### Tool Description
Call methylation states for molecules based on UMIs and consensus threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq call_molecules [-h] [-r REFDIR] [-d DIR] [-c CONSENSUS]
                            [-p PROCESSES] [-u UMITHRESHOLD]
                            [-a UMICOLLAPSEALG]

optional arguments:
  -h, --help            show this help message and exit
  -r REFDIR, --refDir REFDIR
                        Full path to directory where you have already built
                        your methylation reference files. If no '--refDir' is
                        specified, ctseq will look in your current directory.
  -d DIR, --dir DIR     Full path to directory where your .sam files are
                        located. If no '--dir' is specified, ctseq will look
                        in your current directory.
  -c CONSENSUS, --consensus CONSENSUS
                        consensus threshold to make consensus methylation call
                        from all the reads with the same UMI (default=0.9)
  -p PROCESSES, --processes PROCESSES
                        number of processes (default=1; default settings could
                        take a long time to run)
  -u UMITHRESHOLD, --umiThreshold UMITHRESHOLD
                        UMIs with this edit distance will be collapsed
                        together, default=0 (don't collapse)
  -a UMICOLLAPSEALG, --umiCollapseAlg UMICOLLAPSEALG
                        algorithm used to collapse UMIs, options:
                        default=directional
```


## ctseq_call_methylation

### Tool Description
Call methylation status for molecules.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq call_methylation [-h] [-r REFDIR] [-d DIR] -n NAMERUN
                              [-p PROCESSES] [-c CISCG] [-m MOLECULETHRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  -r REFDIR, --refDir REFDIR
                        Full path to directory where you have already built
                        your methylation reference files. If no '--refDir' is
                        specified, ctseq will look in your current directory.
  -d DIR, --dir DIR     Full path to directory where your '*allMolecules.txt'
                        files are located. If no '--dir' is specified, ctseq
                        will look in your current directory.
  -n NAMERUN, --nameRun NAMERUN
                        number of reads needed to be counted as a unique
                        molecule (required)
  -p PROCESSES, --processes PROCESSES
                        number of processes (default=1)
  -c CISCG, --cisCG CISCG
                        cis-CG threshold to determine if a molecule is
                        methylated (default=0.75)
  -m MOLECULETHRESHOLD, --moleculeThreshold MOLECULETHRESHOLD
                        number of reads needed to be counted as a unique
                        molecule (default=5)
```


## ctseq_analyze

### Tool Description
Analyze sequencing data from ctseq.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq analyze [-h] --umiType {separate,inline} --umiLength UMILENGTH
                     [-d DIR] [-r REFDIR] --forwardExt FORWARDEXT --reverseExt
                     REVERSEEXT [--umiExt UMIEXT]
                     [--forwardAdapter FORWARDADAPTER]
                     [--reverseAdapter REVERSEADAPTER]
                     [--cutadaptCores CUTADAPTCORES]
                     [--bismarkCores BISMARKCORES]
                     [--readsPerFile READSPERFILE] [--consensus CONSENSUS]
                     [-p PROCESSES] [--umiThreshold UMITHRESHOLD]
                     [--umiCollapseAlg UMICOLLAPSEALG] -n NAMERUN
                     [--cisCG CISCG] [--moleculeThreshold MOLECULETHRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  --umiType {separate,inline}
                        Choose 'separate' if the UMIs for the reads are
                        contained in a separate fastq file where the line
                        after the read name is the UMI. Choose 'inline' if the
                        UMIs are already included in the forward/reverse read
                        fastq files in the following format: '@M01806:488:0000
                        00000-J36GT:1:1101:15963:1363:GTAGGTAAAGTG
                        1:N:0:CGAGTAAT' where 'GTAGGTAAAGTG' is the UMI
  --umiLength UMILENGTH
                        Length of UMI sequence, e.g. 12 (required)
  -d DIR, --dir DIR     Path to directory where you have your fastq files. If
                        no '--dir' is specified, ctseq will look in your
                        current directory.
  -r REFDIR, --refDir REFDIR
                        Full path to directory where you have already built
                        your methylation reference files. If no '--refDir' is
                        specified, ctseq will look in your current directory.
  --forwardExt FORWARDEXT
                        Unique extension of fastq files containing FORWARD
                        reads. Make sure to include '.gz' if your files are
                        compressed (required)
  --reverseExt REVERSEEXT
                        Unique extension of fastq files containing REVERSE
                        reads. Make sure to include '.gz' if your files are
                        compressed (required)
  --umiExt UMIEXT       Unique extension of fastq files containing the UMIs
                        (This flag is REQUIRED if UMIs are contained in
                        separate fastq file). Make sure to include '.gz' if
                        your files are compressed.
  --forwardAdapter FORWARDADAPTER
                        adapter sequence to remove from FORWARD reads
                        (default=AGTGTGGGAGGGTAGTTGGTGTT)
  --reverseAdapter REVERSEADAPTER
                        adapter sequence to remove from REVERSE reads
                        (default=ACTCCCCACCTTCCTCATTCTCTAAGACGGTGT)
  --cutadaptCores CUTADAPTCORES
                        number of cores to use with Cutadapt. Default=1.
                        Highly recommended to run with more than 1 core, try
                        starting with 18 cores
  --bismarkCores BISMARKCORES
                        number of cores to use to align with Bismark.
                        Default=1. Highly recommended to run with more than 1
                        core, try starting with 6 cores
  --readsPerFile READSPERFILE
                        number of reads to analyze per fastq file (should only
                        adjust this if you think you are too big of a file
                        through bismark). Default=5000000 (5 million)
  --consensus CONSENSUS
                        consensus threshold to make consensus methylation call
                        from all the reads with the same UMI (default=0.9)
  -p PROCESSES, --processes PROCESSES
                        number of processes (default=1; default settings could
                        take a long time to run)
  --umiThreshold UMITHRESHOLD
                        UMIs with this edit distance will be collapsed
                        together, default=0 (don't collapse)
  --umiCollapseAlg UMICOLLAPSEALG
                        algorithm used to collapse UMIs, options:
                        default=directional
  -n NAMERUN, --nameRun NAMERUN
                        number of reads needed to be counted as a unique
                        molecule (required)
  --cisCG CISCG         cis-CG threshold to determine if a molecule is
                        methylated (default=0.75)
  --moleculeThreshold MOLECULETHRESHOLD
                        number of reads needed to be counted as a unique
                        molecule (default=5)
```


## ctseq_plot

### Tool Description
Generate plots from CT-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq plot [-h] [--dir DIR] --fragInfo FRAGINFO

optional arguments:
  -h, --help           show this help message and exit
  --dir DIR            Path to directory where you have your plot input files.
                       If no '--dir' is specified, ctseq will look in your
                       current directory.
  --fragInfo FRAGINFO  Name of file containing your fragment info file for
                       this sequencing run. If not in same directory as your
                       plot input files, please designate full path to the
                       'fragInfo' file. See documentation for more info
                       (required)
```


## ctseq_plot_multiple

### Tool Description
Create plots for multiple samples combined.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctseq:0.0.2--py_0
- **Homepage**: https://github.com/ryanhmiller/ctseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ctseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ctseq plot_multiple [-h] [--dir DIR] --fragInfo FRAGINFO --name NAME

optional arguments:
  -h, --help           show this help message and exit
  --dir DIR            Path to directory where you want your plots to be
                       created. If no path is given, ctseq will create the
                       plots in your current working directory. Remember to
                       include a file ending in '_directories.txt' containing
                       the paths of the directories containing the data you
                       want to plot
  --fragInfo FRAGINFO  Name of file containing your fragment info file for
                       these combined plots. If not in same directory as your
                       current working directory, please designate full path
                       to the 'fragInfo' file. See documentation for more info
                       (required)
  --name NAME          Desired name to be used as the prefix for the file
                       names of these plots (required)
```


## Metadata
- **Skill**: generated
