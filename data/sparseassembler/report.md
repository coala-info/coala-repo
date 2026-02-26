# sparseassembler CWL Generation Report

## sparseassembler_SparseAssembler

### Tool Description
SparseAssembler

### Metadata
- **Docker Image**: quay.io/biocontainers/sparseassembler:20160205--h9948957_11
- **Homepage**: https://github.com/yechengxi/SparseAssembler
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sparseassembler/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-08-21
- **GitHub**: https://github.com/yechengxi/SparseAssembler
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

