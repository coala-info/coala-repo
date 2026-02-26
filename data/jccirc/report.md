# jccirc CWL Generation Report

## jccirc_JCcirc.pl

### Tool Description
CIRCSeq (circRNA sequence)

### Metadata
- **Docker Image**: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
- **Homepage**: https://github.com/cbbzhang/JCcirc
- **Package**: https://anaconda.org/channels/bioconda/packages/jccirc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jccirc/overview
- **Total Downloads**: 920
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/cbbzhang/JCcirc
- **Stars**: N/A
### Original Help Text
```text
Program:  CIRCSeq (circRNA sequence)
Version:  1.0.0

Usage:    perl cFLSeq.pl -C circ -G genome -F annotation -O circ_contig -P 8 --read1 read_1.fq --read2 read_2.fq --contig contig.fa -D 0

Arguments:

    -C, --circ
          input circRNA file, which including chromosome, start site, end site, host gene, and junction reads ID (required).
    -O, --output
          directory of output (required).
    -G, --genome
          FASTA file of all reference sequences. Please make sure this file is
          the same one provided to prediction tool (required).
    -F, --annotation
          gene annotation file in gtf format. Please make sure this file is
          the same one provided to prediction tool.
    -P, --thread
          set number of threads for parallel running, default is 4.
    --read1
          RNA-Seq data, read_1 (paired end, fastq format).
    --read2
          RNA-Seq data, read_1 (paired end, fastq format).
    --contig
          contig sequences (required).
    --difference
          the difference in support numbers between adjacent fragments when generating circRNA isoforms, default is 0 (recommend setting to 0, 1, or 2, the larger number means stricter).
    -H, --help
          show this help information.
```


## jccirc_CircSimu.pl

### Tool Description
a simulation tool for circRNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
- **Homepage**: https://github.com/cbbzhang/JCcirc
- **Package**: https://anaconda.org/channels/bioconda/packages/jccirc/overview
- **Validation**: PASS

### Original Help Text
```text
This is CIRI_AS_simulator, a simulation tool for circRNAs. Welcome!

Written by Yuan Gao. Any questions please mail to gaoyuan06@mails.ucas.ac.cn.

Arguments (all required):
	-O		prefix of output files
	-G		input gtf formatted annotation file name
	-C		set coverage or max coverage (when choosing -R 2) for circRNAs
	-LC		set coverage or max coverage (when choosing -LR 2) for linear transcripts
	-R		set random mode for circRNAs: 1 for constant coverage; 2 for random coverage
	-LR		set random mode for linear transcripts: 1 for constant coverage; 2 for random coverage
	-L		read length(/bp) of simulated reads (e.g. 100)
	-E		percentage of sequencing error (e.g. 2)
	-D		directory of reference sequence(s) (please make sure all references referred in gtf file are included in the directory)
	-CHR1		if only choose chr1 to simulate sequencing reads: 1 for yes; 0 for no
	-M		average(mu/bp) of insert length (major normal distribution) (e.g. 320)
	-M2		average(mu/bp) of insert length (minor normal distribution) (e.g. 550)
	-PM		percentage of minor normal distribution in total distribution (e.g. 10; 0 for no minor distribution)
	-S		standard deviation(sigma/bp) of insert length (e.g. 70)
	-S2		standard deviation(sigma/bp) of insert length (e.g. 70)
	-SE		whether simulate exon skipping: 1 for yes; 0 for no
	-PSI		percentage of splice in for skipping exon(-SE should be 1)
	-H		show help information
```

