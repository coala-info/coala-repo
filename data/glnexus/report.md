# glnexus CWL Generation Report

## glnexus_glnexus_cli

### Tool Description
Merge and joint-call input gVCF files, emitting multi-sample BCF on standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/glnexus:1.4.1--h17e8430_5
- **Homepage**: https://github.com/dnanexus-rnd/GLnexus
- **Package**: https://anaconda.org/channels/bioconda/packages/glnexus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/glnexus/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dnanexus-rnd/GLnexus
- **Stars**: N/A
### Original Help Text
```text
Usage: glnexus_cli [options] /vcf/file/1 .. /vcf/file/N
Merge and joint-call input gVCF files, emitting multi-sample BCF on standard output.

Options:
  --dir DIR, -d DIR              scratch directory path (mustn't already exist; default: ./GLnexus.DB)
  --config X, -c X               configuration preset name or .yml filename (default: gatk)
  --bed FILE, -b FILE            three-column BED file with ranges to analyze (if neither --range nor --bed: use full length of all contigs)
  --list, -l                     expect given files to contain lists of gVCF filenames, one per line

  --more-PL, -P                  include PL from reference bands and other cases omitted by default
  --squeeze, -S                  reduce pVCF size by suppressing detail in cells derived from reference bands
  --trim-uncalled-alleles, -a    remove alleles with no output GT calls in postprocessing

  --mem-gbytes X, -m X           memory budget, in gbytes (default: most of system memory)
  --threads X, -t X              thread budget (default: all hardware threads)

  --help, -h                     print this help message

Configuration presets:
            Name          CRC32C	Description
            gatk      1926883223	Joint-call GATK-style gVCFs
 gatk_unfiltered      4039280095	Merge GATK-style gVCFs with no QC filters or genotype revision
          xAtlas      1991666133	Joint-call xAtlas gVCFs
xAtlas_unfiltered       221875257	Merge xAtlas gVCFs with no QC filters or genotype revision
          weCall      2898360729	Joint-call weCall gVCFs
weCall_unfiltered      4254257210	Merge weCall gVCFs with no filtering or genotype revision
     DeepVariant      2932316105	Joint call DeepVariant whole genome sequencing gVCFs
  DeepVariantWGS      2932316105	Joint call DeepVariant whole genome sequencing gVCFs
  DeepVariantWES      1063427682	Joint call DeepVariant whole exome sequencing gVCFs
DeepVariantWES_MED_DP      2412618877	Joint call DeepVariant whole exome sequencing gVCFs, populating 0/0 DP from MED_DP instead of MIN_DP
DeepVariant_unfiltered      3285998180	Merge DeepVariant gVCFs with no QC filters or genotype revision
        Strelka2       395868656	[EXPERIMENTAL] Merge Strelka2 gVCFs with no QC filters or genotype revision
```

