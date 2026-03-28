# mash CWL Generation Report

## mash_bounds

### Tool Description
Mash distance and Screen distance calculations based on sketch size and distance thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Total Downloads**: 248.6K
- **Last updated**: 2025-08-05
- **GitHub**: https://github.com/marbl/Mash
- **Stars**: N/A
### Original Help Text
```text
Parameters (run with -h for details):
   k:   21
   p:   0.99

	Mash distance
Sketch	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4
100	0.0270708	0.0867606	inf	inf	inf	inf	inf	inf
500	0.00981902	0.0244913	0.0472921	inf	inf	inf	inf	inf
1000	0.00675661	0.0157591	0.0322692	0.0630219	inf	inf	inf	inf
5000	0.00287501	0.00652409	0.0123757	0.0234829	0.0459813	inf	inf	inf
10000	0.00199888	0.00457132	0.00862966	0.0158855	0.0299779	0.0725831	inf	inf
50000	0.000881332	0.00197968	0.0037121	0.00653009	0.0116171	0.0219007	0.0395648	0.0822215
100000	0.000621786	0.00139473	0.00259476	0.00455892	0.00806278	0.014331	0.0250252	0.0492154
500000	0.000276699	0.000619769	0.00114475	0.00200956	0.003457	0.00600661	0.0104601	0.0186527
1000000	0.000195544	0.000437925	0.000807741	0.00141262	0.00241973	0.0041631	0.00724945	0.0127668

	Screen distance
Sketch	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4
100	0.0195634	0.0421104	0.85	0.8	0.75	0.7	0.65	0.6
500	0.00786602	0.0154846	0.0339432	0.8	0.75	0.7	0.65	0.6
1000	0.0054207	0.010758	0.0219894	0.0561633	0.75	0.7	0.65	0.6
5000	0.00233621	0.00462429	0.00861578	0.0162137	0.0379211	0.7	0.65	0.6
10000	0.0016436	0.00321392	0.00598825	0.0109799	0.0240388	0.0550533	0.65	0.6
50000	0.000731087	0.00142413	0.00259063	0.00474589	0.00911086	0.0204149	0.0526353	0.6
100000	0.000515745	0.00100563	0.00181424	0.00332922	0.0063408	0.0127218	0.0325891	0.6
500000	0.000229776	0.000446762	0.000803172	0.00146113	0.0027473	0.00544966	0.0118702	0.0359202
1000000	0.000162418	0.000315619	0.000567196	0.00102652	0.00191631	0.00374762	0.00794327	0.0194016
```


## mash_dist

### Tool Description
Estimate the distance of each query sequence to the reference. Both the reference and queries can be fasta or fastq, gzipped or not, or Mash sketch files (.msh) with matching k-mer sizes. Query files can also be files of file names (see -l). Whole files are compared by default (see -i). The output fields are [reference-ID, query-ID, distance, p-value, shared-hashes].

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash dist [options] <reference> <query> [<query>] ...

Description:

  Estimate the distance of each query sequence to the reference. Both the
  reference and queries can be fasta or fastq, gzipped or not, or Mash sketch
  files (.msh) with matching k-mer sizes. Query files can also be files of file
  names (see -l). Whole files are compared by default (see -i). The output
  fields are [reference-ID, query-ID, distance, p-value, shared-hashes].

Options:

  Option     Description (range) [default]

  -h         Help

  -p <int>   Parallelism. This many threads will be spawned for processing. [1]

...Input...

  -l         List input. Lines in each <query> specify paths to sequence files,
             one per line. The reference file is not affected.

...Output...

  -t         Table output (will not report p-values, but fields will be blank if
             they do not meet the p-value threshold).

  -v <num>   Maximum p-value to report. (0-1) [1.0]

  -d <num>   Maximum distance to report. (0-1) [1.0]

  -C         Show comment fields with reference/query names (denoted with ':').
             (0-1) [1.0]

...Sketching...

  -k <int>   K-mer size. Hashes will be based on strings of this many
             nucleotides. Canonical nucleotides are used by default (see
             Alphabet options below). (1-32) [21]

  -s <int>   Sketch size. Each sketch will have at most this many non-redundant
             min-hashes. [1000]

  -i         Sketch individual sequences, rather than whole files, e.g. for
             multi-fastas of single-chromosome genomes or pair-wise gene
             comparisons.

  -S <int>   Seed to provide to the hash function. (0-4294967296) [42]

  -w <num>   Probability threshold for warning about low k-mer size. (0-1)
             [0.01]

  -r         Input is a read set. See Reads options below. Incompatible with -i.

