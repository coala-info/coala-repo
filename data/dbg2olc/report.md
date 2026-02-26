# dbg2olc CWL Generation Report

## dbg2olc_SparseAssembler

### Tool Description
Sparse assembler for long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
- **Homepage**: https://github.com/yechengxi/DBG2OLC
- **Package**: https://anaconda.org/channels/bioconda/packages/dbg2olc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbg2olc/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-08-21
- **GitHub**: https://github.com/yechengxi/DBG2OLC
- **Stars**: N/A
### Original Help Text
```text
Command: 
Programfile g GAP_VALUE k KMER_SIZE LD LOAD_SKG GS GENOME_SIZE TrimN TRIM_READS_WITH_N f INPUT_FILE1 f INPUT_FILE2 i1 INWARD_PAIR_END1 i2 INWARD_PAIR_END2 o1 OUTWARD_PAIR_END1 o2 OUTWARD_PAIR_END2

Parameters:
k: kmer size, support 15~127.
g: number of skipped intermediate k-mers, support 1-25.
f: single end reads. Multiple inputs shall be independently imported with this parameter.
i1 & i2 (or p1 & p2): inward paired-end reads.
o1 & o2 (or l1 & l2): outward paired-end reads.
GS: genome size estimation in bp (used for memory pre-allocation), suggest a large value if possible.(e.g. ~ 2x genome size)
LD: load a saved k-mer graph. 
BC: 1: build contigs.0: don't build.
KmerTable: 1 if you want to output the kmer table.
NodeCovTh: coverage threshold for spurious k-mers, support 0-16. (default 1)
EdgeCovTh: coverage threshold for spurious links, support 0-16. (default 0)
PathCovTh: coverage threshold for spurious paths in the breadth-first search, support 0-100.
TrimLen: trim long sequences to this length.
TrimN: throw away reads with more than this number of Ns.
TrimQual: trim off tails with quality scores lower than this.
QualBase: lowest quality score value (in ASCII value) in the current fastq scoring system, default: '!'.

For error correction:
Denoise: use 1 to call the error correction module. (default 0)
H: hybrid mode. 0 (Default): reads will be trimmed at the ends to ensure denoising accuracy (*MUST* set 0 for the last round). 1: reads will not be trimmed at the ends; 
CovTh: coverage threshold for an error. A k-mer with coverage < this value will be checked. Setting 0 will allow the program to choose a value based on the coverage histogram.
CorrTh: coverage threshold for a correct k-mer candidate. A k-mer with coverage >= this value will be considered a candidate for correction. Setting 0 will allow the program to choose a value based on the coverage histogram.

For scaffolding:
ExpCov: expected average k-mer coverage in a unique contig. Used for scaffolding.
Scaffold: 1: scaffolding with paired reads. 0: single end assembly.
LinkCovTh: coverage threshold for spurious paired-end links, support 0-100. (default 5)
Iter_Scaffold: 1: iterative scaffolding using the already built scaffolds (/super contigs). 0: one round scaffolding.
For mate pair scaffolding:
InsertSize: estimated insert size of the current pair.
i1_mp & i2_mp: inward mate paired reads (large insert sizes >10k, for shorter libraries omit "_mp").
o1_mp & o2_mp : outward paired-end reads (large insert sizes >10k, for shorter libraries omit "_mp").

Error! Genome size not given.
```


## dbg2olc_DBG2OLC

### Tool Description
DBG2OLC is a tool for correcting long reads using a de Bruijn graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
- **Homepage**: https://github.com/yechengxi/DBG2OLC
- **Package**: https://anaconda.org/channels/bioconda/packages/dbg2olc/overview
- **Validation**: PASS

### Original Help Text
```text
Example command: 
For third-gen sequencing: DBG2OLC LD1 0 Contigs contig.fa k 17 KmerCovTh 2 MinOverlap 20 AdaptiveTh 0.005 f reads_file1.fq/fa f reads_file2.fq/fa
For sec-gen sequencing: DBG2OLC LD1 0 Contigs contig.fa k 31 KmerCovTh 0 MinOverlap 50 PathCovTh 1 f reads_file1.fq/fa f reads_file2.fq/fa
Parameters:
MinLen: min read length for a read to be used.
Contigs:  contig file to be used.
k: k-mer size.
LD: load compressed reads information. You can set to 1 if you have run the algorithm for one round and just want to fine tune the following parameters.
PARAMETERS THAT ARE CRITICAL FOR THE PERFORMANCE:
If you have high coverage, set large values to these parameters.
KmerCovTh: k-mer matching threshold for each solid contig. (suggest 2-10)
MinOverlap: min matching k-mers for each two reads. (suggest 10-150)
AdaptiveTh: [Specific for third-gen sequencing] adaptive k-mer threshold for each solid contig. (suggest 0.001-0.02)
PathCovTh: [Specific for Illumina sequencing] occurence threshold for a compressed read. (suggest 1-3)
Author: Chengxi Ye cxy@umd.edu.
last update: Jun 11, 2015.
Loading contigs.
0 k-mers in round 1.
0 k-mers in round 2.
Scoring method: 3
Match method: 1
Loading long read index
0 selected reads.
0 reads loaded.
```


## dbg2olc_Sparc

### Tool Description
dbg2olc_Sparc tool for generating consensus sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
- **Homepage**: https://github.com/yechengxi/DBG2OLC
- **Package**: https://anaconda.org/channels/bioconda/packages/dbg2olc/overview
- **Validation**: PASS

### Original Help Text
```text
For help: Sparc -h
 Example command: 
Sparc b BackboneFile.fa m Mapped.m5 c 2 k 2 g 2 o ConsensusOutput
Parameters:
b: backbone file.
m: the reads mapping files produced by blasr, using option -m 5.
k: k-mer size. (range: [1,5])
c: coverage threshold. (range: [1,5])
g: skip size, the larger the value, the more memory efficient the algorithm is. (range: [1,5])
HQ_Prefix: Shared prefix of the high quality read names.
boost: boosting weight for the high quality reads. (range: [1,5])
Author: Chengxi Ye cxy@umd.edu.
last update: Jan 2, 2015.
```


## dbg2olc_SelectLongestReads

### Tool Description
Selects the longest reads from a FASTA/FASTQ file based on total length.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
- **Homepage**: https://github.com/yechengxi/DBG2OLC
- **Package**: https://anaconda.org/channels/bioconda/packages/dbg2olc/overview
- **Validation**: PASS

### Original Help Text
```text
Command:  ProgramFile sum total_length longest 0 o outfile f fa/fq_file f fa/fq_file 
Total bases: 0
```

