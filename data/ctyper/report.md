# ctyper CWL Generation Report

## ctyper

### Tool Description
A tool for genotyping and estimating NGS read depth using a matrix database.

### Metadata
- **Docker Image**: quay.io/biocontainers/ctyper:1.0.5--h5ca1c30_0
- **Homepage**: https://github.com/ChaissonLab/Ctyper
- **Package**: https://anaconda.org/channels/bioconda/packages/ctyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ctyper/overview
- **Total Downloads**: 875
- **Last updated**: 2025-11-18
- **GitHub**: https://github.com/ChaissonLab/Ctyper
- **Stars**: N/A
### Original Help Text
```text
Usage: Ctyper v1.2.0 [options]

Required:
  -m, --matrix <file>          Path to the matrix database (requires <file>.index). If not provided, the tool runs in dry-run mode to only estimate NGS read depth.

Options:
  -i, --input <value>          Input NGS file; supports CRAM, BAM, SAM, FASTA, FASTQ, or Jellyfish formats.
  -I, --Inputs <file>          Path to a file listing multiple input files.

  -o, --output <value>         Output file (append if file exits, default: stdout)
  -O, --Outputs <file>         Path to a file listing output files corresponding to each input file.

  -n, --nthreads <number>      Number of threads to run different samples in parallel, parallel between sample is more efficient for large cohorts, especially when reading files on slower hard drives (default: 1).
  -N, --subthreads <number>    Number of threads to run each sample, due to file I/O bottleneck, suggest use only 1-4 on hdd drive, but parallele within sample is memory friendly (default: 1).

  -d, --depth <value>          Fixed 31-mer depth value (incompatible with -b/--background). IMPORTANT: 31-mer depth = (1 - 30/read_length) × sequencing_depth. For 150 bp reads, this = 0.4 × sequencing_depth.
  -D, --Depth <file>           File of depth values corresponding to each input (incompatible with -b/--background).
  -b, --background <file>      Background k-mer file to estimate NGS coverage (incompatible with -d/-D). In target runs, randomly generated 1M regions are used for coverage estimation. Defaults: <matrix>.bgd 
  -T <ref fasta path>          Reference FASTA for reading CRAM files (default: use REF_CACHE and REF_PATH environment variables).
  -w, --window <number>        Window size for k-mer coverage report (default: 30).
  -c, --corr <0/1>             Enable NGS k-mer bias correction (default: 1).

Target run options (for using reads aligned to specific regions or genes, will run all genes in database without specifying):

  -g, --gene <name>            Target gene name, prefix (ending with '*', remember to quote escape, e.g., 'HLA*' ), or matrix (starting with '#', e.g., #SMN_group1). Can be specified multiple times.
  -G, --Genes <file>           File listing target genes or matrices.

  -B <file>                    BED file to restrict region analysis. Make sure its medium name field matches your reference genome md5 values (md5sum $reference). One made from profiling run on EBI/GRCh38_full_analysis_set_plus_decoy_hla.fa is included in https://github.com/Walfred-MA/Ctyper/tree/main/data. With -g/-G, only BED entries with names found in -g/-G are used.
  -r  <chr:start-end>          Add a specific region for analysis. Can be specified multiple times. Regions with be merged if multiple regions provided, can work with -B.
  -r  'gene'                   A special key for -r, add regions from matrix database (must be combined with -g/-G; incompatible with -BED). Less accurate than profiled regions. Not recommend if profile file avaiable or running global mode is possible. No need to add if using a frofiling bedfile 

  -r  'Unmap'                  A special key for -r, to include all unmap reads. No need to add if using a frofiling bedfile.

  -r  'HLA'                    A special key for -r, to include reads on all HLA decoys. No need to add if using a frofiling bedfile. 

  --unmap <0/1>                Force include:1 or exclude:0 unmapped reads (only valid in target run). More like a debug function and in most cases, no need to specified. No need to add if using a frofiling bedfile 

Target run profiling options (locate mismapped reads and generate BED files for future use):
  -p, --profile <file>         Input aligned NGS file for profiling.
  -P, --Profile <file>         File listing multiple aligned NGS files for profiling. Can be used with both -O and -o; individual results go to -O paths, and a summary is saved to -o.


Example target mode genotyping command using 16*4 cores on 16 samples to genotype all HLAs:
  ctyper -B TargetRegions.64b32de2fc934679c16e83a2bc072064.bed -m HprcCpcHgsvc_cmr_matrix.txt -I ./ALL_Input_Paths -O ./ALL_Output_Paths -g 'HLA*' -n 16 -N 4 -T GRCh38_full_analysis_set_plus_decoy_hla.fa 2> log.txt
```


## Metadata
- **Skill**: generated