...Sketching (reads)...

  -b <size>  Use a Bloom filter of this size (raw bytes or with K/M/G/T) to
             filter out unique k-mers. This is useful if exact filtering with -m
             uses too much memory. However, some unique k-mers may pass
             erroneously, and copies cannot be counted beyond 2. Implies -r.

  -m <int>   Minimum copies of each k-mer required to pass noise filter for
             reads. Implies -r. [1]

  -c <num>   Target coverage. Sketching will conclude if this coverage is
             reached before the end of the input file (estimated by average
             k-mer multiplicity). Implies -r.

  -g <size>  Genome size (raw bases or with K/M/G/T). If specified, will be used
             for p-value calculation instead of an estimated size from k-mer
             content. Implies -r.

...Sketching (alphabet)...

  -n         Preserve strand (by default, strand is ignored by using canonical
             DNA k-mers, which are alphabetical minima of forward-reverse
             pairs). Implied if an alphabet is specified with -a or -z.

  -a         Use amino acid alphabet (A-Z, except BJOUXZ). Implies -n, -k 9.

  -z <text>  Alphabet to base hashes on (case ignored by default; see -Z).
             K-mers with other characters will be ignored. Implies -n.

  -Z         Preserve case in k-mers and alphabet (case is ignored by default).
             Sequence letters whose case is not in the current alphabet will be
             skipped when sketching.
```


## mash_info

### Tool Description
Display information about sketch files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash info [options] <sketch>

Description:

  Display information about sketch files.

Options:

  Option  Description (range) [default]

  -h      Help

  -H      Only show header info. Do not list each sketch. Incompatible with -d,
          -t and -c.

  -t      Tabular output (rather than padded), with no header. Incompatible with
          -d, -H and -c.

  -c      Show hash count histograms for each sketch. Incompatible with -d, -H
          and -t.

  -d      Dump sketches in JSON format. Incompatible with -H, -t, and -c.
```


## mash_paste

### Tool Description
Create a single sketch file from multiple sketch files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash paste [options] <out_prefix> <sketch> [<sketch>] ...

Description:

  Create a single sketch file from multiple sketch files.

Options:

  Option  Description (range) [default]

  -h      Help

  -l      Input files are lists of file names.
```


## mash_screen

### Tool Description
Determine how well query sequences are contained within a mixture of sequences. The queries must be formatted as a single Mash sketch file (.msh), created with the `mash sketch` command. The <mixture> files can be contigs or reads, in fasta or fastq, gzipped or not, and "-" can be given for <mixture> to read from standard input. The <mixture> sequences are assumed to be nucleotides, and will be 6-frame translated if the <queries> are amino acids. The output fields are [identity, shared-hashes, median-multiplicity, p-value, query-ID, query-comment], where median-multiplicity is computed for shared hashes, based on the number of observations of those hashes within the mixture.

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash screen [options] <queries>.msh <mixture> [<mixture>] ...

Description:

  Determine how well query sequences are contained within a mixture of
  sequences. The queries must be formatted as a single Mash sketch file (.msh),
  created with the `mash sketch` command. The <mixture> files can be contigs or
  reads, in fasta or fastq, gzipped or not, and "-" can be given for <mixture>
  to read from standard input. The <mixture> sequences are assumed to be
  nucleotides, and will be 6-frame translated if the <queries> are amino acids.
  The output fields are [identity, shared-hashes, median-multiplicity, p-value,
  query-ID, query-comment], where median-multiplicity is computed for shared
  hashes, based on the number of observations of those hashes within the
  mixture.

Options:

  Option    Description (range) [default]

  -h        Help

  -p <int>  Parallelism. This many threads will be spawned for processing. [1]

  -w        Winner-takes-all strategy for identity estimates. After counting
            hashes for each query, hashes that appear in multiple queries will
            be removed from all except the one with the best identity (ties
            broken by larger query), and other identities will be reduced. This
            removes output redundancy, providing a rough compositional outline.

...Output...

  -i <num>  Minimum identity to report. Inclusive unless set to zero, in which
            case only identities greater than zero (i.e. with at least one
            shared hash) will be reported. Set to -1 to output everything.
            (-1-1) [0]

  -v <num>  Maximum p-value to report. (0-1) [1.0]
```


## mash_sketch

### Tool Description
Create a sketch file, which is a reduced representation of a sequence or set of sequences (based on min-hashes) that can be used for fast distance estimations. Inputs can be fasta or fastq files (gzipped or not), and "-" can be given to read from standard input. Input files can also be files of file names (see -l). For output, one sketch file will be generated, but it can have multiple sketches within it, divided by sequences or files (see -i). By default, the output file name will be the first input file with a '.msh' extension, or 'stdin.msh' if standard input is used (see -o).

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash sketch [options] <input> [<input>] ...

