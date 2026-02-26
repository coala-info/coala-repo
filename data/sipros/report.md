# sipros CWL Generation Report

## sipros

### Tool Description
Sipros tool for processing MS2 or FT2 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
- **Homepage**: https://github.com/thepanlab/Sipros4
- **Package**: https://anaconda.org/channels/bioconda/packages/sipros/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sipros/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-12-18
- **GitHub**: https://github.com/thepanlab/Sipros4
- **Stars**: N/A
### Original Help Text
```text
Number of threads: 20
Usage 1: 
-w WorkingDirectory -c ConfigurationFile -o OutputDirectory
Usage 2: 
-w WorkingDirectory -g ConfigurationFileDirectory -o OutputDirectory
Usage 3: 
-f single_FT2_or_MZML_file -c ConfigurationFile -o OutputDirectory
Usage 4: 
-f single_FT2_or_MZML_file -fasta proteins.fasta -c ConfigurationFile -o OutputDirectory
Parameters: 
-c configure file to be used
-g configure file directory 
-f a single MS2 or FT2 file to be processed
-w directory of MS2 or FT2 files to be processed
-fasta to set fasta file out of the configuration file
-o output directory
If not specified, it is the same as that of the input scan file,
-s silence all standard output.
If configuration file is not specified, Sipros will look for SiprosConfig.cfg in the directory of FT2 files
```

