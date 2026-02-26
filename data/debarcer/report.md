# debarcer CWL Generation Report

## debarcer_preprocess

### Tool Description
Preprocess FASTQ files for debarcer.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/oicr-gsi/debarcer
- **Stars**: N/A
### Original Help Text
```text
usage: debarcer.py preprocess [-h] [-o OUTDIR] -r1 READ1 [-r2 READ2]
                              [-r3 READ3] -p
                              {HALOPLEX,SURESELECT,EPIC-DS,SIMSENSEQ-PE,SIMSENSEQ-SE}
                              [-pf PREPFILE] [-c CONFIG] [-px PREFIX]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --OutDir OUTDIR
                        Output directory. Available from command or config
  -r1 READ1, --Read1 READ1
                        Path to first FASTQ file.
  -r2 READ2, --Read2 READ2
                        Path to second FASTQ file, if applicable
  -r3 READ3, --Read3 READ3
                        Path to third FASTQ file, if applicable
  -p {HALOPLEX,SURESELECT,EPIC-DS,SIMSENSEQ-PE,SIMSENSEQ-SE}, --Prepname {HALOPLEX,SURESELECT,EPIC-DS,SIMSENSEQ-PE,SIMSENSEQ-SE}
                        Name of library prep to use (defined in
                        library_prep_types.ini)
  -pf PREPFILE, --Prepfile PREPFILE
                        Path to your library_prep_types.ini file
  -c CONFIG, --Config CONFIG
                        Path to your config file
  -px PREFIX, --Prefix PREFIX
                        Prefix for naming umi-reheradered fastqs. Use Prefix
                        from Read1 if not provided
```


## debarcer_bed

### Tool Description
Generate a BED file from a BAM file, identifying genomic intervals based on read depth.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py bed [-h] -b BAMFILE -bd BED -mv MINCOV -r REGIONSIZE
                       [-m MAXDEPTH] [-io] [-stp {all,nofilter}]

optional arguments:
  -h, --help            show this help message and exit
  -b BAMFILE, --Bamfile BAMFILE
                        Path to the BAM file
  -bd BED, --Bedfile BED
                        Path to the output bed file
  -mv MINCOV, --MinCov MINCOV
                        Minimum read depth value at all positions in genomic
                        interval
  -r REGIONSIZE, --RegionSize REGIONSIZE
                        Minimum length of the genomic interval (in bp)
  -m MAXDEPTH, --MaxDepth MAXDEPTH
                        Maximum read depth. Default is 1000000
  -io, --IgnoreOrphans  Ignore orphans (paired reads that are not in a proper
                        pair). Default is False, becomes True if used
  -stp {all,nofilter}, --Stepper {all,nofilter}
                        Filter or include reads in the pileup. Options all:
                        skip reads with BAM_FUNMAP, BAM_FSECONDARY,
                        BAM_FQCFAIL, BAM_FDUP flags, nofilter: uses every
                        single read turning off any filtering
```


## debarcer_group

### Tool Description
Group UMIs based on proximity and abundance.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py group [-h] [-o OUTDIR] -r REGION [-b BAMFILE] [-c CONFIG]
                         [-d DISTTHRESHOLD] [-p POSTTHRESHOLD]
                         [-i {True,False}] [-t {True,False}] [-s SEPARATOR]
                         [-rc READCOUNT]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --Outdir OUTDIR
                        Output directory where subdirectories are created
  -r REGION, --Region REGION
                        Region coordinates to search for UMIs. chrN:posA-posB.
                        posA and posB are 1-based included
  -b BAMFILE, --Bamfile BAMFILE
                        Path to the BAM file
  -c CONFIG, --Config CONFIG
                        Path to the config file
  -d DISTTHRESHOLD, --Distance DISTTHRESHOLD
                        Hamming distance threshold for connecting parent-
                        children umis
  -p POSTTHRESHOLD, --Position POSTTHRESHOLD
                        Umi position threshold for grouping umis together
  -i {True,False}, --Ignore {True,False}
                        Keep the most abundant family and ignore families at
                        other positions within each group. Default is False
  -t {True,False}, --Truncate {True,False}
                        Discard reads overlapping with the genomic region if
                        True. Default is False
  -s SEPARATOR, --Separator SEPARATOR
                        String separating the UMI from the remaining of the
                        read name
  -rc READCOUNT, --ReadCount READCOUNT
                        Minimum number of reads in region required for
                        grouping. Default is 0
```


