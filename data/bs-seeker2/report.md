# bs-seeker2 CWL Generation Report

## bs-seeker2_bs_seeker2-build.py

### Tool Description
Build index for BS-Seeker2

### Metadata
- **Docker Image**: quay.io/biocontainers/bs-seeker2:2.1.7--0
- **Homepage**: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/
- **Package**: https://anaconda.org/channels/bioconda/packages/bs-seeker2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bs-seeker2/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: bs_seeker2-build.py [options]

Options:
  -h, --help            show this help message and exit
  -f FILE, --file=FILE  Input your reference genome file (fasta)
  --aligner=ALIGNER     Aligner program to perform the analysis: bowtie,
                        bowtie2, soap, rmap [Default: bowtie]
  -p PATH, --path=PATH  Path to the aligner program. Detected:
                        bowtie: None
                        bowtie2: /usr/local/bin
                        rmap: None
                        soap: None
  -d DBPATH, --db=DBPATH
                        Path to the reference genome library (generated in
                        preprocessing genome) [Default:
                        /usr/local/bin/bs_utils/reference_genomes]
  -v, --version         show version of BS-Seeker2

  Reduced Representation Bisulfite Sequencing Options:
    Use this options with conjuction of -r [--rrbs]

    -r, --rrbs          Build index specially for Reduced Representation
                        Bisulfite Sequencing experiments. Genome other than
                        certain fragments will be masked. [Default: False]
    -l LOW_BOUND, --low=LOW_BOUND
                        lower bound of fragment length (excluding recognition
                        sequence such as C-CGG) [Default: 20]
    -u UP_BOUND, --up=UP_BOUND
                        upper bound of fragment length (excluding recognition
                        sequence such as C-CGG ends) [Default: 500]
    -c CUT_FORMAT, --cut-site=CUT_FORMAT
                        Cut sites of restriction enzyme. Ex: MspI(C-CGG),
                        Mael:(C-TAG), double-enzyme MspI&Mael:(C-CGG,C-TAG).
                        [Default: C-CGG]
```


## bs-seeker2_bs_seeker2-align.py

### Tool Description
Aligns reads to a reference genome for bisulfite sequencing analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/bs-seeker2:2.1.7--0
- **Homepage**: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/
- **Package**: https://anaconda.org/channels/bioconda/packages/bs-seeker2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bs_seeker2-align.py {-i <single> | -1 <mate1> -2 <mate2>} -g <genome.fa> [options]

Options:
  -h, --help            show this help message and exit

  For single end reads:
    -i INFILE, --input=INFILE
                        Input read file (FORMAT: sequences, qseq, fasta,
                        fastq). Ex: read.fa or read.fa.gz

  For pair end reads:
    -1 FILE, --input_1=FILE
                        Input read file, mate 1 (FORMAT: sequences, qseq,
                        fasta, fastq)
    -2 FILE, --input_2=FILE
                        Input read file, mate 2 (FORMAT: sequences, qseq,
                        fasta, fastq)
    -I MIN_INSERT_SIZE, --minins=MIN_INSERT_SIZE
                        The minimum insert size for valid paired-end
                        alignments [Default: 0]
    -X MAX_INSERT_SIZE, --maxins=MAX_INSERT_SIZE
                        The maximum insert size for valid paired-end
                        alignments [Default: 500]

  Reduced Representation Bisulfite Sequencing Options:
    -r, --rrbs          Map reads to the Reduced Representation genome
    -c pattern, --cut-site=pattern
                        Cutting sites of restriction enzyme. Ex: MspI(C-CGG),
                        Mael:(C-TAG), double-enzyme MspI&Mael:(C-CGG,C-TAG).
                        [Default: C-CGG]
    -L RRBS_LOW_BOUND, --low=RRBS_LOW_BOUND
                        Lower bound of fragment length (excluding C-CGG ends)
                        [Default: 20]
    -U RRBS_UP_BOUND, --up=RRBS_UP_BOUND
                        Upper bound of fragment length (excluding C-CGG ends)
                        [Default: 500]

  General options:
    -t TAG, --tag=TAG   [Y]es for undirectional lib, [N]o for directional
                        [Default: N]
    -s CUTNUMBER1, --start_base=CUTNUMBER1
                        The first cycle of the read to be mapped [Default: 1]
    -e CUTNUMBER2, --end_base=CUTNUMBER2
                        The last cycle of the read to be mapped [Default: 200]
    -a FILE, --adapter=FILE
                        Input text file of your adaptor sequences (to be
                        trimmed from the 3'end of the reads, ). Input one seq
                        for dir. lib., twon seqs for undir. lib. One line per
                        sequence. Only the first 10bp will be used
    --am=ADAPTER_MISMATCH
                        Number of mismatches allowed in adapter [Default: 0]
    -g GENOME, --genome=GENOME
                        Name of the reference genome (should be the same as
                        "-f" in bs_seeker2-build.py ) [ex. chr21_hg18.fa]
    -m NO_MISMATCHES, --mismatches=NO_MISMATCHES
                        Number(>=1)/Percentage([0, 1)) of mismatches in one
                        read. Ex: 4 (allow 4 mismatches) or 0.04 (allow 4%
                        mismatches) [Default: 4]
    --aligner=ALIGNER   Aligner program for short reads mapping: bowtie,
                        bowtie2, soap, rmap [Default: bowtie]
    -p PATH, --path=PATH
                        Path to the aligner program. Detected:
                        bowtie: None
                        bowtie2: /usr/local/bin
                        rmap: None
                        soap: None
    -d DBPATH, --db=DBPATH
                        Path to the reference genome library (generated in
                        preprocessing genome) [Default:
                        /usr/local/bin/bs_utils/reference_genomes]
    -l INT, --split_line=INT
                        Number of lines per split (the read file will be split
                        into small files for mapping. The result will be
                        merged. [Default: 4000000]
    -o OUTFILE, --output=OUTFILE
                        The name of output file [INFILE.bs(se|pe|rrbs)]
    -f FORMAT, --output-format=FORMAT
                        Output format: bam, sam, bs_seeker1 [Default: bam]
    --no-header         Suppress SAM header lines [Default: False]
    --temp_dir=PATH     The path to your temporary directory [Detected: /tmp]
    --XS=XS_FILTER      Filter definition for tag XS, format X,Y. X=0.8 and
                        y=5 indicate that for one read, if #(mCH sites)/#(all
                        CH sites)>0.8 and #(mCH sites)>5, then tag XS:i:1; or
                        else tag XS:i:0. [Default: 0.5,5]
    --XSteve            Filter definition for tag XS, proposed by Prof. Steve
                        Jacobsen, reads with at least 3 successive mCHH will
                        be labeled as XS:i:1,useful for plant genome, which
                        have high mCHG level. Will override --XS option.
    -M FileName, --multiple-hit=FileName
                        File to store reads with multiple-hits
    -u FileName, --unmapped=FileName
                        File to store unmapped reads
    -v, --version       show version of BS-Seeker2

  Aligner Options:
    You may specify any additional options for the aligner. You just have
    to prefix them with --bt- for bowtie, --bt2- for bowtie2, --soap- for
    soap, --rmap- for rmap, and BS-Seeker2 will pass them on. For example:
    --bt-p 4 will increase the number of threads for bowtie to 4, --bt--
    tryhard will instruct bowtie to try as hard as possible to find valid
    alignments when they exist, and so on.
```


