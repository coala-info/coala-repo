# tandemtwister CWL Generation Report

## tandemtwister_germline

### Tool Description
Genotyping tandem repeats from long-read alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0
- **Homepage**: https://github.com/Lionward/tandemtwister
- **Package**: https://anaconda.org/channels/bioconda/packages/tandemtwister/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tandemtwister/overview
- **Total Downloads**: 326
- **Last updated**: 2026-01-02
- **GitHub**: https://github.com/Lionward/tandemtwister
- **Stars**: N/A
### Original Help Text
```text
Error: Unrecognized argument -help
--------------------------------------------------------------------------------
TandemTwister
--------------------------------------------------------------------------------
  Purpose: A tool for genotyping tandem repeats from long reads and aligned genome input
  Version: v0.2.0
  Author: Lion Ward Al Raei
  Contact: Lionward.alraei@gmail.com
  Institute: Max Planck Institute for Molecular Genetics


Germline Analysis
-----------------
Genotyping tandem repeats from long reads.

Commands
--------
  germline                                        Genotyping tandem repeats from long-read alignments.
  somatic                                         Somatic expansion profiling using long-read alignments.
  assembly                                        Genotyping tandem repeats from aligned assembly input.

Usage
-----
  tandemtwister germline [options] -b <input_bam> -m <motif_file> -r <reference_fasta> -o <output_file> -s <sample_sex>

Required Arguments
------------------
  -b, --bam                                       Path to the BAM file containing aligned reads
  -r, --ref                                       Reference FASTA file (.fa / .fna)
  -m, --motif_file                                Motif definition file (BED / TSV / CSV)
  -o, --output_file                               Output file for region, motif, and haplotype copy numbers
  -s, --sex                                       Sample sex (0 | female, 1 | male)
  -sn, --sample                                   Optional sample identifier
  -rt, --reads_type                               Sequencing platform / read type (default: CCS)
  -t, --threads                                   Number of threads (default: 1)

Alignment Parameters
--------------------
  -mml, --min_match_ratio_l                       Minimum match ratio for long motifs (default: 0.5)

Read Extraction
---------------
  --output_file_statistics                        Optional phasing summary output file
  -pad, --padding                                 Padding around the STR region when extracting reads (default: 0)
  -kcr, --keepCutReads                            Retain reads trimmed during preprocessing (default: false)
  -minR, --minReadsInRegion                       Minimum spanning reads required per region (default: 2)
  -btg, --bamIsTagged                             Treat BAM as pre-tagged/phased (default: false)
  -qs, --quality_score                            Minimum read quality score (default: 10, max: 60)

Reference-based Correction Parameters
-------------------------------------
  -rtr, --refineTrRegions                         Refine tandem repeat regions (default: false)
  -tanCon, --tandem_run_threshold                 Maximum bases for merging tandem-repeat runs (default: 2 × motif size)

Read-based Correction Parameters
--------------------------------
  -cor, --correct                                 Enable genotype correction (CCS default: false; CLR/ONT default: true)
  -crs, --consensus_ratio_str                     Minimum consensus ratio for STR correction (default: 0.3)
  -crv, --consensus_ratio_vntr                    Minimum consensus ratio for VNTR correction (default: 0.3)
  -roz, --removeOutliersZscore                    Remove outliers before phasing (default: false)

Clustering
----------
  -seps, --start_eps_str                          Initial epsilon for STR clustering (default: 0.2)
  -sepv, --start_eps_vntr                         Initial epsilon for VNTR clustering (default: 0.2)
  -minPF, --minPts_frac                           Minimum read fraction per cluster (default: 0.12)
  -nls, --noise_limit_str                         Noise limit for STR clustering (default: 0.2)
  -nlv, --noise_limit_vntr                        Noise limit for VNTR clustering (default: 0.35)
  -ci, --cluster_iter                             Number of clustering iterations (default: 40)

General
-------
  -v, --verbose                                   Verbosity level (0: error, 1: critical, 2: info, 3: debug)
  -h, --help                                      Display this help or version information
  --version                                       Display version information

License & Warranty
------------------
  License: BSD 3-Clause Non-Commercial License
  Warranty: Provided "AS IS" without warranty of any kind.
  Usage: For research purposes only; not for diagnostic or clinical use.
```


## tandemtwister_somatic

### Tool Description
Somatic expansion profiling using long-read alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0
- **Homepage**: https://github.com/Lionward/tandemtwister
- **Package**: https://anaconda.org/channels/bioconda/packages/tandemtwister/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Unrecognized argument -help
--------------------------------------------------------------------------------
TandemTwister
--------------------------------------------------------------------------------
  Purpose: A tool for genotyping tandem repeats from long reads and aligned genome input
  Version: v0.2.0
  Author: Lion Ward Al Raei
  Contact: Lionward.alraei@gmail.com
  Institute: Max Planck Institute for Molecular Genetics


Somatic Analysis
----------------
Genotyping tandem repeats from long reads.

Commands
--------
  germline                                        Genotyping tandem repeats from long-read alignments.
  somatic                                         Somatic expansion profiling using long-read alignments.
  assembly                                        Genotyping tandem repeats from aligned assembly input.

