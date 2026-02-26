# vamos CWL Generation Report

## vamos_contig

### Tool Description
Vamos is a tool for detecting tandem repeats in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/vamos:3.0.6--h7f5d12c_0
- **Homepage**: https://github.com/ChaissonLab/vamos
- **Package**: https://anaconda.org/channels/bioconda/packages/vamos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vamos/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2026-02-14
- **GitHub**: https://github.com/ChaissonLab/vamos
- **Stars**: N/A
### Original Help Text
```text
Usage: vamos [subcommand] [options] [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] 
Version: 3.0.4
subcommand:
vamos --contig [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] 
vamos --read [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] [-p phase_flank] 
vamos --somatic [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] [-p phase_flank] 
vamos -m [verison of efficient motif set]

   Input: 
       -b   FILE         Input indexed bam file. 
       -r   FILE         File containing region coordinate and motifs of each VNTR locus. 
                         The file format: columns `chrom,start,end,motifs` are tab-delimited. 
                         Column `motifs` is a comma-separated (no spaces) list of motifs for this VNTR. 
       -R   FILE         Refine start and end pos by realigning to reference FILE (same as mapped reference).
       -s   CHAR         Sample name. 
       -Z                Treat input regions as zero based (e.g. TRExplorer catalog and standard BED files). 
   Input handling:
       -C   INT          Maximum coverage to call a tandem repeat.
   Output: 
       -o   FILE         Output vcf file. 
       -S                Output assembly/read consensus sequence in each call.
       -E                Output reconstructed TR sequence from decomposition in each call.
   Dynamic Programming: 
       -d   DOUBLE       Penalty of indel in dynamic programming (double) DEFAULT: 1.0. 
       -c   DOUBLE       Penalty of mismatch in dynamic programming (double) DEFAULT: 1.0. 
       --naive           Specify the naive version of code to do the annotation, DEFAULT: faster implementation. 
   Phase reads: 
       -P                Force phasing of reads even if a HP tag is present.
       -p   INT            Range of flanking sequences which is used in the phasing step. DEFAULT: 15000 bps. 
       -M   INT            Minimum total coverage to allow a SNV to be called (6). 
       -a   INT            Minimum alt coverage to allow a SNV to be called (3). 
   Downloading motifs:
Most up-to-date motif set, please visit: https://zenodo.org/records/16286509 
   Others: 
       -L   INT          Maximum length locus to compute annotation for (10000)
       -p   INT          Phase flank- how many bases on each side of a VNTR to collect SNVs to phase (default=15000)
       -t   INT          Number of threads, DEFAULT: 1. 
       --debug           Print out debug information. 
       -h                Print out help message.
```


## vamos_read

### Tool Description
Vamos is a tool for VNTR analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/vamos:3.0.6--h7f5d12c_0
- **Homepage**: https://github.com/ChaissonLab/vamos
- **Package**: https://anaconda.org/channels/bioconda/packages/vamos/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vamos [subcommand] [options] [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] 
Version: 3.0.4
subcommand:
vamos --contig [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] 
vamos --read [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] [-p phase_flank] 
vamos --somatic [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] [-p phase_flank] 
vamos -m [verison of efficient motif set]

   Input: 
       -b   FILE         Input indexed bam file. 
       -r   FILE         File containing region coordinate and motifs of each VNTR locus. 
                         The file format: columns `chrom,start,end,motifs` are tab-delimited. 
                         Column `motifs` is a comma-separated (no spaces) list of motifs for this VNTR. 
       -R   FILE         Refine start and end pos by realigning to reference FILE (same as mapped reference).
       -s   CHAR         Sample name. 
       -Z                Treat input regions as zero based (e.g. TRExplorer catalog and standard BED files). 
   Input handling:
       -C   INT          Maximum coverage to call a tandem repeat.
   Output: 
       -o   FILE         Output vcf file. 
       -S                Output assembly/read consensus sequence in each call.
       -E                Output reconstructed TR sequence from decomposition in each call.
   Dynamic Programming: 
       -d   DOUBLE       Penalty of indel in dynamic programming (double) DEFAULT: 1.0. 
       -c   DOUBLE       Penalty of mismatch in dynamic programming (double) DEFAULT: 1.0. 
       --naive           Specify the naive version of code to do the annotation, DEFAULT: faster implementation. 
   Phase reads: 
       -P                Force phasing of reads even if a HP tag is present.
       -p   INT            Range of flanking sequences which is used in the phasing step. DEFAULT: 15000 bps. 
       -M   INT            Minimum total coverage to allow a SNV to be called (6). 
       -a   INT            Minimum alt coverage to allow a SNV to be called (3). 
   Downloading motifs:
Most up-to-date motif set, please visit: https://zenodo.org/records/16286509 
   Others: 
       -L   INT          Maximum length locus to compute annotation for (10000)
       -p   INT          Phase flank- how many bases on each side of a VNTR to collect SNVs to phase (default=15000)
       -t   INT          Number of threads, DEFAULT: 1. 
       --debug           Print out debug information. 
       -h                Print out help message.
```


## vamos_somatic

### Tool Description
Vamos is a tool for VNTR analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/vamos:3.0.6--h7f5d12c_0
- **Homepage**: https://github.com/ChaissonLab/vamos
- **Package**: https://anaconda.org/channels/bioconda/packages/vamos/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vamos [subcommand] [options] [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] 
Version: 3.0.4
subcommand:
vamos --contig [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] 
vamos --read [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] [-p phase_flank] 
vamos --somatic [-b in.bam] [-r vntrs_region_motifs.bed] [-o output.vcf] [-s sample_name] [-t threads] [-p phase_flank] 
vamos -m [verison of efficient motif set]

   Input: 
       -b   FILE         Input indexed bam file. 
       -r   FILE         File containing region coordinate and motifs of each VNTR locus. 
                         The file format: columns `chrom,start,end,motifs` are tab-delimited. 
                         Column `motifs` is a comma-separated (no spaces) list of motifs for this VNTR. 
       -R   FILE         Refine start and end pos by realigning to reference FILE (same as mapped reference).
       -s   CHAR         Sample name. 
       -Z                Treat input regions as zero based (e.g. TRExplorer catalog and standard BED files). 
   Input handling:
       -C   INT          Maximum coverage to call a tandem repeat.
   Output: 
       -o   FILE         Output vcf file. 
       -S                Output assembly/read consensus sequence in each call.
       -E                Output reconstructed TR sequence from decomposition in each call.
   Dynamic Programming: 
       -d   DOUBLE       Penalty of indel in dynamic programming (double) DEFAULT: 1.0. 
       -c   DOUBLE       Penalty of mismatch in dynamic programming (double) DEFAULT: 1.0. 
       --naive           Specify the naive version of code to do the annotation, DEFAULT: faster implementation. 
   Phase reads: 
       -P                Force phasing of reads even if a HP tag is present.
       -p   INT            Range of flanking sequences which is used in the phasing step. DEFAULT: 15000 bps. 
       -M   INT            Minimum total coverage to allow a SNV to be called (6). 
       -a   INT            Minimum alt coverage to allow a SNV to be called (3). 
   Downloading motifs:
Most up-to-date motif set, please visit: https://zenodo.org/records/16286509 
   Others: 
       -L   INT          Maximum length locus to compute annotation for (10000)
       -p   INT          Phase flank- how many bases on each side of a VNTR to collect SNVs to phase (default=15000)
       -t   INT          Number of threads, DEFAULT: 1. 
       --debug           Print out debug information. 
       -h                Print out help message.
```

