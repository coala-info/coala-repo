# pggb CWL Generation Report

## pggb

### Tool Description
Use wfmash, seqwish, smoothxg, odgi, gfaffix, and vg to build, project and display a pangenome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
- **Homepage**: https://github.com/pangenome/pggb
- **Package**: https://anaconda.org/channels/bioconda/packages/pggb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pggb/overview
- **Total Downloads**: 29.3K
- **Last updated**: 2025-04-23
- **GitHub**: https://github.com/pangenome/pggb
- **Stars**: N/A
### Original Help Text
```text
usage: /usr/local/bin/pggb -i <input-fasta> -o <output-dir> [options]
options:
   [wfmash]
    -i, --input-fasta FILE      input FASTA/FASTQ file
    -s, --segment-length N      segment length for mapping [default: 5000]
    -l, --block-length N        minimum block length filter for mapping [default: 5*segment-length]
    -p, --map-pct-id PCT        percent identity for mapping/alignment [default: 90]
    -c, --n-mappings N          number of mappings for each segment [default: 1]
    -g, --hg-filter-ani-diff N  filter out mappings unlikely to be N% less than the best mapping [default: %]
    -N, --no-splits             disable splitting of input sequences during mapping [default: enabled]
    -x, --sparse-map N          keep this fraction of mappings ('auto' for giant component heuristic) [default: 1.0]
    -K, --mash-kmer N           kmer size for mapping [default: 19]
    -F, --mash-kmer-thres N     ignore the top % most-frequent kmers [default: 0.001]
    -Y, --exclude-delim C       skip mappings when the query and target have the same
                                prefix before the last occurrence of the given character C [default: #, assuming PanSN-spec]
   [seqwish]
    -k, --min-match-len N       filter exact matches below this length [default: 23]
    -f, --sparse-factor N       keep this randomly selected fraction of input matches [default: no sparsification]
    -B, --transclose-batch      number of bp to use for transitive closure batch [default: 10M]
   [smoothxg]
    -X, --skip-normalization    do not normalize the final graph [default: normalize the graph]
    -n, --n-haplotypes N        number of haplotypes
    -j, --path-jump-max         maximum path jump to include in block [default: 0]
    -e, --edge-jump-max N       maximum edge jump before breaking [default: 0]
    -G, --poa-length-target N,M target sequence length for POA, one per pass [default: 700,1100]
    -P, --poa-params PARAMS     score parameters for POA in the form of match,mismatch,gap1,ext1,gap2,ext2
                                may also be given as presets: asm5, asm10, asm15, asm20
                                [default: 1,4,6,2,26,1 = asm20]
    -O, --poa-padding N         pad each end of each sequence in POA with N*(mean_seq_len) bp [default: 0.001]
    -d, --pad-max-depth N       depth/haplotype at which we don't pad the POA problem [default: 100]
    -b, --run-abpoa             run abPOA [default: SPOA]
    -z, --global-poa            run the POA in global mode [default: local mode]
    -M, --write-maf             write MAF output representing merged POA blocks [default: off]
    -Q, --consensus-prefix P    use this prefix for consensus path names [default: Consensus_]
   [odgi]
    -v, --skip-viz              don't render visualizations of the graph in 1D and 2D [default: make them]
    -S, --stats                 generate statistics of the seqwish and smoothxg graph [default: off]
   [vg]
    -V, --vcf-spec SPEC         specify a set of VCFs to produce with SPEC = REF[:LEN][,REF[:LEN]]*
                                the paths matching ^REF are used as a reference, while the sample haplotypes
                                are derived from path names, assuming they match the PanSN; e.g. '-V chm13',
                                a path named HG002#1#ctg would be assigned to sample HG002 phase 1.
                                If LEN is specified and greater than 0, the VCFs are decomposed, filtering 
                                sites whose max allele length is greater than LEN. [default: off]
   [multiqc]
    -m, --multiqc               generate MultiQC report of graphs' statistics and visualizations,
                                automatically runs odgi stats [default: off]
   [general]
    -o, --output-dir PATH       output directory
    -D, --temp-dir PATH         directory for temporary files
    -a, --input-paf FILE        input PAF file; the wfmash alignment step is skipped
    -r, --resume                do not overwrite existing outputs in the given directory
                                [default: start pipeline from scratch]
    -t, --threads N             number of compute threads to use in parallel steps [default: 20]
    -T, --poa-threads N         number of compute threads to use during POA (set lower if you OOM during smoothing)
    -A, --keep-temp-files       keep intermediate graphs
    -Z, --compress              compress alignment (.paf), graph (.gfa, .og), and MSA (.maf) outputs with pigz,
                                and variant (.vcf) outputs with bgzip
    --names-with-params         put parameter values in filenames, instead of hashes
    --version                   display the version of pggb
    -h, --help                  this text

Use wfmash, seqwish, smoothxg, odgi, gfaffix, and vg to build, project and display a pangenome graph.
```

