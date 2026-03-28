# wakhan CWL Generation Report

## wakhan_all

### Tool Description
Wakhan plots coverage and copy number profiles from a bam and phased VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/wakhan:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/KolmogorovLab/Wakhan
- **Package**: https://anaconda.org/channels/bioconda/packages/wakhan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wakhan/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/KolmogorovLab/Wakhan
- **Stars**: N/A
### Original Help Text
```text
usage: wakhan [-h] --target-bam path [path ...] --reference path
              --out-dir-plots path [--normal-phased-vcf path]
              [--tumor-phased-vcf path] [--breakpoints path] [-t int]
              [--use-sv-haplotypes] [--purity-range PURITY_RANGE]
              [--ploidy-range PLOIDY_RANGE] [--centromere-bed path]
              [--cancer-genes path] [--reference-name REFERENCE_NAME]
              [--genome-name GENOME_NAME] [--contigs CONTIGS]
              [--cut-threshold int] [--pdf-enable] [--bin-size int]
              [--min-phaseblock int] [--bin-size-snps int]
              [--hets-ratio float] [--confidence-subclonal-score float]
              [--breakpoints-min-length int] [--without-phasing]
              [--cpd-internal-segments] [--change-point-detection-for-cna]
              {all,cna,hapcorrect}

Wakhan plots coverage and copy number profiles from a bam and phased VCF files

positional arguments:
  {all,cna,hapcorrect}  Run full pipeline, cna or hapcorrect modes

options:
  -h, --help            show this help message and exit
  --target-bam path [path ...]
                        path to tumor bam file (must be indexed) (default:
                        None)
  --reference path      path to reference (default: None)
  --out-dir-plots path  Output directory (default: None)
  --normal-phased-vcf path
                        Path to normal phased vcf (tumor-normal mode)
                        (default: None)
  --tumor-phased-vcf path
                        Path to tumor phased VCF (tumor-only mode) (default:
                        None)
  --breakpoints path    Path to breakpoints/SVs VCF file (default: None)
  -t int, --threads int
                        number of parallel threads (default: 1)
  --use-sv-haplotypes   Enable using phased SVs/breakpoints (default: False)
  --purity-range PURITY_RANGE
                        Target tumor purity range (default: 0.25-1.0)
  --ploidy-range PLOIDY_RANGE
                        Target tumor ploidy range (default: 1.0-5.5)
  --centromere-bed path
                        Path to custom centromere annotations BED file
                        (default: None)
  --cancer-genes path   Path to custom Genes TSV file (e.g. COSMIC) (default:
                        None)
  --reference-name REFERENCE_NAME
                        Reference name (default: grch38)
  --genome-name GENOME_NAME
                        Genome sample/cell line name to be displayed on plots
                        (default: Sample)
  --contigs CONTIGS     List of contigs to be included in the plots, default
                        chr1-22,chrX [e.g., chr1-22,X,Y], Must be consistent
                        with chr/nochr notation in input files (default:
                        chr1-22,chrX)
  --cut-threshold int, --cut_threshold int
                        Plotting threshold for coverage (default: 100)
  --pdf-enable          Enabling PDF output coverage plots (default: False)
  --bin-size int, --bin_size int
                        bin size for coverage calculation (default: 50000)
  --min-phaseblock int, --min_phaseblock int
                        minimum phaseblock length for CNA estimation (default:
                        300000)
  --bin-size-snps int, --bin_size_snps int
                        bin size for LOH detection (default: 200000)
  --hets-ratio float, --hets_ratio float
                        Hetrozygous SNPs ratio threshold for LOH detection
                        (default: 0.15)
  --confidence-subclonal-score float
                        user input p-value to detect if a segment is
                        subclonal/off to integer copynumber (default: 0.6)
  --breakpoints-min-length int
                        SV minimum length to include (default: 10000)
  --without-phasing     Enabling coverage and copynumbers without phasing in
                        plots (default: False)
  --cpd-internal-segments
                        change point detection algo for more precise segments
                        after breakpoint/cpd segments (default: False)
  --change-point-detection-for-cna
                        use change point detection algo for more cna
                        segmentation instead of breakpoints (default: False)
```


