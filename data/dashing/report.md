# dashing CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dashing_cmp | PASS |  |
| dashing_cmp_by_seq | PASS | Works with b-bit minhash sketches (-8); with default HLL sketches the tool crashes (bad_alloc). |
| dashing_fold | PASS |  |
| dashing_hll | PASS |  |
| dashing_printmat | Failed | tool bug: cannot read the binary matrix written by dashing cmp --emit-binary (header size error, exit 139). |
| dashing_sketch | PASS |  |
| dashing_sketch_by_seq | PASS |  |
| dashing_union | PASS |  |
| dashing_view | PASS |  |

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


## dashing_cmp

### Tool Description
Compares sketches by options, including distance, similarity, and containment.

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
Usage: (null) <opts> [genome1 genome2 seq.fq [...] if not provided from a file with -F]
Flags:
-h/-?, --help	Usage


===Encoding Options===

-k, --kmer-length	Set kmer size [31], max 32
-s, --spacing	add a spacer of the format <int>x<int>,<int>x<int>,..., where the first integer corresponds to the space -w, --window-size	Set window size [max(size of spaced kmer, [parameter])]
-S, --sketch-size	Set sketch size [10, for 2**10 bytes each]
--use-nthash	Use nthash for encoding. (not reversible, but fast, rolling, and specialized for DNA). Allows k to be unbounded
--use-cyclic-hash	Uses a cyclic hash for encoding. Not reversible, but efficient. Allows k to be unbounded
-C, --no-canon	Do not canonicalize. [Default: canonicalize]


===Output Files===

-o, --out-sizes	Output for genome size estimates [stdout]
-O, --out-dists	Output for genome distance matrix [stdout]


===Filtering Options===

-y, --countmin	Filter all input data by count-min sketch.
--sketch-by-fname	Autodetect fastq or fasta data by filename (.fq or .fastq within filename).
 When filtering with count-min sketches by either -y or -N, set minimum count:-c, --min-count	Set minimum count for kmers to pass count-min filtering.
-q, --nhashes	Set count-min number of hashes. Default: [1]
-t, --cm-sketch-size	Set count-min sketch size (log2). Default: 20
-R, --seed	Set seed for seeds for count-min sketches


===Runtime Options

-F, --paths	Get paths to genomes from file rather than positional arguments
-W, --cache-sketches	Cache sketches/use cached sketches
-p, --nthreads	Set number of threads [1]
-Q, --query-paths	Sets query paths to use for performing query against reference paths
                 	Particularly for asymmetric distances or panel queries.
                 	For use only with option -F.
By default (if paths are specified only with -F or positional arguments),the emitted distance matrix is upper-triangular.Enabling -Q changes the shape to rectangular (|F| by |Q|).
For asymmetric distances (like containment), you will need to use -Q to generate comparisons in both directions
--nperbatch	During pairwise distance computation, performance can be improved by batching sketch comparisons
           	Raising this number (defaulting to 1) may improve performance by helping cache locality.
           	Default: 16
--presketched	Treat provided paths as pre-made sketches.
-P, --prefix	Set prefix for sketch file locations [empty]
-x, --suffix	Set suffix in sketch file names [empty]
--avoid-sorting	Avoid sorting files by genome sizes. This avoids a computational step, but can result in degraded load-balancing.


===Emission Formats===

-b, --emit-binary	Emit distances in binary (float32) (default: human-readable, upper-triangular)
For default (symmetric) distance computation, this is packed upper-triangular format, like scipy.spatial.distance.squareform.
This file begins with 9 byte header, of which the first is 0 and the next 8 bytes are a 64-bit integer for the number of sets being compared.
This is followed by n-choose-2 4-byte floating point values

In asymmetric distance mode (IE, -Q is enabled), this is rectangular in shape

-U, --phylip	Emit distances in PHYLIP upper triangular format(default: human-readable, upper-triangular)
between bases repeated the second integer number of times
-T, --full-tsv	postprocess binary format to human-readable TSV (not upper triangular) [Square matrix]


===Emission Details===

-e, --emit-scientific	Emit in scientific notation


===Data Structures===

Default: HyperLogLog. Alternatives:
--use-bb-minhash/-8	Create b-bit minhash sketches
--use-bloom-filter	Create bloom filter sketches
--use-range-minhash	Create range minhash sketches
--use-full-khash-sets	Use full khash sets for comparisons, rather than sketches. This can take a lot of memory and time!
Shorter synonyms include --use-hash-sets


===Sketch-specific Options===

-I, --improved      	Use Ertl's Improved Estimator for HLL
-E, --original      	Use Ertl's Original Estimator for HLL
-J, --ertl-joint-mle	Use Ertl's JMLE Estimator for HLL[default:Uses Ertl-MLE]


