# nucleoatac CWL Generation Report

## nucleoatac_run

### Tool Description
Run the nucleoatac pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
- **Homepage**: http://nucleoatac.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Total Downloads**: 13.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Command run:  /usr/local/bin/nucleoatac run --help
nucleoatac version 0.3.4
start run at: 2026-02-26 19:32
usage: nucleoatac run [-h] --bed bed_file --bam bam_file --out output_basename
                      --fasta genome_seq [--pwm Tn5_PWM] [--cores num_cores]
                      [--write_all]

optional arguments:
  -h, --help            show this help message and exit

Required:
  Necessary arguments

  --bed bed_file        Regions for which to do stuff.
  --bam bam_file        Accepts sorted BAM file
  --out output_basename
                        give output basename
  --fasta genome_seq    Indexed fasta file

Bias calculation parameters:

  --pwm Tn5_PWM         PWM descriptor file. Default is Human.PWM.txt included
                        in package

General options:

  --cores num_cores     Number of cores to use
  --write_all           write all tracks
```


## nucleoatac_occ

### Tool Description
Calculate nucleosome occupancy

### Metadata
- **Docker Image**: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
- **Homepage**: http://nucleoatac.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Validation**: PASS

### Original Help Text
```text
Command run:  /usr/local/bin/nucleoatac occ --help
nucleoatac version 0.3.4
start run at: 2026-02-26 19:33
usage: nucleoatac occ [-h] --bed bed_file --bam bam_file --out basename
                      [--fasta genome_seq] [--pwm Tn5_PWM]
                      [--sizes fragmentsizes_file] [--cores int] [--upper int]
                      [--flank int] [--min_occ float] [--nuc_sep int]
                      [--confidence_interval float] [--step int]

optional arguments:
  -h, --help            show this help message and exit

Required:
  Necessary arguments

  --bed bed_file        Peaks in bed format
  --bam bam_file        Sorted (and indexed) BAM file
  --out basename        give output basename

Bias calculation information:
  Highly recommended. If fasta is not provided, will not calculate bias

  --fasta genome_seq    Indexed fasta file
  --pwm Tn5_PWM         PWM descriptor file. Default is Human.PWM.txt included
                        in package

General Options:

  --sizes fragmentsizes_file
                        File with fragment size distribution. Use if don't
                        want calculation of fragment size
  --cores int           Number of cores to use

Occupancy parameter:
  Change with caution

  --upper int           upper limit in insert size. default is 251
  --flank int           Distance on each side of dyad to include for local occ
                        calculation. Default is 60.
  --min_occ float       Occupancy cutoff for determining nucleosome
                        distribution. Default is 0.1
  --nuc_sep int         minimum separation between occupany peaks. Default is
                        120.
  --confidence_interval float
                        confidence interval level for lower and upper bounds.
                        default is 0.9, should be between 0 and 1
  --step int            step size along genome for comuting occ. Default is 5.
                        Should be odd, or will be subtracted by 1
```


## nucleoatac_vprocess

### Tool Description
Processes nucleosome positioning data to generate various outputs and plots related to insert sizes and nucleosome footprints.

### Metadata
- **Docker Image**: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
- **Homepage**: http://nucleoatac.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Validation**: PASS

### Original Help Text
```text
Command run:  /usr/local/bin/nucleoatac vprocess --help
nucleoatac version 0.3.4
start run at: 2026-02-26 19:33
usage: nucleoatac vprocess [-h] --out output_basename [--sizes file]
                           [--vplot vmat_file] [--lower int] [--upper int]
                           [--flank int] [--smooth float] [--plot_extra]

optional arguments:
  -h, --help            show this help message and exit

Required:
  Necessary arguments

  --out output_basename

VPlot and Insert Size Options:
  Optional

  --sizes file          Insert distribution file
  --vplot vmat_file     Accepts VMat file. Default is Vplot from S. Cer.

Size parameers:
  Use sensible values

  --lower int           lower limit (inclusive) in insert size. default is 105
  --upper int           upper limit (exclusive) in insert size. default 251
  --flank int           distance on each side of dyad to include

Options:

  --smooth float        SD to use for gaussian smoothing. Use 0 for no
                        smoothing.
  --plot_extra          Make some additional plots
```


## nucleoatac_nuc

### Tool Description
Nucleosome calling

### Metadata
- **Docker Image**: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
- **Homepage**: http://nucleoatac.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Validation**: PASS

### Original Help Text
```text
Command run:  /usr/local/bin/nucleoatac nuc --help
nucleoatac version 0.3.4
start run at: 2026-02-26 19:33
usage: nucleoatac nuc [-h] --bed bed_file --vmat vdensity_file --bam bam_file
                      --out basename [--fasta genome_seq] [--pwm Tn5_PWM]
                      [--sizes fragmentsizes_file] [--occ_track occ_file]
                      [--cores num_cores] [--write_all] [--not_atac]
                      [--min_z float] [--min_lr float] [--nuc_sep int]
                      [--redundant_sep int] [--sd int]

