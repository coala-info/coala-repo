# bamdam CWL Generation Report

## bamdam_shrink

### Tool Description
Shrinks an LCA file and its corresponding BAM file by filtering nodes and alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Total Downloads**: 464
- **Last updated**: 2026-01-12
- **GitHub**: https://github.com/bdesanctis/bamdam
- **Stars**: N/A
### Original Help Text
```text
usage: bamdam shrink [-h] --in_lca IN_LCA --in_bam IN_BAM --out_lca OUT_LCA
                     --out_bam OUT_BAM --stranded STRANDED
                     [--mincount MINCOUNT] [--upto UPTO] [--minsim MINSIM]
                     [--exclude_tax EXCLUDE_TAX [EXCLUDE_TAX ...]]
                     [--exclude_tax_file EXCLUDE_TAX_FILE] [--annotate_pmd]
                     [--dust_max DUST_MAX] [--show_progress]

options:
  -h, --help            show this help message and exit
  --in_lca IN_LCA       Path to the input LCA file (required)
  --in_bam IN_BAM       Path to the input (read-sorted) BAM file (required)
  --out_lca OUT_LCA     Path to the short output LCA file (required)
  --out_bam OUT_BAM     Path to the short output BAM file (required)
  --stranded STRANDED   Either ss for single stranded or ds for double
                        stranded (required)
  --mincount MINCOUNT   Minimum read count to keep a node (default: 5)
  --upto UPTO           Keep nodes up to and including this tax threshold
                        (default: family)
  --minsim MINSIM       Minimum similarity to reference to keep an alignment
                        (default: 0.9)
  --exclude_tax EXCLUDE_TAX [EXCLUDE_TAX ...]
                        Numeric tax ID(s) to exclude when filtering (default:
                        none)
  --exclude_tax_file EXCLUDE_TAX_FILE
                        File of numeric tax ID(s) to exclude when filtering,
                        one per line (default: none)
  --annotate_pmd        Annotate output bam file with PMD tags (default: not
                        set)
  --dust_max DUST_MAX   Maximum DUST score threshold to keep a read (default:
                        not set)
  --show_progress       Print a progress bar (default: not set)
```


## bamdam_compute

### Tool Description
Compute statistics from BAM and LCA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamdam compute [-h] --in_bam IN_BAM --in_lca IN_LCA --out_tsv OUT_TSV
                      --out_subs OUT_SUBS --stranded STRANDED [--k K]
                      [--upto UPTO] [--mode MODE] [--plotdupdust PLOTDUPDUST]
                      [--udg] [--show_progress]

options:
  -h, --help            show this help message and exit
  --in_bam IN_BAM       Path to the BAM file (required)
  --in_lca IN_LCA       Path to the LCA file (required)
  --out_tsv OUT_TSV     Path to the output tsv file (required)
  --out_subs OUT_SUBS   Path to the output subs file (required)
  --stranded STRANDED   Either ss for single stranded or ds for double
                        stranded (required)
  --k K                 Value of k for per-node counts of unique k-mers and
                        duplicity (default: 29)
  --upto UPTO           Keep nodes up to and including this tax threshold; use
                        root to disable (default: family)
  --mode MODE           Mode to calculate stats. 1: use best alignment
                        (recommended), 2: average over reads, 3: average over
                        alignments (default: 1)
  --plotdupdust PLOTDUPDUST
                        Path to create a duplicity-dust plot, ending in .pdf
                        or .png. (default: not set)
  --udg                 Split CpG and non CpG sites. Intended for UDG-treated
                        library damage analysis. (default: not set)
  --show_progress       Print a progress bar (default: not set)
```


## bamdam_extract

### Tool Description
Extracts reads from a BAM file based on taxonomic information.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamdam extract [-h] --in_bam IN_BAM --in_lca IN_LCA --out_bam OUT_BAM
                      [--tax TAX [TAX ...]] [--tax_file TAX_FILE]
                      [--only_top_ref] [--only_top_alignment]

options:
  -h, --help            show this help message and exit
  --in_bam IN_BAM       Path to the BAM file (required)
  --in_lca IN_LCA       Path to the LCA file
  --out_bam OUT_BAM     Path to the output BAM file
  --tax TAX [TAX ...]   Numeric tax ID(s) to extract (default: none)
  --tax_file TAX_FILE   File of numeric tax ID(s) to extract, one per line
                        (default: none)
  --only_top_ref        Only keep alignments to the most-hit reference
                        (default: not set)
  --only_top_alignment  Only output the best alignment for each read. If there
                        are multiple best alignments, randomly picks one
                        (default: not set)
```


