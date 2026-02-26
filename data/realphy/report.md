# realphy CWL Generation Report

## realphy

### Tool Description
RealPhy is a tool for phylogenetic analysis. It takes a folder of sequence files and outputs a phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/realphy:1.13--hdfd78af_1
- **Homepage**: https://realphy.unibas.ch/fcgi/realphy
- **Package**: https://anaconda.org/channels/bioconda/packages/realphy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/realphy/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin
Usage:
java -Xmx[available RAM in MB]m -jar RealPhy_v1.12.jar [Sequence folder] [Output folder] [Options]
Sequence folder needs to contain fasta files ending with .fas, .fna, .fasta or .fa, genbank files ending in .gbk or .gb and short read files in fastq format ending in .fastq or fastq.gz.
The output folder needs to contain a file called "config.txt", which contains information about the location of the required executables such as bowtie2.

Options:
-readLength [integer] default=50 Possible values: Integer greater than 30; Size of fragments that are to be produced from the FASTA/GBK input sequences. With longer read lengths the mapping will take longer but will also map more divergent sequences.
-quality [integer] default=20; Possible values: Integer value between 0 and 41 that corresponds to quality values in fastq files (PHRED+33). Bases with values below thresold in fastq file will not be considered (fasta files will be converted into fastq files with a quality of 20).
-polyThreshold [double] default=0.95; Possible values: Double value between 0 and 1.  Polymorphisms that occur at lower frequency than the specified threshold at any given position of the alignment will not be considered.
-perBaseCov [integer] default=10; Possible values: Integer greater than or equal to 10.  Polymorphisms will only be extracted for regions that are covered by more than the set threshold of reads.
-ref [sequence file name (without extension or path!)] default=random; Possible values: The file name of a sequence data set without the extension (.fas, .fasta, .fa, .fna, .fastq, .fastq.gz, .gb or .gbk). Sets the reference sequence.
-root [sequence file name (without extension or path!)] default=random; Possible values: The file name of a sequence data set without the extension (.fas, .fasta, .fa, .fna, .fastq, .fastq.gz, .gb or .gbk).  Specifies the root of the tree.
-refN [sequence file name (without extension or path!)] where N is the n-th reference genome; default=not set; Possible values: The file name of a sequence data set without the extension (.fas, .fasta, .fa, .fna, .fastq, .fastq.gz, .gb or .gbk).
-genes If set then genes (CDS) are extracted from a given genbank file.
-gapThreshold [double] default=0; specifies the proportion of input sequences that are allowed to contain gaps in the final sequence alignment (i.e. if set to 0.2 at most 20% of all nucleotides in each final alignment column are allowed to be gaps).
-clean/-c If set then the whole analysis will be rerun and existing data will be overwritten!
-treeBuilder [integer] default=4;
   0=Do not build a tree;
   1=treepuzzle; 
   2=raxml
   3=max. parsimony (dnapars)
   4=PhyML (default)
-quiet/-q If set then it suppresses any program output except for errors or warnings.
-varOnly/-v If set then homologous positions that are conserved in all input sequences are put out. If set then the reconstructed tree may be wrong.
-seedLength [integer] default=22 Possible values: Integer between 4 and 32; specifies k-mer length in bowtie2.
-suffix [string] default=not set; appends a suffix to the reference output folder.
-d/-delete If this option is set then all alignment output files and sequence cut files will be deleted after the program is terminated.
-merge/-m If this option is set multiple references are selected, a final polymorphism file will be generated which combines all polymorphism files for all references. 
-gaps/-g If this option is set. The gapThreshold is automatically set to 100%, unless a different gapThreshold is specified.
-config [string] this specifies the location of the config.txt. If not set it is assumed that the config.txt is in the working directory.
-treeOptions [text file] This option allows the user to provide command line parameters to the tree program in the first line of a given text file.
-bowtieOptions [text file] This option allows the user to provide command line parameters to bowtie2 in the first line of a given text file.
-h/-help Shows this help.
-version Prints the program's version.
Program execution took 1.6666666666666667E-5 minutes.
```


## Metadata
- **Skill**: generated

## realphy

### Tool Description
RealPhy is a tool for phylogenetic analysis. It takes a folder of sequence files and outputs a phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/realphy:1.13--hdfd78af_1
- **Homepage**: https://realphy.unibas.ch/fcgi/realphy
- **Package**: https://anaconda.org/channels/bioconda/packages/realphy/overview
- **Validation**: PASS
### Original Help Text
```text
/usr/local/bin
Usage:
java -Xmx[available RAM in MB]m -jar RealPhy_v1.12.jar [Sequence folder] [Output folder] [Options]
Sequence folder needs to contain fasta files ending with .fas, .fna, .fasta or .fa, genbank files ending in .gbk or .gb and short read files in fastq format ending in .fastq or fastq.gz.
The output folder needs to contain a file called "config.txt", which contains information about the location of the required executables such as bowtie2.

