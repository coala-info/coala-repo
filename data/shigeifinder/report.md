# shigeifinder CWL Generation Report

## shigeifinder

### Tool Description
ShigeiFinder.py is a tool for analyzing assembly or raw read data.

### Metadata
- **Docker Image**: quay.io/biocontainers/shigeifinder:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/LanLab/ShigEiFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/shigeifinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shigeifinder/overview
- **Total Downloads**: 16.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LanLab/ShigEiFinder
- **Stars**: N/A
### Original Help Text
```text
usage: 
Assembly fasta input/s:
 ShigeiFinder.py -i <input_data1> <input_data2> ... OR
 ShigeiFinder.py -i <directory/*> 
Paired end raw read fastq(.gz) input/s:
 ShigeiFinder.py -r -i <Read1> <Read2> OR 
 ShigeiFinder.py -r -i <directory/*> 
Single end raw read fastq(.gz) input/s:
 ShigeiFinder.py -r --single_end -i <Reads> OR 
 ShigeiFinder.py -r --single_end -i <directory/*>

options:
  -h, --help            show this help message and exit
  -i I [I ...]          <string>: path/to/input_data
  -r                    Add flag if file is raw reads.
  -t T                  number of threads. Default 4.
  --single_end          Add flag if raw reads are single end rather than
                        paired.
  --hits                To show the blast/alignment hits
  --dratio              To show the depth ratios of cluster-specific genes to
                        House Keeping genes
  --update_db           Add flag if you added new sequences to genes database.
  --output OUTPUT       output file to write to (if not used writes to stdout)
  --check               To show the blast/alignment hits
  --o_depth O_DEPTH     When using reads as input the minimum depth percentage
                        relative to genome average for positive O antigen gene
                        call (default 1.0).
  --ipaH_depth IPAH_DEPTH
                        When using reads as input the minimum depth percentage
                        relative to genome average for positive ipaH gene call
                        (default 1.0).
  --depth DEPTH         When using reads as input the minimum read depth for
                        non ipaH/Oantigen gene to be called (default 10.0).
  --tmpdir TMPDIR       temporary folder to use for intermediate files
  --noheader            do not print output header
  -v, --version         Print version information.
```