Usage
-----
  tandemtwister somatic [options] -b <input_bam> -m <motif_file> -r <reference_fasta> -o <output_file> -s <sample_sex>

Required Arguments
------------------
  -b, --bam                                       Path to the BAM file containing aligned reads
  -r, --ref                                       Reference FASTA file (.fa / .fna)
  -m, --motif_file                                Motif definition file (BED / TSV / CSV)
  -o, --output_file                               Output file for region, motif, and haplotype copy numbers
  -s, --sex                                       Sample sex (0 | female, 1 | male)
  -sn, --sample                                   Optional sample identifier
  -rt, --reads_type                               Sequencing platform / read type (default: CCS)
  -t, --threads                                   Number of threads (default: 1)

Alignment Parameters
--------------------
  -mml, --min_match_ratio_l                       Minimum match ratio for long motifs (default: 0.5)

Read Extraction
---------------
  --output_file_statistics                        Optional phasing summary output file
  -pad, --padding                                 Padding around the STR region when extracting reads (default: 0)
  -kcr, --keepCutReads                            Retain reads trimmed during preprocessing (default: false)
  -minR, --minReadsInRegion                       Minimum spanning reads required per region (default: 2)
  -btg, --bamIsTagged                             Treat BAM as pre-tagged/phased (default: false)
  -qs, --quality_score                            Minimum read quality score (default: 10, max: 60)

Reference-based Correction Parameters
-------------------------------------
  -rtr, --refineTrRegions                         Refine tandem repeat regions (default: false)
  -tanCon, --tandem_run_threshold                 Maximum bases for merging tandem-repeat runs (default: 2 × motif size)

Read-based Correction Parameters
--------------------------------
  -cor, --correct                                 Enable genotype correction (CCS default: false; CLR/ONT default: true)
  -crs, --consensus_ratio_str                     Minimum consensus ratio for STR correction (default: 0.3)
  -crv, --consensus_ratio_vntr                    Minimum consensus ratio for VNTR correction (default: 0.3)
  -roz, --removeOutliersZscore                    Remove outliers before phasing (default: false)

Clustering
----------
  -seps, --start_eps_str                          Initial epsilon for STR clustering (default: 0.2)
  -sepv, --start_eps_vntr                         Initial epsilon for VNTR clustering (default: 0.2)
  -minPF, --minPts_frac                           Minimum read fraction per cluster (default: 0.12)
  -nls, --noise_limit_str                         Noise limit for STR clustering (default: 0.2)
  -nlv, --noise_limit_vntr                        Noise limit for VNTR clustering (default: 0.35)
  -ci, --cluster_iter                             Number of clustering iterations (default: 40)

General
-------
  -v, --verbose                                   Verbosity level (0: error, 1: critical, 2: info, 3: debug)
  -h, --help                                      Display this help or version information
  --version                                       Display version information

License & Warranty
------------------
  License: BSD 3-Clause Non-Commercial License
  Warranty: Provided "AS IS" without warranty of any kind.
  Usage: For research purposes only; not for diagnostic or clinical use.
```


## tandemtwister_assembly

### Tool Description
Genotyping tandem repeats from aligned genome input.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0
- **Homepage**: https://github.com/Lionward/tandemtwister
- **Package**: https://anaconda.org/channels/bioconda/packages/tandemtwister/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Unrecognized argument -help
--------------------------------------------------------------------------------
TandemTwister
--------------------------------------------------------------------------------
  Purpose: A tool for genotyping tandem repeats from long reads and aligned genome input
  Version: v0.2.0
  Author: Lion Ward Al Raei
  Contact: Lionward.alraei@gmail.com
  Institute: Max Planck Institute for Molecular Genetics


Assembly Analysis
-----------------
Genotyping tandem repeats from aligned genome input.

Usage
-----
  tandemtwister assembly [options] -b <input_bam> -m <motif_file> -r <reference_fasta> -o <output_file> -s <sample_sex>

Required Arguments
------------------
  -b, --bam                                       Path to the BAM file containing aligned reads
  -r, --ref                                       Reference FASTA file (.fa / .fna)
  -m, --motif_file                                Motif definition file (BED / TSV / CSV)
  -o, --output_file                               Output file for region, motif, and haplotype copy numbers
  -s, --sex                                       Sample sex (0 | female, 1 | male)
  -sn, --sample                                   Optional sample identifier
  -rt, --reads_type                               Sequencing platform / read type (default: CCS)

Alignment Parameters
--------------------
  -mml, --min_match_ratio_l                       Minimum match ratio for long motifs (default: 0.5)

General
-------
  -v, --verbose                                   Verbosity level (0: error, 1: critical, 2: info, 3: debug)
  -h, --help                                      Display this help or version information
  --version                                       Display version information

License & Warranty
------------------
  License: BSD 3-Clause Non-Commercial License
  Warranty: Provided "AS IS" without warranty of any kind.
  Usage: For research purposes only; not for diagnostic or clinical use.
```

