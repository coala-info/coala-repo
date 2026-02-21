# perbase CWL Generation Report

## perbase_base-depth

### Tool Description
Calculate the depth at each base, per-nucleotide

### Metadata
- **Docker Image**: quay.io/biocontainers/perbase:1.2.0--h15397dd_0
- **Homepage**: https://github.com/sstadick/perbase
- **Package**: https://anaconda.org/channels/bioconda/packages/perbase/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perbase/overview
- **Total Downloads**: 50.3K
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/sstadick/perbase
- **Stars**: N/A
### Original Help Text
```text
perbase-base-depth 1.2.0
Seth Stadick <sstadick@gmail.com>
Calculate the depth at each base, per-nucleotide

USAGE:
    perbase base-depth [FLAGS] [OPTIONS] <reads>

FLAGS:
    -Z, --bgzip                     
            Optionally bgzip the output

    -h, --help                      
            Prints help information

    -k, --keep-zeros                
            Keep positions even if they have 0 depth

    -m, --mate-fix                  
            Fix overlapping mates counts, see docs for full details

    -M, --skip-merging-intervals    
            Skip merging togther regions specified in the optional BED or BCF/VCF files.
            
            **NOTE** If this is set it could result in duplicate output entries for regions that overlap. **NOTE** This
            may cause issues with downstream tooling.
    -V, --version                   
            Prints version information

    -z, --zero-base                 
            Output positions as 0-based instead of 1-based


OPTIONS:
    -B, --bcf-file <bcf-file>
            A BCF/VCF file containing positions of interest. If specified, only bases from the given positions will be
            reported on
    -b, --bed-file <bed-file>
            A BED file containing regions of interest. If specified, only bases from the given regions will be reported
            on
    -C, --channel-size-modifier <channel-size-modifier>
            The fraction of a gigabyte to allocate per thread for message passing, can be greater than 1.0 [default:
            0.15]
    -c, --chunksize <chunksize>
            The ideal number of basepairs each worker receives. Total bp in memory at one time is (threads - 2) *
            chunksize [default: 1000000]
    -L, --compression-level <compression-level>
            The level to use for compressing output (specified by --bgzip) [default: 2]

    -T, --compression-threads <compression-threads>
            The number of threads to use for compressing output (specified by --bgzip) [default: 4]

    -F, --exclude-flags <exclude-flags>                          
            SAM flags to exclude, recommended 3848 [default: 0]

    -f, --include-flags <include-flags>                          
            SAM flags to include [default: 0]

    -M, --mate-resolution-strategy <mate-resolution-strategy>
            If `mate_fix` is true, select the method to use for mate fixing [default: original]

    -D, --max-depth <max-depth>
            Set the max depth for a pileup. If a positions depth is within 1% of max-depth the `NEAR_MAX_DEPTH` output
            field will be set to true and that position should be viewed as suspect [default: 100000]
    -Q, --min-base-quality-score <min-base-quality-score>
            Minium base quality for a base to be counted toward [A, C, T, G]. If the base is less than the specified
            quality score it will instead be counted as an `N`. If nothing is set for this no cutoff will be applied
    -q, --min-mapq <min-mapq>
            Minimum MAPQ for a read to count toward depth [default: 0]

    -o, --output <output>                                        
            Output path, defaults to stdout

        --ref-cache-size <ref-cache-size>
            Number of Reference Sequences to hold in memory at one time. Smaller will decrease mem usage [default: 10]

    -r, --ref-fasta <ref-fasta>                                  
            Indexed reference fasta, set if using CRAM

    -t, --threads <threads>                                      
            The number of threads to use [default: 40]


ARGS:
    <reads>    
            Input indexed BAM/CRAM to analyze
```


## perbase_only-depth

### Tool Description
Calculate the only the depth at each base

### Metadata
- **Docker Image**: quay.io/biocontainers/perbase:1.2.0--h15397dd_0
- **Homepage**: https://github.com/sstadick/perbase
- **Package**: https://anaconda.org/channels/bioconda/packages/perbase/overview
- **Validation**: PASS

### Original Help Text
```text
perbase-only-depth 1.2.0
Seth Stadick <sstadick@gmail.com>
Calculate the only the depth at each base

USAGE:
    perbase only-depth [FLAGS] [OPTIONS] <reads>

FLAGS:
        --bed-format                
            Output BED-like output format with the depth in the 5th column. Note, `-z` can be used with this to change
            coordinates to 0-based to be more BED-like
    -Z, --bgzip                     
            Optionally bgzip the output

    -x, --fast-mode                 
            Calculate depth based only on read starts/stops, see docs for full details

    -h, --help                      
            Prints help information

    -k, --keep-zeros                
            Keep positions even if they have 0 depth

    -m, --mate-fix                  
            Fix overlapping mates counts, see docs for full details

    -n, --no-merge                  
            Skip merging adjacent bases that have the same depth

    -M, --skip-merging-intervals    
            Skip mergeing togther regions specified in the optional BED or BCF/VCF files.
            
            **NOTE** If this is set it could result in duplicate output entries for regions that overlap. **NOTE** This
            may cause issues with downstream tooling.
    -V, --version                   
            Prints version information

    -z, --zero-base                 
            Output positions as 0-based instead of 1-based


OPTIONS:
    -B, --bcf-file <bcf-file>
            A BCF/VCF file containing positions of interest. If specified, only bases from the given positions will be
            reported on. Note that it may be more efficient to calculate depth over regions if your positions are
            clustered tightly together
    -b, --bed-file <bed-file>
            A BED file containing regions of interest. If specified, only bases from the given regions will be reported
            on
    -C, --channel-size-modifier <channel-size-modifier>
            The fraction of a gigabyte to allocate per thread for message passing, can be greater than 1.0 [default:
            0.001]
    -c, --chunksize <chunksize>
            The ideal number of basepairs each worker receives. Total bp in memory at one time is (threads - 2) *
            chunksize [default: 1000000]
    -L, --compression-level <compression-level>
            The level to use for compressing output (specified by --bgzip) [default: 2]

    -T, --compression-threads <compression-threads>
            The number of threads to use for compressing output (specified by --bgzip) [default: 4]

    -F, --exclude-flags <exclude-flags>                    
            SAM flags to exclude, recommended 3848 [default: 0]

    -f, --include-flags <include-flags>                    
            SAM flags to include [default: 0]

    -q, --min-mapq <min-mapq>                              
            Minimum MAPQ for a read to count toward depth [default: 0]

    -o, --output <output>                                  
            Output path, defaults to stdout

    -r, --ref-fasta <ref-fasta>                            
            Indexed reference fasta, set if using CRAM

    -t, --threads <threads>                                
            The number of threads to use [default: 40]


ARGS:
    <reads>    
            Input indexed BAM/CRAM to analyze
```


## Metadata
- **Skill**: generated
