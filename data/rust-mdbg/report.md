# rust-mdbg CWL Generation Report

## rust-mdbg

### Tool Description
Original implementation of minimizer-space de Bruijn graphs (mdBG) for genome assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
- **Homepage**: https://github.com/ekimb/rust-mdbg
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-mdbg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rust-mdbg/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ekimb/rust-mdbg
- **Stars**: N/A
### Original Help Text
```text
rust-mdbg 0.1.0
Original implementation of minimizer-space de Bruijn graphs (mdBG) for genome assembly.

rust-mdbg is an ultra-fast minimizer-space de Bruijn graph (mdBG) implementation, geared towards the assembly of long
and accurate reads such as PacBio HiFi. rust-mdbg is fast because it operates in minimizer-space, meaning that the
reads, the assembly graph, and the final assembly, are all represented as ordered lists of minimizers, instead of
strings of nucleotides. A conversion step then yields a classical base-space representation.

USAGE:
    rust-mdbg [FLAGS] [OPTIONS] <reads>

FLAGS:
        --bf                      
            Enable Bloom filters
            
            Bloom filters can be used to reduce memory usage, but results in slightly less contiguous assemblies.
        --debug                   
            Activate debug mode
            
            Debug mode shows the base-space sequence and the minimizer-space representation obtained from each read.
        --error-correct           
            Enable error correction with minimizer-space POA
            
            Partial order alignment (POA) can be used (in minimizer-space) to error-correct reads with up to 5% error
            rate.
    -h, --help                    
            Prints help information

        --hpc                     
            Homopolymer-compressed (HPC) input
            
            Both raw and homopolymer-compressed (HPC) reads can be provided as input. If the reads are not compressed,
            rust-mdbg manually performs HPC, but uses the raw sequences for transformation into base-space.
        --reference               
            Reference genome input
            
            Indicates that the input is a (single or a set of) genome(s), not reads. Allows multi-line FASTA and doesn't
            filter any kminmers
        --restart-from-postcor    
            Assemble error-corrected reads
            
            Reads that are error-corrected with rust-mdbg can be used as input.
    -V, --version                 
            Prints version information


OPTIONS:
        --correction-threshold <correction-threshold>    
            POA correction threshold
            
            The maximum number of reads in a minimizer-space partial order alignment (POA) graph that can be replaced
            with the consensus.
    -d, --density <density>                              
            Density threshold for density-based selection scheme
            
            The density threshold is analogous to the fraction of l-mers that will be selected as minimizers from a
            read.
        --distance <distance>                            
            Distance metric (0: Jaccard, 1: containment, 2: Mash)
            
            rust-mdbg uses a distance metric to filter out reads that are not very similar to a query read before
            constructing a partial order alignment (POA) graph.
    -k, --k <k>                                          
            k-min-mer length
            
            The length of each node of the mdBG. If fewer l-mers than this value are obtained from a read, they will be
            ignored.
    -l, --l <l>                                          
            l-mer (minimizer) length
            
            The length of each minimizer selected using the minimizer scheme from base-space sequences.
        --lcp <lcp>                                      
            Core substring file (enables locally consistent parsing (LCP))
            
            Core substrings need to be provided as a single file, one core substring per line. The minimizers will be
            selected if they are a core substring and if they satisfy the density bound.
        --lmer-counts <lmer-counts>                      
            l-mer counts (enables downweighting of frequent l-mers)
            
            Frequencies of l-mers in the reads (obtained using k-mer counters) can be provided in order to downweight
            frequently-occurring l-mers and increase contiguity.
        --lmer-counts-max <lmer-counts-max>              
            Maximum l-mer count threshold
            
            l-mers with frequencies above this threshold will be downweighted.
        --lmer-counts-min <lmer-counts-min>              
            Minimum l-mer count threshold
            
            l-mers with frequencies below this threshold will be downweighted.
        --minabund <minabund>                            
            Minimum k-min-mer abundance
            
            k-min-mers that occur fewer times than this value will be removed from the mdBG.
    -n, --n <n>                                          
            Tuple length for bucketing similar reads
            
            Reads that share a tuple (of l-mers) of this length will be bucketed as candidates for their respective
            partial order alignment (POA) graphs.
    -p, --prefix <prefix>                                
            Output prefix for GFA and .sequences files
            
            All files generated by rust-mdbg (including the GFA and .sequences output files) will have this file name.
        --presimp <presimp>                              
            Pre-simplification (pre-simp) threshold
            
            Additional graph simplification heuristics prior to the construction of the mdBG can be performed. The
            default value for the pre-simplification step is 0.1.
    -t, --t <t>                                          
            POA path weight threshold
            
            During the consensus step for a partial order alignment (POA) graph, paths with weights below this value
            will be removed.
        --threads <threads>                              
            Number of threads
            
            rust-mdbg is highly parallelized to decrease running time, but can be run on a single core as well.
        --uhs <uhs>                                      
            Universal k-mer file (enables universal hitting sets (UHS))
            
            Universal k-mers need to be provided as a single file, one universal k-mer per line. The minimizers will be
            selected if they are a universal k-mer and if they satisfy the density bound.

ARGS:
    <reads>    
            Input file (raw or gzip-/lz4-compressed FASTX)
            
            Input file can be FASTA/FASTQ, as well as gzip-compressed (.gz) or lz4-compressed (.lz4). Lowercase bases
            are currently not supported; see documentation for formatting.
```