## debarcer_collapse

### Tool Description
Collapse UMIs based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py collapse [-h] [-c CONFIG] [-o OUTDIR] [-b BAMFILE]
                            [-rf REFERENCE] -r REGION -u UMIFILE [-f FAMSIZE]
                            [-ct COUNTTHRESHOLD] [-pt PERCENTTHRESHOLD]
                            [-p POSTTHRESHOLD] [-m MAXDEPTH] [-t {True,False}]
                            [-i {True,False}] [-stp {all,nofilter}]
                            [-s SEPARATOR] [-bq BASE_QUALITY_SCORE]

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG, --Config CONFIG
                        Path to the config file
  -o OUTDIR, --Outdir OUTDIR
                        Output directory where subdirectories are created
  -b BAMFILE, --Bamfile BAMFILE
                        Path to the BAM file
  -rf REFERENCE, --Reference REFERENCE
                        Path to the refeence genome
  -r REGION, --Region REGION
                        Region coordinates to search for UMIs. chrN:posA-posB.
                        posA and posB are 1-based included
  -u UMIFILE, --Umi UMIFILE
                        Path to the .umis file
  -f FAMSIZE, --Famsize FAMSIZE
                        Comma-separated list of minimum umi family size to
                        collapase on
  -ct COUNTTHRESHOLD, --CountThreshold COUNTTHRESHOLD
                        Base count threshold in pileup column
  -pt PERCENTTHRESHOLD, --PercentThreshold PERCENTTHRESHOLD
                        Majority rule consensus threshold in pileup column
  -p POSTTHRESHOLD, --Position POSTTHRESHOLD
                        Umi position threshold for grouping umis together
  -m MAXDEPTH, --MaxDepth MAXDEPTH
                        Maximum read depth. Default is 1000000
  -t {True,False}, --Truncate {True,False}
                        If truncate is True and a region is given, only pileup
                        columns in the exact region specificied are returned.
                        Default is False
  -i {True,False}, --IgnoreOrphans {True,False}
                        Ignore orphans (paired reads that are not in a proper
                        pair). Default is False
  -stp {all,nofilter}, --Stepper {all,nofilter}
                        Filter or include reads in the pileup. Options all:
                        skip reads with BAM_FUNMAP, BAM_FSECONDARY,
                        BAM_FQCFAIL, BAM_FDUP flags, nofilter: uses every
                        single read turning off any filtering
  -s SEPARATOR, --Separator SEPARATOR
                        String separating the UMI from the remaining of the
                        read name
  -bq BASE_QUALITY_SCORE, --Quality BASE_QUALITY_SCORE
                        Base quality score threshold. Bases with quality
                        scores below the threshold are not used in the
                        consensus. Default is 25
```


## debarcer_call

### Tool Description
Call variants based on consensus files and thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py call [-h] [-o OUTDIR] [-c CONFIG] [-rf REFERENCE]
                        [-rt REFTHRESHOLD] [-at ALTTHRESHOLD]
                        [-ft FILTERTHRESHOLD] -f FAMSIZE -cf
                        [CONSFILES [CONSFILES ...]]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --Outdir OUTDIR
                        Output directory where subdirectories are created
  -c CONFIG, --Config CONFIG
                        Path to the config file
  -rf REFERENCE, --Reference REFERENCE
                        Path to the refeence genome
  -rt REFTHRESHOLD, --RefThreshold REFTHRESHOLD
                        Maximum reference frequency to consider (in percent)
                        alternative variants (ie. position with ref freq <=
                        ref_threshold is considered variable)
  -at ALTTHRESHOLD, --AlternativeThreshold ALTTHRESHOLD
                        Minimum allele frequency (in percent) to consider an
                        alternative allele at a variable position (ie. allele
                        freq >= alt_threshold and ref freq <= ref_threshold:
                        alternative allele)
  -ft FILTERTHRESHOLD, --FilterThreshold FILTERTHRESHOLD
                        Minimum number of reads to pass alternative variants
                        (ie. filter = PASS if variant depth >= alt_threshold)
  -f FAMSIZE, --Famsize FAMSIZE
                        Minimum UMI family size
  -cf [CONSFILES [CONSFILES ...]], --Consfiles [CONSFILES [CONSFILES ...]]
                        List of consensus files
```


## debarcer_run

