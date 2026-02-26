# rapifilt CWL Generation Report

## rapifilt

### Tool Description
RAPId FILTer

### Metadata
- **Docker Image**: quay.io/biocontainers/rapifilt:1.0--h5ca1c30_7
- **Homepage**: https://github.com/andvides/RAPIFILT.git
- **Package**: https://anaconda.org/channels/bioconda/packages/rapifilt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rapifilt/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/andvides/RAPIFILT
- **Stars**: N/A
### Original Help Text
```text
RAPIFILT:RAPId FILTer
version 2.3 September 2019
Authors
Benavides A, Alzate JF and Cabarcas F
Usage: rapifilt [options]
-h			This help message
-v			Program and version information
-f			Enable fasta output (default fastq)
-l<int>			Set lef-cut value for quality scores (int default 0)
-r<int>			Set right-cut value for quality scores (int default 0)
-w<int>			Set windows size to check on the quality scores (int default 1)
-m<int>			Filter sequence shorter than min_len (int default 1)
-mx<int>		Filter sequence larger than max_len (int default 5000)
-fastq<fastq file>	single fastq input (file.fastq) the file can be gz compressed
-sff<454 files>		454 input (file.sff)
-i<illumina files>	Illumina inputs(file1.fastq file2.fastq) the files can be gz compressed
-o<fastq_file>		Desired fastq output file. If not specified to stdout
-tb<int>		Remove n bases from the begins of sequencing fragments (int default 0)
-te<int>		Remove n bases from the ends of sequencing fragments (int default 0)
-bin<int>		Bin size used to compute statistic per base (int default 1)
Quality input and output is calculated according the formula taken from http://maq.sourceforge.net/fastq.shtml
```