optional arguments:
  -h, --help            show this help message and exit

Required:
  Necessary arguments

  --bed bed_file        Regions for which to do stuff.
  --vmat vdensity_file  VMat object
  --bam bam_file        Accepts sorted BAM file
  --out basename        give output basename

Bias options:
  If --fasta not provided, bias not calculated

  --fasta genome_seq    Indexed fasta file
  --pwm Tn5_PWM         PWM descriptor file. Default is Human.PWM.txt included
                        in package

General options:

  --sizes fragmentsizes_file
                        File with fragment size distribution. Use if don't
                        want calculation of fragment size
  --occ_track occ_file  bgzip compressed, tabix-indexed bedgraph file with
                        occcupancy track. Otherwise occ not determined for nuc
                        positions.
  --cores num_cores     Number of cores to use
  --write_all           write all tracks
  --not_atac            data is not atac-seq

Nucleosome calling parameters:
  Change with caution

  --min_z float         Z-score threshold for nucleosome calls. Default is 3
  --min_lr float        Log likelihood ratio threshold for nucleosome calls.
                        Default is 0
  --nuc_sep int         Minimum separation between non-redundant nucleosomes.
                        Default is 120
  --redundant_sep int   Minimum separation between redundant nucleosomes. Not
                        recommended to be below 15. Default is 25
  --sd int              Standard deviation for smoothing. Affect the
                        resolution at which nucleosomes can be positioned. Not
                        recommended to exceed 25 or to be smaller than 10.
                        Default is 10
```


## nucleoatac_merge

### Tool Description
Merge nucleosome occupancy and position files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
- **Homepage**: http://nucleoatac.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Validation**: PASS

### Original Help Text
```text
Command run:  /usr/local/bin/nucleoatac merge --help
nucleoatac version 0.3.4
start run at: 2026-02-26 19:34
usage: nucleoatac merge [-h] --occpeaks occpeaks_file --nucpos nucpos_file
                        [--out out_basename] [--sep min_separation]
                        [--min_occ min_occ]

optional arguments:
  -h, --help            show this help message and exit

Required:
  Necessary arguments

  --occpeaks occpeaks_file
                        Output from occ utility
  --nucpos nucpos_file  Output from nuc utility

Options:
  optional

  --out out_basename    output file basename
  --sep min_separation  minimum separation between call
  --min_occ min_occ     minimum lower bound occupancy of nucleosomes to be
                        considered for excluding NFR. default is 0.1
```


## nucleoatac_nfr

### Tool Description
NFR determination parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
- **Homepage**: http://nucleoatac.readthedocs.io/en/latest/
- **Package**: https://anaconda.org/channels/bioconda/packages/nucleoatac/overview
- **Validation**: PASS

### Original Help Text
```text
Command run:  /usr/local/bin/nucleoatac nfr --help
nucleoatac version 0.3.4
start run at: 2026-02-26 19:34
usage: nucleoatac nfr [-h] --bed bed_file --occ_track occ_file --calls
                      nucpos_file [--ins_track ins_file] [--bam bam_file]
                      [--fasta genome_seq] [--pwm Tn5_PWM]
                      [--out out_basename] [--cores num_cores]
                      [--max_occ float] [--max_occ_upper float]

optional arguments:
  -h, --help            show this help message and exit

Required:
  Necessary arguments

  --bed bed_file        Peaks in bed format
  --occ_track occ_file  bgzip compressed, tabix-indexed bedgraph file with
                        occcupancy track.
  --calls nucpos_file   bed file with nucleosome center calls

Insertion track options:
  Either input insertion track or bamfile

  --ins_track ins_file  bgzip compressed, tabix-indexed bedgraph file with
                        insertion track. will be generated if not included
  --bam bam_file        Sorted (and indexed) BAM file

Bias calculation information:
  Highly recommended. If fasta is not provided, will not calculate bias

  --fasta genome_seq    Indexed fasta file
  --pwm Tn5_PWM         PWM descriptor file. Default is Human.PWM.txt included
                        in package

General options:
  optional

  --out out_basename    output file basename
  --cores num_cores     Number of cores to use

NFR determination parameters:
  --max_occ float       Maximum mean occupancy for NFR. Default is 0.1
  --max_occ_upper float
                        Maximum for minimum of upper bound occupancy in NFR.
                        Default is 0.25
```


## Metadata
- **Skill**: generated
