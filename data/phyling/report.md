# phyling CWL Generation Report

## phyling_download

### Tool Description
Help to download/update BUSCO v5 markerset to a local folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/stajichlab/Phyling
- **Package**: https://anaconda.org/channels/bioconda/packages/phyling/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyling/overview
- **Total Downloads**: 216
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/stajichlab/Phyling
- **Stars**: N/A
### Original Help Text
```text
usage: phyling download [-v] [-h] HMM markerset or "list"

Help to download/update BUSCO v5 markerset to a local folder.

First it checks whether the metadata file is exist under the config folder
~/.phyling. A missing or outdated file will trigger the module to
download/update the metadata.

Passing "list" to markerset argument will list all the available/already
downloaded markersets. Passing a valid name to the markerset argument will
download the markerset to the config folder ~/.phyling/HMM.

positional arguments:
  HMM markerset or "list"
                        Name of the HMM markerset

Options:
  -v, --verbose         Verbose mode for debug
  -h, --help            show this help message and exit
```


## phyling_align

### Tool Description
Perform multiple sequence alignment (MSA) on orthologous sequences that match the hmm markers across samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/stajichlab/Phyling
- **Package**: https://anaconda.org/channels/bioconda/packages/phyling/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyling align (-i file [files ...] | -I directory) -m directory
                     [-o directory] [--seqtype {dna,pep,AUTO}] [-E float]
                     [-M {hmmalign,muscle}] [--non_trim] [-t THREADS] [-v]
                     [-h]

Perform multiple sequence alignment (MSA) on orthologous sequences that match
the hmm markers across samples.

Initially, hmmsearch is used to match the samples against a given markerset
and report the top hit of each sample for each hmm marker, representing
"orthologs" across all samples. In order to build a tree, minimum of 4 samples
should be used. If the bitscore cutoff file is present in the hmms folder, it
will be used as the cutoff. Otherwise, an evalue of 1e-10 will be used as the
default cutoff.

Sequences corresponding to orthologs found in more than 4 samples are
extracted from each input. These sequences then undergo MSA with hmmalign or
muscle. The resulting alignments are further trimmed using clipkit by default.
You can use the --non_trim option to skip the trimming step. Finally, The
alignment results are output separately for each hmm marker.

Required arguments:
  -i, --inputs file [files ...]
                        Query pepetide/cds fasta or gzipped fasta
  -I, --input_dir directory
                        Directory containing query pepetide/cds fasta or
                        gzipped fasta
  -m, --markerset directory
                        Directory of the HMM markerset

Options:
  -o, --output directory
                        Output directory of the alignment results (default:
                        phyling-align-[YYYYMMDD-HHMMSS] (UTC timestamp))
  --seqtype {dna,pep,AUTO}
                        Input data sequence type (default: AUTO)
  -E, --evalue float    Hmmsearch reporting threshold (default: 1e-10, only
                        being used when bitscore cutoff file is not available)
  -M, --method {hmmalign,muscle}
                        Program used for multiple sequence alignment (default:
                        hmmalign)
  --non_trim            Report non-trimmed alignment results
  -t, --threads THREADS
                        Threads for hmmsearch and the number of parallelized
                        jobs in MSA step. Better be multiple of 4 if using
                        more than 8 threads (default: 20)
  -v, --verbose         Verbose mode for debug
  -h, --help            show this help message and exit
```


## phyling_filter

### Tool Description
Filter the multiple sequence alignment (MSA) results for tree module.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/stajichlab/Phyling
- **Package**: https://anaconda.org/channels/bioconda/packages/phyling/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyling filter (-i file [files ...] | -I directory) -n TOP_N_TOVERR
                      [-o directory] [--seqtype {pep,dna,AUTO}] [--ml]
                      [-t THREADS] [-v] [-h]

Filter the multiple sequence alignment (MSA) results for tree module.

The align step usually reports a lot of markers but many of them are
uninformative or susceptible to composition bias. The Treeness/RCV value
computed by PhyKIT is used to estimate how informative the markers are. By
default the -n/--top_n_toverr is set to 50 to select only the top 50 markers.

Required arguments:
  -i, --inputs file [files ...]
                        Multiple sequence alignment fasta of the markers
  -I, --input_dir directory
                        Directory containing multiple sequence alignment fasta
                        of the markers
  -n, --top_n_toverr TOP_N_TOVERR
                        Select the top n markers based on their treeness/RCV
                        for final tree building

Options:
  -o, --output directory
                        Output directory of the treeness.tsv and selected MSAs
                        (default: phyling-tree-[YYYYMMDD-HHMMSS] (UTC
                        timestamp))
  --seqtype {pep,dna,AUTO}
                        Input data sequence type (default: AUTO)
  --ml                  Use maximum-likelihood estimation during tree building
  -t, --threads THREADS
                        Threads for filtering (default: 20)
  -v, --verbose         Verbose mode for debug
  -h, --help            show this help message and exit
```


## phyling_tree

### Tool Description
Construct a phylogenetic tree by the selected multiple sequence alignment (MSA) results.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/stajichlab/Phyling
- **Package**: https://anaconda.org/channels/bioconda/packages/phyling/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyling tree (-i file [files ...] | -I directory) [-o directory]
                    [--seqtype {pep,dna,AUTO}] [-M {ft,raxml,iqtree}] [-c]
                    [-p] [-f] [--seed SEED] [-t THREADS] [-v] [-h]

Construct a phylogenetic tree by the selected multiple sequence alignment
(MSA) results.

By default the consensus tree method will be employed which use a 50% cutoff
to represent the majority of all the trees. You can use the -c/--concat option
to concatenate the MSA and build a single tree instead. Note that enable the
-p/--partition option will also output a partition file that compatible to
RAxML-NG and IQ-TREE.

For the tree building step, the FastTree will be used as default algorithm.
Users can switch to the RAxML-NG or IQ-TREE by specifying the -m/--method
raxml/iqtree.

Once the tree is built, an ASCII figure representing the tree will be
displayed, and a treefile in Newick format will be generated as output.
Additionally, users can choose to obtain a matplotlib-style figure using the
-f/--figure option.

Required arguments:
  -i, --inputs file [files ...]
                        Multiple sequence alignment fasta of the markers
  -I, --input_dir directory
                        Directory containing multiple sequence alignment fasta
                        of the markers

Options:
  -o, --output directory
                        Output directory of the newick treefile (default:
                        phyling-tree-[YYYYMMDD-HHMMSS] (UTC timestamp))
  --seqtype {pep,dna,AUTO}
                        Input data sequence type (default: AUTO)
  -M, --method {ft,raxml,iqtree}
                        Algorithm used for tree building. (default: ft)
                        Available options:
                        ft: FastTree
                        raxml: RAxML-NG
                        iqtree: IQTree
  -c, --concat          Concatenated alignment results
  -p, --partition       Partitioned analysis by sequence. Only works when
                        --concat enabled.
  -f, --figure          Generate a matplotlib tree figure
  --seed SEED           Seed number for stochastic elements during inferences.
                        (default: -1 to generate randomly)
  -t, --threads THREADS
                        Threads for tree construction (default: 20)
  -v, --verbose         Verbose mode for debug
  -h, --help            show this help message and exit
```


## Metadata
- **Skill**: generated