Description:

  Create a sketch file, which is a reduced representation of a sequence or set
  of sequences (based on min-hashes) that can be used for fast distance
  estimations. Inputs can be fasta or fastq files (gzipped or not), and "-" can
  be given to read from standard input. Input files can also be files of file
  names (see -l). For output, one sketch file will be generated, but it can have
  multiple sketches within it, divided by sequences or files (see -i). By
  default, the output file name will be the first input file with a '.msh'
  extension, or 'stdin.msh' if standard input is used (see -o).

Options:

  Option     Description (range) [default]

  -h         Help

  -p <int>   Parallelism. This many threads will be spawned for processing. [1]

...Input...

  -l         List input. Lines in each <input> specify paths to sequence files,
             one per line.

...Output...

  -o <path>  Output prefix (first input file used if unspecified). The suffix
             '.msh' will be appended.

...Sketching...

  -I <path>  ID field for sketch of reads (instead of first sequence ID).

  -C <path>  Comment for a sketch of reads (instead of first sequence comment).

  -k <int>   K-mer size. Hashes will be based on strings of this many
             nucleotides. Canonical nucleotides are used by default (see
             Alphabet options below). (1-32) [21]

  -s <int>   Sketch size. Each sketch will have at most this many non-redundant
             min-hashes. [1000]

  -i         Sketch individual sequences, rather than whole files, e.g. for
             multi-fastas of single-chromosome genomes or pair-wise gene
             comparisons.

  -S <int>   Seed to provide to the hash function. (0-4294967296) [42]

  -w <num>   Probability threshold for warning about low k-mer size. (0-1)
             [0.01]

  -r         Input is a read set. See Reads options below. Incompatible with -i.

...Sketching (reads)...

  -b <size>  Use a Bloom filter of this size (raw bytes or with K/M/G/T) to
             filter out unique k-mers. This is useful if exact filtering with -m
             uses too much memory. However, some unique k-mers may pass
             erroneously, and copies cannot be counted beyond 2. Implies -r.

  -m <int>   Minimum copies of each k-mer required to pass noise filter for
             reads. Implies -r. [1]

  -c <num>   Target coverage. Sketching will conclude if this coverage is
             reached before the end of the input file (estimated by average
             k-mer multiplicity). Implies -r.

  -g <size>  Genome size (raw bases or with K/M/G/T). If specified, will be used
             for p-value calculation instead of an estimated size from k-mer
             content. Implies -r.

...Sketching (alphabet)...

  -n         Preserve strand (by default, strand is ignored by using canonical
             DNA k-mers, which are alphabetical minima of forward-reverse
             pairs). Implied if an alphabet is specified with -a or -z.

  -a         Use amino acid alphabet (A-Z, except BJOUXZ). Implies -n, -k 9.

  -z <text>  Alphabet to base hashes on (case ignored by default; see -Z).
             K-mers with other characters will be ignored. Implies -n.

  -Z         Preserve case in k-mers and alphabet (case is ignored by default).
             Sequence letters whose case is not in the current alphabet will be
             skipped when sketching.
```


## mash_taxscreen

### Tool Description
Create Kraken-style taxonomic report based on how well query sequences are contained within a pool of sequences. The queries must be formatted as a single Mash sketch file (.msh), created with the `mash sketch` command. The <pool> files can be contigs or reads, in fasta or fastq, gzipped or not, and "-" can be given for <pool> to read from standard input. The <pool> sequences are assumed to be nucleotides, and will be 6-frame translated if the <queries> are amino acids. The output fields are [total percent of hashes, number of contained hashes in the clade, number of contained hashes in the taxon, total number of hashes in the clade, total number of hashes in the taxon, rank, taxonomy ID, padded name].

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash taxscreen [options] <queries>.msh <pool> [<pool>] ...

Description:

  Create Kraken-style taxonomic report based on how well query sequences are
  contained within a pool of sequences. The queries must be formatted as a
  single Mash sketch file (.msh), created with the `mash sketch` command. The
  <pool> files can be contigs or reads, in fasta or fastq, gzipped or not, and
  "-" can be given for <pool> to read from standard input. The <pool> sequences
  are assumed to be nucleotides, and will be 6-frame translated if the <queries>
  are amino acids. The output fields are [total percent of hashes, number of
  contained hashes in the clade, number of contained hashes in the taxon, total
  number of hashes in the clade, total number of hashes in the taxon, rank,
  taxonomy ID, padded name].

Options:

  Option     Description (range) [default]

  -h         Help

  -p <int>   Parallelism. This many threads will be spawned for processing. [1]

  -m <text>  Mapping file from reference name to taxonomy ID

  -t <text>  Directory containing NCBI taxonomy dump [.]

...Output...

  -i <num>   Minimum identity to report. Inclusive unless set to zero, in which
             case only identities greater than zero (i.e. with at least one
             shared hash) will be reported. Set to -1 to output everything.
             (-1-1) [0]

  -v <num>   Maximum p-value to report. (0-1) [1.0]
```


