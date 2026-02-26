# lightassembler CWL Generation Report

## lightassembler_LightAssembler

### Tool Description
Light Version of an assembly algorithm for short reads in FASTA/FASTQ/FASTA.gz/FASTQ.gz formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/lightassembler:1.0--h077b44d_8
- **Homepage**: https://github.com/SaraEl-Metwally/LightAssembler
- **Package**: https://anaconda.org/channels/bioconda/packages/lightassembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lightassembler/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/SaraEl-Metwally/LightAssembler
- **Stars**: N/A
### Original Help Text
```text
--- no read files specified as inputs
--- invalid value for genome size: 0

 ********************************** <<<   LightAssembler  >>> *************************************** 

 Light Version of an assembly algorithm for short reads in FASTA/FASTQ/FASTA.gz/FASTQ.gz formats.

 Usage: ./LightAssembler [Options] ...FASTA/FASTQ/FASTA.gz/FASTQ.gz files

  [-k] kmer size                                [default: 31] 
  [-g] gap size                                 [default: 25X:3 35X:4 75X:8 140X:15 280X:25] 
  [-e] expected error rate                      [default: 0.01 ] 
  [-G] genome size                              [default: 0] 
  [-t] number of threads                        [default: 1]
  [-o] output file name                         [default: LightAssembler] 

 Typical LightAssembler Command Line :

 ./LightAssembler -k 31 -g 13 -e 0.01 -G 1000000 -t 1 -o LightAssembler read_file1 read_file2 --verbose 

 ****************************************************************************************************
```