### Tool Description
Run the debarcer pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py run [-h] [-o OUTDIR] [-c CONFIG] [-b BAMFILE]
                       [-rf REFERENCE] [-f FAMSIZE] -bd BEDFILE
                       [-ct COUNTTHRESHOLD] [-pt PERCENTTHRESHOLD]
                       [-p POSTTHRESHOLD] [-d DISTTHRESHOLD]
                       [-rt REFTHRESHOLD] [-at ALTTHRESHOLD]
                       [-ft FILTERTHRESHOLD] [-m MAXDEPTH] [-t] [-io] [-i]
                       [-mg] [-pl] [-rp] [-cl] [-ex {png,jpeg,pdf}]
                       [-sp SAMPLE] [-pr PROJECT] [-mm MEM] [-mv MINCOV]
                       [-mr MINRATIO] [-mu MINUMIS] [-mc MINCHILDREN]
                       [-stp {all,nofilter}] [-s SEPARATOR]
                       [-bq BASE_QUALITY_SCORE] [-rc READCOUNT]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --Outdir OUTDIR
                        Output directory where subdirectories are created
  -c CONFIG, --Config CONFIG
                        Path to the config file
  -b BAMFILE, --Bamfile BAMFILE
                        Path to the BAM file
  -rf REFERENCE, --Reference REFERENCE
                        Path to the refeence genome
  -f FAMSIZE, --Famsize FAMSIZE
                        Comma-separated list of minimum umi family size to
                        collapase on
  -bd BEDFILE, --Bedfile BEDFILE
                        Path to the bed file
  -ct COUNTTHRESHOLD, --CountThreshold COUNTTHRESHOLD
                        Base count threshold in pileup column
  -pt PERCENTTHRESHOLD, --PercentThreshold PERCENTTHRESHOLD
                        Base percent threshold in pileup column
  -p POSTTHRESHOLD, --Position POSTTHRESHOLD
                        Umi position threshold for grouping umis together
  -d DISTTHRESHOLD, --Distance DISTTHRESHOLD
                        Hamming distance threshold for connecting parent-
                        children umis
  -rt REFTHRESHOLD, --RefThreshold REFTHRESHOLD
                        A position is considered variable of reference
                        frequency is <= ref_threshold
  -at ALTTHRESHOLD, --AlternativeThreshold ALTTHRESHOLD
                        Variable position is labeled PASS if allele frequency
                        >= alt_threshold
  -ft FILTERTHRESHOLD, --FilterThreshold FILTERTHRESHOLD
                        Minimum number of reads to pass alternative variants
  -m MAXDEPTH, --MaxDepth MAXDEPTH
                        Maximum read depth. Default is 1000000
  -t, --Truncate        Only pileup columns in the exact region specificied
                        are returned. Default is False, becomes True is used
  -io, --IgnoreOrphans  Ignore orphans (paired reads that are not in a proper
                        pair). Default is False, becomes True if used
  -i, --Ignore          Keep the most abundant family and ignore families at
                        other positions within each group. Default is False,
                        becomes True if used
  -mg, --Merge          Merge data, json and consensus files respectively into
                        a 1 single file. Default is True, becomes False if
                        used
  -pl, --Plot           Generate figure plots. Default is True, becomes False
                        if used
  -rp, --Report         Generate report. Default is True, becomes False if
                        used
  -cl, --Call           Convert consensus files to VCF format. Default is
                        True, becomes False if used
  -ex {png,jpeg,pdf}, --Extension {png,jpeg,pdf}
                        Figure format. Does not generate a report if pdf, even
                        with -r True. Default is png
  -sp SAMPLE, --Sample SAMPLE
                        Sample name to appear to report. Optional, use Output
                        directory basename if not provided
  -pr PROJECT, --Project PROJECT
                        Project for submitting jobs on Univa
  -mm MEM, --Memory MEM
                        Requested memory for submitting jobs to SGE. Default
                        is 20g
  -mv MINCOV, --MinCov MINCOV
                        Minimum coverage value. Values below are plotted in
                        red
  -mr MINRATIO, --MinRatio MINRATIO
                        Minimum children to parent umi ratio. Values below are
                        plotted in red
  -mu MINUMIS, --MinUmis MINUMIS
                        Minimum umi count. Values below are plotted in red
  -mc MINCHILDREN, --MinChildren MINCHILDREN
                        Minimum children umi count. Values below are plotted
                        in red
  -stp {all,nofilter}, --Stepper {all,nofilter}
                        Filter or include reads in the pileup. Options all:
                        skip reads with BAM_FUNMAP, BAM_FSECONDARY,
                        BAM_FQCFAIL, BAM_FDUP flags, nofilter: uses every
                        single read turning off any filtering
  -s SEPARATOR, --Separator SEPARATOR
                        String separating the UMI from the remaining of the
                        read name
  -bq BASE_QUALITY_SCORE, --Quality BASE_QUALITY_SCORE
                        Base quality score threshold. Bases with quality
                        scores below the threshold are not used in the
                        consensus. Default is 25
  -rc READCOUNT, --ReadCount READCOUNT
                        Minimum number of reads in region required for
                        grouping. Default is 0
