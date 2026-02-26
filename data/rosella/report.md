# rosella CWL Generation Report

## rosella_recover

### Tool Description
Recover MAGs from contigs using UMAP and HDBSCAN clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/rosella:0.5.7--hfa530fd_0
- **Homepage**: https://github.com/rhysnewell/rosella.git
- **Package**: https://anaconda.org/channels/bioconda/packages/rosella/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rosella/overview
- **Total Downloads**: 29.5K
- **Last updated**: 2026-01-21
- **GitHub**: https://github.com/rhysnewell/rosella
- **Stars**: N/A
### Original Help Text
```text
Recover MAGs from contigs using UMAP and HDBSCAN clustering.

Usage: rosella recover [OPTIONS]

Options:
  -H, --full-help
          
      --full-help-roff
          
  -r, --assembly <assembly>
          
  -o, --output-directory <output-directory>
          
  -1, --read1 <read1>...
          
  -2, --read2 <read2>...
          
  -c, --coupled <coupled>...
          
      --interleaved <interleaved>...
          
      --single <single>...
          
      --longreads <longreads>...
          
  -b, --bam-files <bam-files>...
          
  -l, --longread-bam-files <longread-bam-files>...
          
  -t, --threads <threads>
          [default: 10]
  -p, --mapper <mapper>
          [default: minimap2-sr] [possible values: bwa-mem, bwa-mem2, minimap2-sr, minimap2-ont, minimap2-pb, minimap2-hifi, minimap2-no-preset]
      --longread-mapper <longread-mapper>
          [default: minimap2-ont] [possible values: minimap2-ont, minimap2-pb, minimap2-hifi]
      --minimap2-parameters <minimap2-params>
          
      --minimap2-reference-is-index <minimap2-reference-is-index>
          
      --bwa-parameters <bwa-params>
          
      --min-read-aligned-length <min-read-aligned-length>
          
      --min-read-percent-identity <min-read-percent-identity>
          
      --min-read-aligned-percent <min-read-aligned-percent>
          [default: 0.0]
      --min-read-aligned-length-pair <min-read-aligned-length-pair>
          
      --min-read-percent-identity-pair <min-read-percent-identity-pair>
          
      --min-read-aligned-percent-pair <min-read-aligned-percent-pair>
          
      --min-covered-fraction <min-covered-fraction>
          [default: 0.0]
      --proper-pairs-only
          
      --include-secondary
          
      --exclude-supplementary
          
      --contig-end-exclusion <contig-end-exclusion>
          [default: 75]
      --trim-min <trim-min>
          [default: 5.0]
      --trim-max <trim-max>
          [default: 95.0]
  -C, --coverage-file <coverage-file>
          
  -k, --kmer-size <kmer-size>
          [default: 31]
      --sketch-scale <sketch-scale>
          [default: 0.1]
      --seed <seed>
          [default: 42]
  -K, --kmer-frequency-file <kmer-frequency-file>
          
      --min-contig-size <min-contig-size>
          [default: 1500]
      --min-bin-size <min-bin-size>
          [default: 200000]
      --min-contig-count <min-contig-count>
          [default: 10]
      --n-neighbours <n-neighbours>
          [default: 100]
      --max-retries <max-retries>
          [default: 5]
      --max-nb-connections <max-nb-connections>
          [default: 32]
      --max-layers <max-layers>
          [default: 16]
      --ef-construction <ef-construction>
          [default: 100]
      --filtering-rounds <filtering-rounds>
          [default: 1]
      --nb-grad-batches <nb-grad-batches>
          [default: 16]
  -v, --verbose
          
  -q, --quiet
          
  -h, --help
          Print help
```


## rosella_refine

### Tool Description
Refine MAGs using UMAP and HDBSCAN clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/rosella:0.5.7--hfa530fd_0
- **Homepage**: https://github.com/rhysnewell/rosella.git
- **Package**: https://anaconda.org/channels/bioconda/packages/rosella/overview
- **Validation**: PASS

### Original Help Text
```text
Refine MAGs using UMAP and HDBSCAN clustering.

Usage: rosella refine [OPTIONS]

Options:
  -H, --full-help
          
      --full-help-roff
          
  -r, --assembly <assembly>
          
  -o, --output-directory <output-directory>
          
  -f, --genome-fasta-files <genome-fasta-files>...
          
  -d, --genome-fasta-directory <genome-fasta-directory>
          
  -x, --genome-fasta-extension <genome-fasta-extension>
          [default: fna]
      --checkm-results <checkm-results>
          
  -t, --threads <threads>
          [default: 10]
  -1, --read1 <read1>...
          
  -2, --read2 <read2>...
          
  -c, --coupled <coupled>...
          
      --interleaved <interleaved>...
          
      --single <single>...
          
      --longreads <longreads>...
          
  -b, --bam-files <bam-files>...
          
  -l, --longread-bam-files <longread-bam-files>...
          
  -p, --mapper <mapper>
          [default: minimap2-sr] [possible values: bwa-mem, bwa-mem2, minimap2-sr, minimap2-ont, minimap2-pb, minimap2-hifi, minimap2-no-preset]
      --longread-mapper <longread-mapper>
          [default: minimap2-ont] [possible values: minimap2-ont, minimap2-pb, minimap2-hifi]
      --minimap2-parameters <minimap2-params>
          
      --minimap2-reference-is-index <minimap2-reference-is-index>
          
      --bwa-parameters <bwa-params>
          
      --min-read-aligned-length <min-read-aligned-length>
          
      --min-read-percent-identity <min-read-percent-identity>
          
      --min-read-aligned-percent <min-read-aligned-percent>
          [default: 0.0]
      --min-read-aligned-length-pair <min-read-aligned-length-pair>
          
      --min-read-percent-identity-pair <min-read-percent-identity-pair>
          
      --min-read-aligned-percent-pair <min-read-aligned-percent-pair>
          
      --proper-pairs-only
          
      --include-secondary
          
      --exclude-supplementary
          
      --contig-end-exclusion <contig-end-exclusion>
          [default: 75]
      --trim-min <trim-min>
          [default: 5.0]
      --trim-max <trim-max>
          [default: 95.0]
      --min-covered-fraction <min-covered-fraction>
          [default: 0.0]
  -C, --coverage-file <coverage-file>
          
      --seed <seed>
          [default: 42]
  -K, --kmer-frequency-file <kmer-frequency-file>
          
      --min-contig-size <min-contig-size>
          [default: 1500]
      --min-bin-size <min-bin-size>
          [default: 200000]
      --min-contig-count <min-contig-count>
          [default: 10]
      --n-neighbours <n-neighbours>
          [default: 100]
      --max-contamination <max-contamination>
          [default: 15.0]
      --max-retries <max-retries>
          [default: 5]
      --bin-tag <bin-tag>
          [default: refined_1]
  -v, --verbose
          
  -q, --quiet
          
  -h, --help
          Print help
```


## rosella_shell-completion

### Tool Description
Generate a shell completion script for lorikeet

### Metadata
- **Docker Image**: quay.io/biocontainers/rosella:0.5.7--hfa530fd_0
- **Homepage**: https://github.com/rhysnewell/rosella.git
- **Package**: https://anaconda.org/channels/bioconda/packages/rosella/overview
- **Validation**: PASS

### Original Help Text
```text
Generate a shell completion script for lorikeet

Usage: rosella shell-completion [OPTIONS] --output-file <output-file> --shell <shell>

Options:
  -o, --output-file <output-file>  
      --shell <shell>              [possible values: bash, elvish, fish, powershell, zsh]
  -v, --verbose                    
  -q, --quiet                      
  -h, --help                       Print help
```