Options:
-readLength [integer] default=50 Possible values: Integer greater than 30; Size of fragments that are to be produced from the FASTA/GBK input sequences. With longer read lengths the mapping will take longer but will also map more divergent sequences.
-quality [integer] default=20; Possible values: Integer value between 0 and 41 that corresponds to quality values in fastq files (PHRED+33). Bases with values below thresold in fastq file will not be considered (fasta files will be converted into fastq files with a quality of 20).
-polyThreshold [double] default=0.95; Possible values: Double value between 0 and 1.  Polymorphisms that occur at lower frequency than the specified threshold at any given position of the alignment will not be considered.
-perBaseCov [integer] default=10; Possible values: Integer greater than or equal to 10.  Polymorphisms will only be extracted for regions that are covered by more than the set threshold of reads.
-ref [sequence file name (without extension or path!)] default=random; Possible values: The file name of a sequence data set without the extension (.fas, .fasta, .fa, .fna, .fastq, .fastq.gz, .gb or .gbk). Sets the reference sequence.
-root [sequence file name (without extension or path!)] default=random; Possible values: The file name of a sequence data set without the extension (.fas, .fasta, .fa, .fna, .fastq, .fastq.gz, .gb or .gbk).  Specifies the root of the tree.
-refN [sequence file name (without extension or path!)] where N is the n-th reference genome; default=not set; Possible values: The file name of a sequence data set without the extension (.fas, .fasta, .fa, .fna, .fastq, .fastq.gz, .gb or .gbk).
-genes If set then genes (CDS) are extracted from a given genbank file.
-gapThreshold [double] default=0; specifies the proportion of input sequences that are allowed to contain gaps in the final sequence alignment (i.e. if set to 0.2 at most 20% of all nucleotides in each final alignment column are allowed to be gaps).
-clean/-c If set then the whole analysis will be rerun and existing data will be overwritten!
-treeBuilder [integer] default=4;
   0=Do not build a tree;
   1=treepuzzle; 
   2=raxml
   3=max. parsimony (dnapars)
   4=PhyML (default)
-quiet/-q If set then it suppresses any program output except for errors or warnings.
-varOnly/-v If set then homologous positions that are conserved in all input sequences are put out. If set then the reconstructed tree may be wrong.
-seedLength [integer] default=22 Possible values: Integer between 4 and 32; specifies k-mer length in bowtie2.
-suffix [string] default=not set; appends a suffix to the reference output folder.
-d/-delete If this option is set then all alignment output files and sequence cut files will be deleted after the program is terminated.
-merge/-m If this option is set multiple references are selected, a final polymorphism file will be generated which combines all polymorphism files for all references. 
-gaps/-g If this option is set. The gapThreshold is automatically set to 100%, unless a different gapThreshold is specified.
-config [string] this specifies the location of the config.txt. If not set it is assumed that the config.txt is in the working directory.
-treeOptions [text file] This option allows the user to provide command line parameters to the tree program in the first line of a given text file.
-bowtieOptions [text file] This option allows the user to provide command line parameters to bowtie2 in the first line of a given text file.
-h/-help Shows this help.
-version Prints the program's version.
Program execution took 1.6666666666666667E-5 minutes.
```