```


## debarcer_merge

### Tool Description
Merge files of a specified data type.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py merge [-h] [-o OUTDIR] -f [FILES [FILES ...]] -dt
                         {datafiles,consensusfiles,umifiles}

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --Outdir OUTDIR
                        Output directory where subdirectories are created
  -f [FILES [FILES ...]], --Files [FILES [FILES ...]]
                        List of files to be merged
  -dt {datafiles,consensusfiles,umifiles}, --DataType {datafiles,consensusfiles,umifiles}
                        Type of files to be merged
```


## debarcer_plot

### Tool Description
Plotting tool for debarcer results.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py plot [-h] [-c CONFIG] -d DIRECTORY [-e {pdf,png,jpeg}]
                        [-s SAMPLE] [-r {False,True}] [-mv MINCOV]
                        [-mr MINRATIO] [-mu MINUMIS] [-mc MINCHILDREN]
                        [-rt REFTHRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG, --Config CONFIG
                        Path to the config file
  -d DIRECTORY, --Directory DIRECTORY
                        Directory with subdirectories ConsFiles and Datafiles
  -e {pdf,png,jpeg}, --Extension {pdf,png,jpeg}
                        Figure format. Does not generate a report if pdf, even
                        with -r True. Default is png
  -s SAMPLE, --Sample SAMPLE
                        Sample name to apear in the report is reporting flag
                        activated. Optional
  -r {False,True}, --Report {False,True}
                        Generate a report if activated. Default is True
  -mv MINCOV, --MinCov MINCOV
                        Minimum coverage value. Values below are plotted in
                        red
  -mr MINRATIO, --MinRatio MINRATIO
                        Minimum children to parent umi ratio. Values below are
                        plotted in red
  -mu MINUMIS, --MinUmis MINUMIS
                        Minimum umi count. Values below are plotted in red
  -mc MINCHILDREN, --MinChildren MINCHILDREN
                        Minimum children umi count. Values below are plotted
                        in red
  -rt REFTHRESHOLD, --RefThreshold REFTHRESHOLD
                        Cut Y axis at non-ref frequency, the minimum frequency
                        to consider a position variable
```


## debarcer_report

### Tool Description
Generate a report from debarcer results.

### Metadata
- **Docker Image**: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
- **Homepage**: https://github.com/oicr-gsi/debarcer
- **Package**: https://anaconda.org/channels/bioconda/packages/debarcer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: debarcer.py report [-h] -d DIRECTORY [-e {pdf,png,jpeg}] [-s SAMPLE]
                          [-mv MINCOV] [-mr MINRATIO] [-mu MINUMIS]
                          [-mc MINCHILDREN]

optional arguments:
  -h, --help            show this help message and exit
  -d DIRECTORY, --Directory DIRECTORY
                        Directory with subdirectories including Figures
  -e {pdf,png,jpeg}, --Extension {pdf,png,jpeg}
                        Figure format. Does not generate a report if pdf, even
                        with -r True. Default is png
  -s SAMPLE, --Sample SAMPLE
                        Sample name. Optional. Directory basename is sample
                        name if not provided
  -mv MINCOV, --MinCov MINCOV
                        Minimum coverage value. Values below are plotted in
                        red
  -mr MINRATIO, --MinRatio MINRATIO
                        Minimum children to parent umi ratio. Values below are
                        plotted in red
  -mu MINUMIS, --MinUmis MINUMIS
                        Minimum umi count. Values below are plotted in red
  -mc MINCHILDREN, --MinChildren MINCHILDREN
                        Minimum children umi count. Values below are plotted
                        in red
```

