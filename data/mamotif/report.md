# mamotif CWL Generation Report

## mamotif_run

### Tool Description
Run complete workflow (MAnorm + MotifScan + Integration).

Run the complete MAmotif workflow with basic MAnorm/MotifScan options.
If you want to control other advanced options (MAnorm normalization 
options or MotifScan scanning options), please run them independently and
call MAmotif integration module with the `mamotif integrate` sub-command.

### Metadata
- **Docker Image**: quay.io/biocontainers/mamotif:1.1.0--py_0
- **Homepage**: https://github.com/shao-lab/MAmotif
- **Package**: https://anaconda.org/channels/bioconda/packages/mamotif/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mamotif/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shao-lab/MAmotif
- **Stars**: N/A
### Original Help Text
```text
usage: mamotif run [-h] --p1 FILE --p2 FILE [--pf FORMAT] --r1 FILE --r2 FILE
                   [--rf FORMAT] [--n1 NAME] [--n2 NAME] -m NAME -g GENOME
                   [--s1 N] [--s2 N] [--pe] [-p {1e-2,1e-3,1e-4,1e-5,1e-6}]
                   [-t N] [--mode {both,A,B}] [--split] [--upstream DISTANCE]
                   [--downstream DISTANCE]
                   [--correction {benjamin,bonferroni}] -o DIR [--verbose]

Run complete workflow (MAnorm + MotifScan + Integration).

Run the complete MAmotif workflow with basic MAnorm/MotifScan options.
If you want to control other advanced options (MAnorm normalization 
options or MotifScan scanning options), please run them independently and
call MAmotif integration module with the `mamotif integrate` sub-command.

optional arguments:
  -h, --help            show this help message and exit
  --verbose             Enable verbose log messages.

Input Options:
  --p1 FILE, --peak1 FILE
                        Peak file of sample A.
  --p2 FILE, --peak2 FILE
                        Peak file of sample B.
  --pf FORMAT, --peak-format FORMAT
                        Format of the peak files. Support ['bed',
                        'bed3-summit', 'macs', 'macs2', 'narrowpeak',
                        'broadpeak']. Default: bed
  --r1 FILE, --read1 FILE
                        Read file of sample A.
  --r2 FILE, --read2 FILE
                        Read file of sample B.
  --rf FORMAT, --read-format FORMAT
                        Format of the read files. Support ['bed', 'bedpe',
                        'sam', 'bam']. Default: bed
  --n1 NAME, --name1 NAME
                        Name of sample A. If not specified, the peak file name
                        will be used.
  --n2 NAME, --name2 NAME
                        Name of sample B. If not specified, the peak file name
                        will be used.
  -m NAME, --motif NAME
                        Motif set name to scan for.
  -g GENOME, --genome GENOME
                        Genome assembly name.

MAnorm Options:
  --s1 N, --shiftsize1 N
                        Single-end reads shift size for sample A. Reads are
                        shifted by `N` bp towards 3' direction and the 5' end
                        of each shifted read is used to represent the genomic
                        locus of the DNA fragment. Set to 0.5 * fragment size
                        of the ChIP-seq library. Default: 100
  --s2 N, --shiftsize2 N
                        Single-end reads shift size for sample B. Default: 100
  --pe, --paired-end    Paired-end mode. The middle point of each read pair is
                        used to represent the genomic locus of the DNA
                        fragment. If specified, `--s1` and `--s2` will be
                        ignored.

MotifScan Options:
  -p {1e-2,1e-3,1e-4,1e-5,1e-6}
                        P value cutoff for motif scores. Default: 1e-4
  -t N, --threads N     Number of processes used to run in parallel.

MAmotif Options:
  --mode {both,A,B}     Which sample to perform MAmotif on. Default: both

Integration Options:
  --split               Split genomic regions into promoter/distal regions and
                        run separately.
  --upstream DISTANCE   TSS upstream distance for promoters. Default: 4000
  --downstream DISTANCE
                        TSS downstream distance for promoters. Default: 2000
  --correction {benjamin,bonferroni}
                        Method for multiple testing correction. Default:
                        benjamin

Output Options:
  -o DIR, --output-dir DIR
                        Directory to write output files.

Notes:
------
Before running MAmotif, the MotifScan genome/motif data files should be 
configured in advance. Please refer to the documentation for more 
information.
```


## mamotif_integrate

### Tool Description
Run the integration module with MAnorm and MotifScan results.

This command is used when users have already got the MAnorm and MotifScan 
results, and only run the final integration procedure.

### Metadata
- **Docker Image**: quay.io/biocontainers/mamotif:1.1.0--py_0
- **Homepage**: https://github.com/shao-lab/MAmotif
- **Package**: https://anaconda.org/channels/bioconda/packages/mamotif/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mamotif integrate [-h] -i FILE -m FILE [-n] [-g GENOME] [--split]
                         [--upstream DISTANCE] [--downstream DISTANCE]
                         [--correction {benjamin,bonferroni}] -o DIR
                         [--verbose]

Run the integration module with MAnorm and MotifScan results.

This command is used when users have already got the MAnorm and MotifScan 
results, and only run the final integration procedure.

optional arguments:
  -h, --help            show this help message and exit
  --verbose             Enable verbose log messages.

Input Options:
  -i FILE               MAnorm result for sample A or B (A/B_MAvalues.xls).
  -m FILE               MotifScan result for sample A or B
                        (motif_sites_number.xls).
  -n, --negative        Convert M=log2(A/B) to -M=log2(B/A). Required when
                        finding co-factors for sample B.
  -g GENOME             Genome name. Required if `--split` is enabled.

Integration Options:
  --split               Split genomic regions into promoter/distal regions and
                        run separately.
  --upstream DISTANCE   TSS upstream distance for promoters. Default: 4000
  --downstream DISTANCE
                        TSS downstream distance for promoters. Default: 2000
  --correction {benjamin,bonferroni}
                        Method for multiple testing correction. Default:
                        benjamin

Output Options:
  -o DIR, --output-dir DIR
                        Directory to write output files.

Examples:
---------
Suppose you have the MAnorm result (sample A vs sample B), and the 
MotifScan results for both samples:

1) Find cell type-specific co-factors for sample A:

    mamotif integrate -i A_MAvalues.xls -m A_motifscan/motif_sites_numbers.xls -o <path>

2) Convert M=log2(A/B) to -M=log2(B/A) and find co-factors for sample B:

    mamotif integrate -i B_MAvalues.xls -m B_motifscan/motif_sites_numbers.xls -n -o <path>
```