## bs-seeker2_bs_seeker2-call_methylation.py

### Tool Description
Call methylation status from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bs-seeker2:2.1.7--0
- **Homepage**: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/
- **Package**: https://anaconda.org/channels/bioconda/packages/bs-seeker2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bs_seeker2-call_methylation.py [options]

Options:
  -h, --help            show this help message and exit
  -i INFILE, --input=INFILE
                        BAM output from bs_seeker2-align.py
  -d DBPATH, --db=DBPATH
                        Path to the reference genome library (generated in
                        preprocessing genome) [Default:
                        /usr/local/bin/bs_utils/reference_genomes]
  -o OUTFILE, --output-prefix=OUTFILE
                        The output prefix to create ATCGmap and wiggle files.
                        Three files (ATCGmap, CGmap, wig) will be generated if
                        specified. Omit this if only to generate specific
                        format.
  --sorted              Specify when the input bam file is already sorted, the
                        sorting step will be skipped [Default: False]
  --wig=OUTFILE         Filename for wig file. Ex: output.wig, or
                        output.wig.gz. Can be overwritten by "-o".
  --CGmap=OUTFILE       Filename for CGmap file. Ex: output.CGmap, or
                        output.CGmap.gz. Can be overwritten by "-o".
  --ATCGmap=OUTFILE     Filename for ATCGmap file. Ex: output.ATCGmap, or
                        output.ATCGmap.gz. Can be overwritten by "-o".
  -x, --rm-SX           Removed reads with tag 'XS:i:1', which would be
                        considered as not fully converted by bisulfite
                        treatment [Default: False]
  --rm-CCGG             Removed sites located in CCGG, avoiding the bias
                        introduced by artificial DNA methylation status
                        'XS:i:1', which would be considered as not fully
                        converted by bisulfite treatment [Default: False]
  --rm-overlap          Removed one mate if two mates are overlapped, for
                        paired-end data [Default: False]
  --txt                 When specified, output file will be stored in plain
                        text instead of compressed version (.gz)
  -r READ_NO, --read-no=READ_NO
                        The least number of reads covering one site to be
                        shown in wig file [Default: 1]
  -D PILEUPMAXDEPTH, --pileup-maxdepth=PILEUPMAXDEPTH
                        The max number of read depth can be called for each
                        position. Parameter passing to pysam. Large number
                        costs more time.[Default: 8000]
  -v, --version         show version of BS-Seeker2
```


## Metadata
- **Skill**: not generated