## wakhan_cna

### Tool Description
Wakhan plots coverage and copy number profiles from a bam and phased VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/wakhan:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/KolmogorovLab/Wakhan
- **Package**: https://anaconda.org/channels/bioconda/packages/wakhan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wakhan [-h] --target-bam path [path ...] --reference path
              --out-dir-plots path [--normal-phased-vcf path]
              [--tumor-phased-vcf path] [--breakpoints path] [-t int]
              [--use-sv-haplotypes] [--purity-range PURITY_RANGE]
              [--ploidy-range PLOIDY_RANGE] [--centromere-bed path]
              [--cancer-genes path] [--reference-name REFERENCE_NAME]
              [--genome-name GENOME_NAME] [--contigs CONTIGS]
              [--cut-threshold int] [--pdf-enable] [--bin-size int]
              [--min-phaseblock int] [--bin-size-snps int]
              [--hets-ratio float] [--confidence-subclonal-score float]
              [--breakpoints-min-length int] [--without-phasing]
              [--cpd-internal-segments] [--change-point-detection-for-cna]
              {all,cna,hapcorrect}

Wakhan plots coverage and copy number profiles from a bam and phased VCF files

positional arguments:
  {all,cna,hapcorrect}  Run full pipeline, cna or hapcorrect modes

options:
  -h, --help            show this help message and exit
  --target-bam path [path ...]
                        path to tumor bam file (must be indexed) (default:
                        None)
  --reference path      path to reference (default: None)
  --out-dir-plots path  Output directory (default: None)
  --normal-phased-vcf path
                        Path to normal phased vcf (tumor-normal mode)
                        (default: None)
  --tumor-phased-vcf path
                        Path to tumor phased VCF (tumor-only mode) (default:
                        None)
  --breakpoints path    Path to breakpoints/SVs VCF file (default: None)
  -t int, --threads int
                        number of parallel threads (default: 1)
  --use-sv-haplotypes   Enable using phased SVs/breakpoints (default: False)
  --purity-range PURITY_RANGE
                        Target tumor purity range (default: 0.25-1.0)
  --ploidy-range PLOIDY_RANGE
                        Target tumor ploidy range (default: 1.0-5.5)
  --centromere-bed path
                        Path to custom centromere annotations BED file
                        (default: None)
  --cancer-genes path   Path to custom Genes TSV file (e.g. COSMIC) (default:
                        None)
  --reference-name REFERENCE_NAME
                        Reference name (default: grch38)
  --genome-name GENOME_NAME
                        Genome sample/cell line name to be displayed on plots
                        (default: Sample)
  --contigs CONTIGS     List of contigs to be included in the plots, default
                        chr1-22,chrX [e.g., chr1-22,X,Y], Must be consistent
                        with chr/nochr notation in input files (default:
                        chr1-22,chrX)
  --cut-threshold int, --cut_threshold int
                        Plotting threshold for coverage (default: 100)
  --pdf-enable          Enabling PDF output coverage plots (default: False)
  --bin-size int, --bin_size int
                        bin size for coverage calculation (default: 50000)
  --min-phaseblock int, --min_phaseblock int
                        minimum phaseblock length for CNA estimation (default:
                        300000)
  --bin-size-snps int, --bin_size_snps int
                        bin size for LOH detection (default: 200000)
  --hets-ratio float, --hets_ratio float
                        Hetrozygous SNPs ratio threshold for LOH detection
                        (default: 0.15)
  --confidence-subclonal-score float
                        user input p-value to detect if a segment is
                        subclonal/off to integer copynumber (default: 0.6)
  --breakpoints-min-length int
                        SV minimum length to include (default: 10000)
  --without-phasing     Enabling coverage and copynumbers without phasing in
                        plots (default: False)
  --cpd-internal-segments
                        change point detection algo for more precise segments
                        after breakpoint/cpd segments (default: False)
  --change-point-detection-for-cna
                        use change point detection algo for more cna
                        segmentation instead of breakpoints (default: False)
