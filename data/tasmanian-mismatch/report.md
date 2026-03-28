# tasmanian-mismatch CWL Generation Report

## tasmanian-mismatch_run_intersections

### Tool Description
Run mismatch intersections between BAM and BEDGraph files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/tasmanian-mismatch
- **Package**: https://anaconda.org/channels/bioconda/packages/tasmanian-mismatch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tasmanian-mismatch/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-06-17
- **GitHub**: https://github.com/nebiolabs/tasmanian-mismatch
- **Stars**: N/A
### Original Help Text
```text
samtools view <bam_file> | python -b <bed_file/bedGraph> -o <output.table>

    		the bedGraph file should contain 3 or more columns separated by tabs:
    		------------------------------------------
    		chrI    850     879     +       L1P5    LINE    L1
```


## tasmanian-mismatch_run_tasmanian

### Tool Description
Run Tasmanian mismatch caller

### Metadata
- **Docker Image**: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/tasmanian-mismatch
- **Package**: https://anaconda.org/channels/bioconda/packages/tasmanian-mismatch/overview
- **Validation**: PASS

### Original Help Text
```text
required:
    --------
    -r|--reference-fasta

    optional:
    --------
    -u|--unmask-genome (convert masked bases to upper case and include them in the calculations - default=False)
    -q|--base-quality (default=20)
    -f|--filter-indel (exclude reads with indels default=False)
    -l|--filter-length (include only reads with x,y range of lengths, default=0,350)
    -s|--soft-clip-bypass (Decide when softclipped base is correct(0). Don't use these bases(1). Force use them(2).  default=0)
    -m|--mapping-quality (minimum allowed mapping quality -defailt=0)
    -h|--help
    -g|--fragment-length (use fragments with these lengths ONLY)
    -o|--output-prefix (use this prefix for the output and logging files)
    -c|--confidence (number of bases in the confident region of the read) 
    -d|--debug (create a log file)
    -O|--ont (this is ONT data)
    -p|--picard-logic (normalize tables based on picard CollectSequencingArtifactMetrics logic)
    -P|--include-pwm
```


## Metadata
- **Skill**: generated
