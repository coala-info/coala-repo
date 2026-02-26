# dodge CWL Generation Report

## dodge

### Tool Description
Dodge is a tool for analyzing genetic variation and identifying outbreaks.

### Metadata
- **Docker Image**: quay.io/biocontainers/dodge:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/LanLab/dodge
- **Package**: https://anaconda.org/channels/bioconda/packages/dodge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dodge/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LanLab/dodge
- **Stars**: N/A
### Original Help Text
```text
usage: dodge [-h] -i VARIANT_DATA --inputtype {snp,allele} -s STRAINMETADATA
             --outputPrefix OUTPUTPREFIX [-d DISTANCES] [-c INCLUSTERS]
             [--background_data] [-n NO_CORES] [--nonomenclatureinid]
             [--isolatecolumn ISOLATECOLUMN] [--useref] [--mask MASK]
             [--snpqual SNPQUAL] [--usegenomes] [--enterobase_data]
             [--startdate STARTDATE] [--enddate ENDDATE]
             [--timesegment {week,month}] [-t TIMEWINDOW] [-l DIST_LIMITS]
             [-m MAX_MISSMATCH] [--minsize MINSIZE]
             [--outbreakmethod {dodge,static,False}]
             [--static_cutoff STATIC_CUTOFF] [--exclude_time_in_static]

options:
  -h, --help            show this help message and exit

Required input/output:
  -i VARIANT_DATA, --variant_data VARIANT_DATA
                        file containing allele profiles (tab delimited table)
                        or snp data (path to folder containing .subs.vcf files
                        from snippy, and optionally consensus.fasta masked
                        genomes.) (default: None)
  --inputtype {snp,allele}
                        is input data alleles or snps (default: None)
  -s STRAINMETADATA, --strainmetadata STRAINMETADATA
                        file containing isolate information (downloaded from
                        mgtdb, enterobase or created for SNPs) (default: None)
  --outputPrefix OUTPUTPREFIX
                        output path and prefix for output file generation
                        (default: output_files)

Optional input/output:
  -d DISTANCES, --distances DISTANCES
                        file containing pairwise distances corresponding to
                        the alleleprofiles file (from previous run of this
                        script if applicable) (default: None)
  -c INCLUSTERS, --inclusters INCLUSTERS
                        existing clusters to be imported (default: None)
  --background_data     data in this input set / time window to be used for
                        background (no outbreak predictions) (default: False)
  -n NO_CORES, --no_cores NO_CORES
                        number cores to increase pairwise distance speed
                        (default: 8)
  --nonomenclatureinid  Do not include MGT or HierCC nomenclature in
                        investigation cluster ID (default: False)
  --isolatecolumn ISOLATECOLUMN
                        Name of column in metadata file that contains isolate
                        names that correspond to input variant data, default =
                        'Strain', 'Name' or 'Isolate' (default: None)

SNP input specific:
  --useref              include reference in distances/clusters for snp
                        inputtype (default: False)
  --mask MASK           bed file for reference used to generate SNPs with
                        regions to ignore SNPs (i.e. phages etc) (default:
                        None)
  --snpqual SNPQUAL     minimum allowable SNP quality score (default: 1000)
  --usegenomes          use the consensus.fasta file from snippy to check for
                        missing data when a snp is not called, include these
                        genomes in the same folder as input vcf files
                        (default: False)

Allele input specific:
  --enterobase_data     metadata and allele profiles downloaded from
                        enterobase, if hierCC in metadata table hierCC will be
                        used for outbreak naming (i.e. column named HCXXX)
                        (default: False)

Date / time options:
  --startdate STARTDATE
                        start date for new cluster analysis (format YYYY-MM-DD
                        if timesegment = week or YYYY-MM if timesegment =
                        month) if left blank earliest date not in inclusters
                        will be identified from strain metadata (default:
                        None)
  --enddate ENDDATE     end date for new cluster analysis (format YYYY-MM-DD)
                        if left blank latest date in input metadata will be
                        used (default: None)
  --timesegment {week,month}
                        time segment to perform analysis. every month or every
                        week (default: week)
  -t TIMEWINDOW, --timewindow TIMEWINDOW
                        time period a cluster must fall into to be called as
                        investigation --outbreakmethod dodge only
                        --timesegment week default 28 --timesegment month
                        default 2 (default: None)

Clustering options:
  -l DIST_LIMITS, --dist_limits DIST_LIMITS
                        comma separated list of cluster cutoffs or range or
                        both i.e 1,2,5 or 1-8 or 1,2,5-10 (default: 1-5)
  -m MAX_MISSMATCH, --max_missmatch MAX_MISSMATCH
                        maximum number of missmatches reported between 2
                        isolates (will default to max of --dist_limits + 1 if
                        not set) (default: 1)

Outbreak detection algorithm options:
  --minsize MINSIZE     smallest cluster size for outbreak detection (default:
                        5)
  --outbreakmethod {dodge,static,False}
                        algorithm for outbreak detection dodge or static
                        (default: dodge)
  --static_cutoff STATIC_CUTOFF
                        cutoff for static genetic cutoff method, must be used
                        with '--outbreakmethod static' (default: 5)
  --exclude_time_in_static
                        When identifying clusters with one static threshold do
                        not apply temporal window for cluster, must be used
                        with '--outbreakmethod static' (default: False)
```