```


## wakhan_hapcorrect

### Tool Description
Wakhan plots coverage and copy number profiles from a bam and phased VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/wakhan:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/KolmogorovLab/Wakhan
- **Package**: https://anaconda.org/channels/bioconda/packages/wakhan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wakhan [-h] --target-bam path [path ...] --reference path
              --out-dir-plots path [--normal-phased-vcf path]
              [--tumor-phased-vcf path] [--breakpoints path] [-t int]
              [--use-sv-haplotypes] [--purity-range PURITY_RANGE]
              [--ploidy-range PLOIDY_RANGE] [--centromere-bed path]
              [--cancer-genes path] [--reference-name REFERENCE_NAME]
              [--genome-name GENOME_NAME] [--contigs CONTIGS]
              [--cut-threshold int] [--pdf-enable] [--bin-size int]
              [--min-phaseblock int] [--bin-size-snps int]
              [--hets-ratio float] [--confidence-subclonal-score float]
              [--breakpoints-min-length int] [--without-phasing]
              [--cpd-internal-segments] [--change-point-detection-for-cna]
              {all,cna,hapcorrect}

Wakhan plots coverage and copy number profiles from a bam and phased VCF files

positional arguments:
  {all,cna,hapcorrect}  Run full pipeline, cna or hapcorrect modes

options:
  -h, --help            show this help message and exit
  --target-bam path [path ...]
                        path to tumor bam file (must be indexed) (default:
                        None)
  --reference path      path to reference (default: None)
  --out-dir-plots path  Output directory (default: None)
  --normal-phased-vcf path
                        Path to normal phased vcf (tumor-normal mode)
                        (default: None)
  --tumor-phased-vcf path
                        Path to tumor phased VCF (tumor-only mode) (default:
                        None)
  --breakpoints path    Path to breakpoints/SVs VCF file (default: None)
  -t int, --threads int
                        number of parallel threads (default: 1)
  --use-sv-haplotypes   Enable using phased SVs/breakpoints (default: False)
  --purity-range PURITY_RANGE
                        Target tumor purity range (default: 0.25-1.0)
  --ploidy-range PLOIDY_RANGE
                        Target tumor ploidy range (default: 1.0-5.5)
  --centromere-bed path
                        Path to custom centromere annotations BED file
                        (default: None)
  --cancer-genes path   Path to custom Genes TSV file (e.g. COSMIC) (default:
                        None)
  --reference-name REFERENCE_NAME
                        Reference name (default: grch38)
  --genome-name GENOME_NAME
                        Genome sample/cell line name to be displayed on plots
                        (default: Sample)
  --contigs CONTIGS     List of contigs to be included in the plots, default
                        chr1-22,chrX [e.g., chr1-22,X,Y], Must be consistent
                        with chr/nochr notation in input files (default:
                        chr1-22,chrX)
  --cut-threshold int, --cut_threshold int
                        Plotting threshold for coverage (default: 100)
  --pdf-enable          Enabling PDF output coverage plots (default: False)
  --bin-size int, --bin_size int
                        bin size for coverage calculation (default: 50000)
  --min-phaseblock int, --min_phaseblock int
                        minimum phaseblock length for CNA estimation (default:
                        300000)
  --bin-size-snps int, --bin_size_snps int
                        bin size for LOH detection (default: 200000)
  --hets-ratio float, --hets_ratio float
                        Hetrozygous SNPs ratio threshold for LOH detection
                        (default: 0.15)
  --confidence-subclonal-score float
                        user input p-value to detect if a segment is
                        subclonal/off to integer copynumber (default: 0.6)
  --breakpoints-min-length int
                        SV minimum length to include (default: 10000)
  --without-phasing     Enabling coverage and copynumbers without phasing in
                        plots (default: False)
  --cpd-internal-segments
                        change point detection algo for more precise segments
                        after breakpoint/cpd segments (default: False)
  --change-point-detection-for-cna
                        use change point detection algo for more cna
                        segmentation instead of breakpoints (default: False)
```


## Metadata
- **Skill**: generated
