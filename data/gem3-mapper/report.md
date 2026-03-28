# gem3-mapper CWL Generation Report

## gem3-mapper_gem-indexer

### Tool Description
Index a genome for GEM mapper

### Metadata
- **Docker Image**: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
- **Homepage**: https://github.com/smarco/gem3-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gem3-mapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gem3-mapper/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/smarco/gem3-mapper
- **Stars**: N/A
### Original Help Text
```text
USAGE: ./gem-indexer [ARGS]...
    [I/O]
      --input|-i <input_file> (Multi-FASTA)
      --output|-o <output_prefix>
    [Index]
      --bisulfite-index|-b  (default=false)
    [System]
      --threads|-t <number> (default=#cores)
    [Miscellaneous]
      --verbose|-v 
      --help|-h  (print usage)
      --version
```


## gem3-mapper_gem-mapper

### Tool Description
GEM3 mapper

### Metadata
- **Docker Image**: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
- **Homepage**: https://github.com/smarco/gem3-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gem3-mapper/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ./gem-mapper [ARGS]...
    [I/O]
      --index|-I <index_file.gem>
      --input|-i <file> (FASTA/FASTQ, default=stdin)
      --i1|-1 <file> (paired-end, end-1)
      --i2|-2 <file> (paired-end, end-2)
      --gzip-input|-z  (gzip input)
      --bzip-input|-j  (bzip input)
      --output|-o <output_prefix> (default=stdout)
      --gzip-output  (gzip output)
      --bzip-output  (bzip output)
      --report-file <file_name> (default=disabled)
    [Single-end Alignment]
      --mapping-mode 'fast'|'sensitive'|'customed' (default=fast)
      --alignment-max-error|-e <number|percentage> (default=0.12, 12%)
      --alignment-global-min-identity <number|percentage> (default=80%)
      --alignment-global-min-score <number|percentage> (default=0.20)
      --alignment-local 'never'|'if-unmapped' (default=if-unmapped)
      --alignment-local-min-identity <number|percentage> (default=40)
      --alignment-local-min-score <number|percentage> (default=20)
    [Paired-end Alignment]
      --paired-end-alignment|-p 
      --min-template-length|-l <number> (default=disabled)
      --max-template-length|-L <number> (default=10000)
      --discordant-pair-search 'always'|'if-no-concordant'|'never' (default=if-no-concordant)
    [Bisulfite Alignment]
      --bisulfite-read 'inferred','1','2','interleaved','non-stranded' (default=inferred)
      --underconversion_sequence <sequence name> (default=NC_001416.1)
      --overconversion_sequence <sequence name> (default=NC_001604.1)
      --control_sequence <sequence name> (default=NC_001422.1)
    [Alignment Score]
      --gap-affine-penalties A,B,O,X (default=1,4,6,1)
    [Reporting]
      --max-reported-matches|-M <number>|'all' (default=5)
    [Output-format]
      --output-format|-F 'MAP'|'SAM' (default=SAM)
      --sam-compact 'true'|'false' (default=true)
      --sam-read-group-header|-r <read_group_header> (i.e. '@RG\tID:xx\tSM:yy') (default=NULL)
    [System]
      --threads|-t <number> (default=#cores)
    [Miscellaneous]
      --verbose|-v 'quiet'|'user'|'dev' (default=user)
      --version 
      --help|-h  (print usage)
```


## Metadata
- **Skill**: generated
