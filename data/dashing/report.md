# dashing CWL Generation Report

## dashing_sketch

### Tool Description
Sketching genomes with sketch: 0/HLL/HyperLogLog

### Metadata
- **Docker Image**: quay.io/biocontainers/dashing:1.0--h5b0a936_3
- **Homepage**: https://github.com/dnbaker/dashing
- **Package**: https://anaconda.org/channels/bioconda/packages/dashing/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dashing/overview
- **Total Downloads**: 31.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dnbaker/dashing
- **Stars**: N/A
### Original Help Text
```text
Dashing version: v1.0
Using 1 threads
[int bns::sketch_main(int, char**)] Sketching genomes with sketch: 0/HLL/HyperLogLog
No paths. See usage.
Usage: sketch <opts> [genomes if not provided from a file with -F]
Flags:
-h/-?:	Emit usage


Sketch options --

--kmer-length/-k	Set kmer size [31], max 32
--spacing/-s	add a spacer of the format <int>x<int>,<int>x<int>,..., where the first integer corresponds to the space between bases repeated the second integer number of times
--window-size/-w	Set window size [max(size of spaced kmer, [parameter])]
--sketch-size/-S	Set log2 sketch size in bytes [10, for 2**10 bytes each]
--no-canon/-C	Do not canonicalize. [Default: canonicalize]
--bbits/-B	Set `b` for b-bit minwise hashing to <int>. Default: 16


Run options --

--nthreads/-p	Set number of threads [1]
--prefix/-P	Set prefix for sketch file locations [empty]
--suffix/-x	Set suffix in sketch file names [empty]
--paths/-F	Get paths to genomes from file rather than positional arguments
--skip-cached/-c	Skip alreday produced/cached sketches (save sketches to disk in directory of the file [default] or in folder specified by -P
--avoid-sorting	Avoid sorting files by genome sizes. This avoids a computational step, but can result in degraded load-balancing.




Estimation methods --

--original/-E	Use Flajolet with inclusion/exclusion quantitation method for hll. [Default: Ertl MLE]
--improved/-I	Use Ertl Improved estimator [Default: Ertl MLE]
--ertl-jmle/-J	Use Ertl JMLE


Filtering Options --

Default: consume all kmers. Alternate options: 
--sketch-by-fname	Autodetect fastq or fasta data by filename (.fq or .fastq within filename).
--countmin/-b	Filter all input data by count-min sketch.


Options for count-min filtering --

--nhashes/-H	Set count-min number of hashes. Default: [1]
--cm-sketch-size/-q	Set count-min sketch size (log2). Default: 20
--min-count/-n	Provide minimum expected count for fastq data. If unspecified, all kmers are passed.
--seed/-R	Set seed for seeds for count-min sketches


Sketch Type Options --

--use-bb-minhash/-8	Create b-bit minhash sketches
--use-bloom-filter	Create bloom filter sketches
--use-range-minhash	Create range minhash sketches
--use-full-khash-sets	Use full khash sets for comparisons, rather than sketches. This can take a lot of memory and time!
--use-hash-sets and --use-full-hash-sets are slightly shorter aliases for the same option.


===Streaming Weighted Jaccard===
--wj               	Enable weighted jaccard adapter using the count-min sketch
--wj-cm-sketch-size	Set count-min sketch size for count-min streaming weighted jaccard [16]
--wj-cm-nhashes    	Set count-min sketch number of hashes for count-min streaming weighted jaccard [8]
--wj-exact         	Enable exact weighted jaccard using a hash map
===Miscellaneous===
--defer-hll        	Maintain k-partition MinHash and produce an HLL at the end. May be faster (fewer instructions) or slower (more memory).
```


## dashing_Produces

### Tool Description
Dashing version: v1.0

### Metadata
- **Docker Image**: quay.io/biocontainers/dashing:1.0--h5b0a936_3
- **Homepage**: https://github.com/dnbaker/dashing
- **Package**: https://anaconda.org/channels/bioconda/packages/dashing/overview
- **Validation**: PASS

### Original Help Text
```text
Dashing version: v1.0
Usage: dashing <subcommand> [options...]. Use dashing <subcommand> for more options.
Subcommands:
  sketch
    Produces k-mer/minimizer sketches from genomes.
To sketch by sequence record rather than by file, see sketch_by_seq.
  sketch_by_seq
     Produces k-mer/minimizer sketches from a set of sequences from a sequence file. See cmp_by_seq for comparable distance calculation.
  cmp
       Compares sketches by options, including distance, similarity, and containment. cmp_by_seq sketches by sequence rather than by file.
  union
       Performs a union between sets of sketches
  view
       Emit register values for HLLs for human readability
  printmat
       Displays binary output
 fold
        Compresses HLLs from a larger size to smaller sizes.
dist is also now a synonym for cmp, but this may be removed.
[src/main.cpp:int main(int, char**)70] Invalid subcommand Produces provided.
```