## bamdam_plotdamage

### Tool Description
Plot damage patterns from substitution files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamdam plotdamage [-h] (--in_subs IN_SUBS [IN_SUBS ...] |
                         --in_subs_list IN_SUBS_LIST) --tax TAX
                         [--outplot OUTPLOT] [--ymax YMAX] [--udg]

options:
  -h, --help            show this help message and exit
  --in_subs IN_SUBS [IN_SUBS ...]
                        Input subs file(s)
  --in_subs_list IN_SUBS_LIST
                        Path to a text file contaning input subs files, one
                        per line
  --tax TAX             Taxonomic node ID (required)
  --outplot OUTPLOT     Filename for the output plot, ending in .png or .pdf
                        (default: damage_plot.png)
  --ymax YMAX           Maximum for y axis (optional)
  --udg                 Plot CpG and non-CpG lines separately. Requires a subs
                        file(s) that was made with the udg flag. (default: not
                        set)
```


## bamdam_plotbaminfo

### Tool Description
Generate plots from BAM file information.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamdam plotbaminfo [-h] (--in_bam IN_BAM [IN_BAM ...] |
                          --in_bam_list IN_BAM_LIST) [--outplot OUTPLOT]

options:
  -h, --help            show this help message and exit
  --in_bam IN_BAM [IN_BAM ...]
                        Input bam file(s)
  --in_bam_list IN_BAM_LIST
                        Path to a text file containing input bams, one per
                        line
  --outplot OUTPLOT     Filename for the output plot, ending in .png or .pdf
                        (default: baminfo_plot.png)
```


## bamdam_combine

### Tool Description
Combine multiple bamdam compute output TSV files into a single file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamdam combine [-h] (--in_tsv IN_TSV [IN_TSV ...] |
                      --in_tsv_list IN_TSV_LIST) [--out_tsv OUT_TSV]
                      [--minreads MINREADS]
                      [--include [{all,Duplicity,MeanDust,Damage+1,Damage-1,Damage+1_CpG,Damage+1_nonCpG,MeanLength,ANI,AvgReadGC,AvgRefGC,UniqueKmers,UniqKmersPerRead,TotalAlignments,UnaggregatedReads,none} ...]]

options:
  -h, --help            show this help message and exit
  --in_tsv IN_TSV [IN_TSV ...]
                        List of input tsv file(s)
  --in_tsv_list IN_TSV_LIST
                        Path to a text file containing paths to input tsv
                        files, one per line
  --out_tsv OUT_TSV     Path to output tsv file name (default: combined.tsv)
  --minreads MINREADS   Minimum reads across samples to include a taxon
                        (default: 50)
  --include [{all,Duplicity,MeanDust,Damage+1,Damage-1,Damage+1_CpG,Damage+1_nonCpG,MeanLength,ANI,AvgReadGC,AvgRefGC,UniqueKmers,UniqKmersPerRead,TotalAlignments,UnaggregatedReads,none} ...]
                        Extra metrics to include in output file. Specify any
                        combination of columns in your bamdam compute output
                        files. TaxNodeID, TaxName, TotalReads, Duplicity,
                        MeanDust, Damage+1 and taxpath are always included.
                        (default: none)
```


## bamdam_krona

### Tool Description
Generate Krona plots from BAM data.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/bdesanctis/bamdam
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamdam krona [-h] (--in_tsv IN_TSV [IN_TSV ...] |
                    --in_tsv_list IN_TSV_LIST) [--out_xml OUT_XML]
                    [--minreads MINREADS] [--aggregate_to AGGREGATE_TO]
                    [--maxdamage MAXDAMAGE]

options:
  -h, --help            show this help message and exit
  --in_tsv IN_TSV [IN_TSV ...]
                        Path to tsv file(s)
  --in_tsv_list IN_TSV_LIST
                        Path to a text file containing paths to input tsv
                        files, one per line
  --out_xml OUT_XML     Path to output xml file name (default: out.xml)
  --minreads MINREADS   Minimum reads across samples to include taxa (default:
                        100)
  --aggregate_to AGGREGATE_TO
                        The deepest internal taxonomic level to show in the
                        krona plots. Will aggregate if this level is deeper
                        than the taxonomic level the input tsv goes up to.
                        (default: superkingdom)
  --maxdamage MAXDAMAGE
                        Force a maximum value for the 5' C-to-T damage color
                        scale. If not provided, the maximum value is
                        determined from the data, with a minimum threshold of
                        0.3. (not recommended by default)
```


## Metadata
- **Skill**: generated