## mash_triangle

### Tool Description
Estimate the distance of each input sequence to every other input sequence. Outputs a lower-triangular distance matrix in relaxed Phylip format. The input sequences can be fasta or fastq, gzipped or not, or Mash sketch files (.msh) with matching k-mer sizes. Input files can also be files of file names (see -l). If more than one input file is provided, whole files are compared by default (see -i).

### Metadata
- **Docker Image**: quay.io/biocontainers/mash:2.3--hb105d93_10
- **Homepage**: https://github.com/marbl/Mash
- **Package**: https://anaconda.org/channels/bioconda/packages/mash/overview
- **Validation**: PASS

### Original Help Text
```text
Version: 2.3

Usage:

  mash triangle [options] <seq1> [<seq2>] ...

Description:

  Estimate the distance of each input sequence to every other input sequence.
  Outputs a lower-triangular distance matrix in relaxed Phylip format. The input
  sequences can be fasta or fastq, gzipped or not, or Mash sketch files (.msh)
  with matching k-mer sizes. Input files can also be files of file names (see
  -l). If more than one input file is provided, whole files are compared by
  default (see -i).

Options:

  Option     Description (range) [default]

  -h         Help

  -p <int>   Parallelism. This many threads will be spawned for processing. [1]

...Input...

  -l         List input. Lines in each <query> specify paths to sequence files,
             one per line. The reference file is not affected.

...Output...

  -C         Use comment fields for sequence names instead of IDs.

  -E         Output edge list instead of Phylip matrix, with fields [seq1, seq2,
             dist, p-val, shared-hashes].

  -v <num>   Maximum p-value to report in edge list. Implies -E. (0-1) [1.0]

  -d <num>   Maximum distance to report in edge list. Implies -E. (0-1) [1.0]

...Sketching...

  -k <int>   K-mer size. Hashes will be based on strings of this many
             nucleotides. Canonical nucleotides are used by default (see
             Alphabet options below). (1-32) [21]

  -s <int>   Sketch size. Each sketch will have at most this many non-redundant
             min-hashes. [1000]

  -i         Sketch individual sequences, rather than whole files, e.g. for
             multi-fastas of single-chromosome genomes or pair-wise gene
             comparisons.

  -S <int>   Seed to provide to the hash function. (0-4294967296) [42]

  -w <num>   Probability threshold for warning about low k-mer size. (0-1)
             [0.01]

  -r         Input is a read set. See Reads options below. Incompatible with -i.

...Sketching (reads)...

  -b <size>  Use a Bloom filter of this size (raw bytes or with K/M/G/T) to
             filter out unique k-mers. This is useful if exact filtering with -m
             uses too much memory. However, some unique k-mers may pass
             erroneously, and copies cannot be counted beyond 2. Implies -r.

  -m <int>   Minimum copies of each k-mer required to pass noise filter for
             reads. Implies -r. [1]

  -c <num>   Target coverage. Sketching will conclude if this coverage is
             reached before the end of the input file (estimated by average
             k-mer multiplicity). Implies -r.

  -g <size>  Genome size (raw bases or with K/M/G/T). If specified, will be used
             for p-value calculation instead of an estimated size from k-mer
             content. Implies -r.

...Sketching (alphabet)...

  -n         Preserve strand (by default, strand is ignored by using canonical
             DNA k-mers, which are alphabetical minima of forward-reverse
             pairs). Implied if an alphabet is specified with -a or -z.

  -a         Use amino acid alphabet (A-Z, except BJOUXZ). Implies -n, -k 9.

  -z <text>  Alphabet to base hashes on (case ignored by default; see -Z).
             K-mers with other characters will be ignored. Implies -n.

  -Z         Preserve case in k-mers and alphabet (case is ignored by default).
             Sequence letters whose case is not in the current alphabet will be
             skipped when sketching.
```


## Metadata
- **Skill**: generated