===b-bit Minhashing Options (apply for b-bit minhash and b-bit superminhash) ===

--bbits,-B	Set `b` for b-bit minwise hashing to <int>. Default: 16. For HyperMinHash, this sets the full register size.


===Distance Emission Types===

Default: Jaccard Index
Alternatives:
-M, --mash-dist    	Emit Mash distance [ji ? (-log(2. * ji / (1. + ji)) / k) : 1.]
--full-mash-dist   	Emit full (not approximate) Mash distance. [1. - (2.*ji/(1. + ji))^(1/k)]
--sizes            	Emit intersection sizes (default: jaccard index)
--containment-index	Emit Containment Index (|A & B| / |A|)
--containment-dist 	Emit distance metric using containment index. [Let C = (|A & B| / |A|). C ? -log(C) / k : 1.] 
--symmetric-containment-dist	Emit symmetric containment index symcon(A, B) = max(C(A, B), C(B, A))
--symmetric-containment-index	tEmit distance metric using maximum containment index. symdist(A, B) = min(cdist(A,B), cdist(B, A))
--full-containment-dist 	Emit distance metric using containment index, without log approximation. [Let C = (|A & B| / |A|). C ? 1. - C^(1/k) : 1.] 


===Streaming Weighted Jaccard===
--wj               	Enable weighted jaccard adapter using the count-min sketch
--wj-cm-sketch-size	Set count-min sketch size for count-min streaming weighted jaccard [16]
--wj-cm-nhashes    	Set count-min sketch number of hashes for count-min streaming weighted jaccard [8]
===Miscellaneous===
--defer-hll        	Maintain k-partition MinHash and produce an HLL at the end. May be faster (fewer instructions) or slower (more memory).
```


## dashing_cmp_by_seq

### Tool Description
Compares sketches made by sketch_by_seq, one per sequence record.

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
Usage: (null) <flags> -n [namefile] input_file
-p	 threads [1]
-o	 output path [/dev/stdout]
-b	 emit binary output
-U	 emit PHYLIP Upper Triangular output
-T	 emit full TSV format
data structures
-8	b-bit minhash
-B	Bloom Filter
-C	Counting Range MinHash
-r	Range MinHash

HLL options
Estimation methods - default MLE
-J	Joint MLE
-E	Original Flajolet
-I	Ertl Improved
Result options

Default: Jaccard Index
--containment-index	 Emit containment index
--containment-dist	 Emit containment distnace
--mash-dist, -M	 Emit mash distance--symmetric-containment-index	Emit symmetric containment index
--symmetric-containment-dist	Emit symmetric containment distance
--sizes	Emit intersection sizes
```


## dashing_fold

### Tool Description
Compresses HLLs from a larger size to smaller sizes.

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
Usage: dashing fold <flags> [in1.hll]
-o: Write to <path> instead of stdout
-p: set destination p [must be smaller than the input sketch
```


## dashing_hll

### Tool Description
Estimates the number of unique k-mers in sequence files with one HyperLogLog.

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
[E:int bns::hll_main(int, char**):9] Usage: hll <opts> <paths>
Flags:
-k:	kmer length (Default: 31. Max: 32)
-w:	window size (Default: -1)  Must be -1 (ignored) or >= kmer length.
-s:	spacing (default: none). format: <value>x<times>,<value>x<times>,...
   	Omitting x<times> indicates 1 occurrence of spacing <value>
-S:	sketch size (default: 24). (Allocates 2 << [param] bytes of memory per HyperLogLog.
-p:	number of threads.
-F:	Path to file which contains one path per line
```


## dashing_printmat

### Tool Description
Displays binary output.

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
printmat printmat <path to binary file> [- to read from stdin]
-o	Specify output file (default: stdout)
-s	Emit in scientific notation
```


## dashing_sketch_by_seq

### Tool Description
Produces k-mer/minimizer sketches from a set of sequences from a sequence file.

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
Usage: sketch_by_seq <opts> [genomes if not provided from a file with -F]
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


## dashing_union

### Tool Description
Performs a union between sets of sketches.

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
Usage: union genome1 <genome2>...
Flags:
-p: Perform compression parallel with [int] threads (0)
-o: Write union sketch to file [/dev/stdout]
-z: Emit compressed sketch
-Z: Set gzip compression level
-r: Bottom-k sketches
-H: Full Khash Sets
-b: Bloom Filters
```


## dashing_view

### Tool Description
Emit register values for HLLs for human readability.

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
[src/dashing.cpp:int bns::view_main(int, char**)560] Usage: dashing view f1.hll [f2.hll ...]. Only HLLs currently supported.
```


## Metadata
- **Skill**: generated
