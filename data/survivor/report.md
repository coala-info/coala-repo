# survivor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| survivor_SURVIVOR_bedpetovcf | PASS | real SK-N-AS nanopore SV calls from Severus and Sniffles (nf-core); BEDPE from vcftobed converted back to 60 VCF records |
| survivor_SURVIVOR_bedtovcf | PASS | two hand-written bed intervals converted to DEL records with correct END and SVLEN |
| survivor_SURVIVOR_bincov | Failed | tool bug: the last low-coverage region is never printed, so the output is silently incomplete; the other regions from the real COLO829 chr22 BAM slice are correct. |
| survivor_SURVIVOR_compMUMMer | Failed | tool bug: it reopens the VCF by the sample name in the header, so any VCF whose sample name is not its own path gives no output file |
| survivor_SURVIVOR_convertAssemblytics | PASS | real Assemblytics Drosophila output; 290 of 293 variants kept at minimum size 50, matching a count made from the bed file |
| survivor_SURVIVOR_eval | PASS | synthetic data: SURVIVOR simSV truth VCF against its own bed; Overall line 7 simulated, 1 DEL, 2 DUP, 4 INV found, none missed |
| survivor_SURVIVOR_filter | PASS | real SK-N-AS nanopore SV calls from Severus and Sniffles (nf-core); region and size filters removed calls (60 to 56 by region, 43 with min size 50) |
| survivor_SURVIVOR_genComp | PASS | real SK-N-AS nanopore SV calls from Severus and Sniffles (nf-core); 2x2 pairwise overlap matrix written |
| survivor_SURVIVOR_hapcuttovcf | PASS | real data: HapCUT2 run on nf-core NA12878 chr22 reads and GIAB variants; all 21 phased variants converted, same relative phase as the HapCUT2 phased VCF |
| survivor_SURVIVOR_merge | PASS | real SK-N-AS nanopore SV calls from Severus and Sniffles (nf-core); 66 calls merged to 60, 5 supported by both callers |
| survivor_SURVIVOR_scanreads | PASS | real COLO829 nanopore chr22 slice (nf-core) with MD tags added by samtools calmd; error profile from 163 reads |
| survivor_SURVIVOR_simSV | PASS | synthetic data: SVs simulated on a 180 kb chr22 slice (nf-core); fasta, bed and vcf written (7 SVs) |
| survivor_SURVIVOR_simreads | PASS | synthetic data: reads simulated on a 180 kb chr22 slice from the COLO829 error profile; 14 reads at coverage 2 |
| survivor_SURVIVOR_smaptovcf | PASS | real Bionano smap (E. coli, 10 SVs); all 10 converted with correct positions and types; beta tool writes no VCF header and gives meaningless SVLEN for translocations |
| survivor_SURVIVOR_stats | PASS | real SK-N-AS nanopore SV calls from Severus and Sniffles (nf-core); merged set summarised (11 DEL, 7 INS, 42 TRA) |
| survivor_SURVIVOR_vcftobed | PASS | real SK-N-AS nanopore SV calls from Severus and Sniffles (nf-core); 60 BEDPE rows written |

## survivor_SURVIVOR_merge

### Tool Description
SURVIVOR merge

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
File with VCF names and paths
max distance between breakpoints (0-1 percent of length, 1- number of bp) 
Minimum number of supporting caller
Take the type into account (1==yes, else no)
Take the strands of SVs into account (1==yes, else no)
Estimate distance based on the size of SV (1==yes, else no).
Minimum size of SVs to be taken into account.
Output VCF filename
```

## survivor_SURVIVOR_stats

### Tool Description
SURVIVOR stats

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
vcf file
Min SV size (disable: -1)
Max SV size (disable: -1)
Min number read support (disable: -1)
output summary file
```

## survivor_SURVIVOR_filter

### Tool Description
SURVIVOR filter

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
VCF file to filter
BED file with regions to ignore (NA to disable)
Min SV size (-1 to disable)
Max SV size (-1 to disable)
Min allele frequency (0-1)
Min number of reads support: RE flag (-1 to disable)
Output vcf file
```

## survivor_SURVIVOR_eval

### Tool Description
SURVIVOR eval

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
VCF file
BED file from simulations
Max allowed distance to simulated
Output eval file
```

## survivor_SURVIVOR_genComp

### Tool Description
SURVIVOR genComp

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
Merged Vcf file
Normalize output (1==yes, else no)
Output: pariwise overlap matrix
```

## survivor_SURVIVOR_vcftobed

### Tool Description
SURVIVOR vcftobed

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
vcf file
min size
max size
output file
```

## survivor_SURVIVOR_bedtovcf

### Tool Description
SURVIVOR bedtovcf

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
Bed file
Type
Output vcf file
```

## survivor_SURVIVOR_bedpetovcf

### Tool Description
SURVIVOR bedpetovcf

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
Bedpe file
Output: vcf file
```

## survivor_SURVIVOR_scanreads

### Tool Description
SURVIVOR scanreads

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
Required parameters:
How to run: samtools view your_file.bam | ./SURVIVOR scanreads 1000 error.txt
1: Min read length
2: output
```

## survivor_SURVIVOR_bincov

### Tool Description
SURVIVOR bincov

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
cov MQ0 file
border size 
min coverage to be considerd
```

## survivor_SURVIVOR_simSV

### Tool Description
SURVIVOR simSV

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
No parameters provided:
To generate a example parameter file call the option again and specify the file name:

To simulate SV:
1: Reference fasta file
2: Parameter file
3: SNP mutations frequency (0-1)
4: 0= simulated reads; 1= real reads 
5: output prefix
```

## survivor_SURVIVOR_simreads

### Tool Description
SURVIVOR simreads

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
No parameters provided:
1: Reference fasta file
2: error profile file (see scan)
3: Coverage
4: output prefix
```

## survivor_SURVIVOR_compMUMMer

### Tool Description
Annotates a VCF file with the breakpoints found with MUMMer (Show-diff).

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
SVs VCF file
Output of MUMMer Show-diff
Allowed distance (e.g. 100bp)
Output: annotated vcf file
```

## survivor_SURVIVOR_convertAssemblytics

### Tool Description
Converts Assemblytics to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
Bed file from Assemblytics
Min size to keep
Output vcf file
```

## survivor_SURVIVOR_hapcuttovcf

### Tool Description
Converts the Hapcut2 final file to a VCF file using the original SNP file provided to Hapcut2.

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
Original SNP file
Hapcut2 final file
Output: vcf file
```

## survivor_SURVIVOR_smaptovcf

### Tool Description
Converts the smap file to a VCF file (beta version).

### Metadata
- **Docker Image**: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
- **Homepage**: https://github.com/fritzsedlazeck/SURVIVOR
- **Package**: https://anaconda.org/channels/bioconda/packages/survivor/overview
- **Validation**: PASS

### Original Help Text
```text
*.smap file
output file
```

