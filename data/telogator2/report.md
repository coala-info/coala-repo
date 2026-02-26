# telogator2 CWL Generation Report

## telogator2

### Tool Description
Telogator

### Metadata
- **Docker Image**: quay.io/biocontainers/telogator2:2.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/zstephens/telogator2
- **Package**: https://anaconda.org/channels/bioconda/packages/telogator2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telogator2/overview
- **Total Downloads**: 153
- **Last updated**: 2025-12-02
- **GitHub**: https://github.com/zstephens/telogator2
- **Stars**: N/A
### Original Help Text
```text
usage: telogator2 [-h] [--version] -i [...] -o output/ [-k kmers.tsv]
                  [-t telogator.fa] [-r ont] [-l 4000] [-c 8] [-n 3] [-m p75]
                  [-d -1] [-p 4] [--filt-tel 400] [--filt-nontel 100]
                  [--filt-sub 1000] [-t0 0.200] [-t1 0.150] [-t2 0.100]
                  [-tc 0.050] [-ts 0.200] [-th 0.050] [-afa-x 15000]
                  [-afa-t 1000] [-afa-a 100] [-va-y 20000] [-va-t 5000]
                  [-va-p 2] [--plot-filt-tvr] [--plot-t1clust]
                  [--plot-t2clust] [--plot-finclust] [--plot-signals]
                  [--plot-fusions] [--dont-reprocess] [--debug-replot]
                  [--debug-nosubtel] [--debug-noanchor] [--debug-telreads]
                  [--debug-progress] [--debug-dendro] [--debug-collapse]
                  [--fast-aln] [--collapse-hom] [--minimap2 exe] [--pbmm2 exe]
                  [--winnowmap exe] [--winnowmap-k15 k15.txt] [--ref ref.fa]
                  [--rng -1]

Telogator

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i [ ...]             * Input reads (fa / fa.gz / fq / fq.gz / bam)
                        (default: None)
  -o output/            * Path to output directory (default: None)
  -k kmers.tsv          Telomere kmers file (default: )
  -t telogator.fa       Telogator reference fasta (default: )
  -r ont                Read type: hifi / ont (default: ont)
  -l 4000               Minimum read length (default: 4000)
  -c 8                  Minimum hits to tandem canonical kmer (default: 8)
  -n 3                  Minimum number of reads per cluster (default: 3)
  -m p75                Method for choosing ATL: mean / median / p75 / max
                        (default: p75)
  -d -1                 Downsample to this many telomere reads (default: -1)
  -p 4                  Number of processes to use (default: 4)
  --filt-tel 400        [FILTERING] Remove reads that end in < this much tel
                        (default: 400)
  --filt-nontel 100     [FILTERING] Remove reads that end in > this much non-
                        tel (default: 100)
  --filt-sub 1000       [FILTERING] Remove reads that end in < this much
                        subtel (default: 1000)
  -t0 0.200             [TREECUT] TVR clustering (iteration 0) (default: 0.2)
  -t1 0.150             [TREECUT] TVR clustering (iteration 1) (default: 0.15)
  -t2 0.100             [TREECUT] TVR clustering (iteration 2) (default: 0.1)
  -tc 0.050             [TREECUT] TVR clustering (collapse) (default: 0.05)
  -ts 0.200             [TREECUT] Subtel cluster refinement (default: 0.2)
  -th 0.050             [TREECUT] Collapsing aligned alleles (default: 0.05)
  -afa-x 15000          [ALL_FINAL_ALLELES.PNG] X axis max (default: 15000)
  -afa-t 1000           [ALL_FINAL_ALLELES.PNG] X axis tick steps (default:
                        1000)
  -afa-a 100            [ALL_FINAL_ALLELES.PNG] Min ATL to include allele
                        (default: 100)
  -va-y 20000           [VIOLIN_ATL.PNG] Y axis max (default: 20000)
  -va-t 5000            [VIOLIN_ATL.PNG] Y axis tick steps (default: 5000)
  -va-p 2               [VIOLIN_ATL.PNG] ploidy. i.e. number of alleles per
                        arm (default: 2)
  --plot-filt-tvr       [DEBUG] Plot denoised TVR instead of raw signal
                        (default: False)
  --plot-t1clust        [DEBUG] Plot tel reads during TVR clustering
                        (iteration 1) (default: False)
  --plot-t2clust        [DEBUG] Plot tel reads during TVR clustering
                        (iteration 2) (default: False)
  --plot-finclust       [DEBUG] Plot tel reads during final clustering
                        (default: False)
  --plot-signals        [DEBUG] Plot tel signals for all reads (default:
                        False)
  --plot-fusions        [DEBUG] Plot tel fusions for all reads (default:
                        False)
  --dont-reprocess      [DEBUG] Use existing intermediary files (for redoing
                        failed runs) (default: False)
  --debug-replot        [DEBUG] Regenerate plots that already exist (default:
                        False)
  --debug-nosubtel      [DEBUG] Skip subtel cluster refinement (default:
                        False)
  --debug-noanchor      [DEBUG] Do not align reads or do any anchoring
                        (default: False)
  --debug-telreads      [DEBUG] Stop immediately after extracting tel reads
                        (default: False)
  --debug-progress      [DEBUG] Print progress to screen during init matrix
                        computation (default: False)
  --debug-dendro        [DEBUG] Plot dendrogram during init clustering
                        (default: False)
  --debug-collapse      [DEBUG] Plot TVR distances during final collapse
                        (default: False)
  --fast-aln            [PERFORMANCE] Use faster but less accurate pairwise
                        alignment (default: False)
  --collapse-hom        Merge similar alleles mapped <= this bp from each
                        other (default: 1000)
  --minimap2 exe        /path/to/minimap2 (default: )
  --pbmm2 exe           /path/to/pbmm2 (default: )
  --winnowmap exe       /path/to/winnowmap (default: )
  --winnowmap-k15 k15.txt
                        high freq kmers file (only needed for winnowmap)
                        (default: )
  --ref ref.fa          Reference filename (only needed if input is cram)
                        (default: )
  --rng -1              RNG seed value (default: -1)
```

