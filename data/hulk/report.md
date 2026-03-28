# hulk CWL Generation Report

## hulk_sketch

### Tool Description
Create a sketch from a set of reads. The sketch subcommand can be used to create a histosketch, minhash or count min sketch.

### Metadata
- **Docker Image**: quay.io/biocontainers/hulk:1.0.0--h375a9b1_0
- **Homepage**: https://github.com/will-rowe/hulk
- **Package**: https://anaconda.org/channels/bioconda/packages/hulk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hulk/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/will-rowe/hulk
- **Stars**: N/A
### Original Help Text
```text
Create a sketch from a set of reads.
		
		The sketch subcommand can be used to create a histosketch, minhash or count min sketch.

Usage:
  hulk sketch [flags]

Flags:
  -f, --fastq strings        FASTQ file(s) to sketch (can also pipe in STDIN)
      --fasta                tells HULK that the input file is actually FASTA format (.fna/.fasta/.fa), not FASTQ (experimental feature)
  -w, --windowSize uint      minimizer window size (default 9)
  -i, --interval uint        size of k-mer sampling interval (default 0 (= no interval))
  -s, --sketchSize uint      size of sketch (default 50)
  -x, --decayRatio float     decay ratio used for concept drift (1.0 = concept drift disabled) (default 1)
      --stream               prints the sketches to STDOUT after every interval is reached, whilst still writting them to disk (log file is redirected to disk))
  -b, --bannerLabel string   adds a label to the sketch object, for use with BANNER (default "blank")
      --khf                  also generate a MinHash K-Hash Functions sketch
      --kmv                  also generate a MinHash K-Minimum Values (bottom-k) sketch
  -h, --help                 help for sketch

Global Flags:
  -k, --kmerSize uint    minimizer k-mer length (default 21)
      --log string       filename for log file, if omitted then STDOUT used by default
  -o, --outFile string   directory and basename for saving the outfile(s) (default "./hulk-20260224171520")
  -p, --processors int   number of processors to use (default 1)
      --profiling        create the files needed to profile HULK using the go tool pprof
```


## hulk_smash

### Tool Description
Smash a bunch of sketches and return a distance matrix. This subcommand performs pairwise comparisons of sketches and then writes a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/hulk:1.0.0--h375a9b1_0
- **Homepage**: https://github.com/will-rowe/hulk
- **Package**: https://anaconda.org/channels/bioconda/packages/hulk/overview
- **Validation**: PASS

### Original Help Text
```text
Smash a bunch of sketches and return a distance matrix.

		This subcommand performs pairwise comparisons of sketches and then writes a distance matrix.

Usage:
  hulk smash [flags]

Flags:
  -a, --algorithm string   tells HULK which sketching algorithm to use [histosketch kmv khf] (default "histosketch")
      --bannerMatrix       write a matrix file for banner
  -h, --help               help for smash
  -m, --metric string      tells HULK which distance metric to use [jaccard weightedjaccard] (default "jaccard")
      --recursive          recursively search the supplied sketch directory (-d)
  -d, --sketchDir string   the directory containing the sketches to smash (compare)... (default "./")

Global Flags:
  -k, --kmerSize uint    minimizer k-mer length (default 21)
      --log string       filename for log file, if omitted then STDOUT used by default
  -o, --outFile string   directory and basename for saving the outfile(s) (default "./hulk-20260224171627")
  -p, --processors int   number of processors to use (default 1)
      --profiling        create the files needed to profile HULK using the go tool pprof
```


## Metadata
- **Skill**: generated
