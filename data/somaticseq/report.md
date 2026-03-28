# somaticseq CWL Generation Report

## somaticseq_paired

### Tool Description
Run somatic variant callers in paired mode

### Metadata
- **Docker Image**: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
- **Homepage**: http://bioinform.github.io/somaticseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/somaticseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/somaticseq/overview
- **Total Downloads**: 44.3K
- **Last updated**: 2025-06-09
- **GitHub**: https://github.com/bioinform/somaticseq
- **Stars**: N/A
### Original Help Text
```text
usage: somaticseq paired [-h] -tbam TUMOR_BAM_FILE -nbam NORMAL_BAM_FILE
                         [-tumorSM TUMOR_SAMPLE] [-normalSM NORMAL_SAMPLE]
                         [-mutect MUTECT_VCF] [-indelocator INDELOCATOR_VCF]
                         [-mutect2 MUTECT2_VCF] [-varscansnv VARSCAN_SNV]
                         [-varscanindel VARSCAN_INDEL] [-jsm JSM_VCF]
                         [-sniper SOMATICSNIPER_VCF] [-vardict VARDICT_VCF]
                         [-muse MUSE_VCF] [-lofreqsnv LOFREQ_SNV]
                         [-lofreqindel LOFREQ_INDEL] [-scalpel SCALPEL_VCF]
                         [-strelkasnv STRELKA_SNV]
                         [-strelkaindel STRELKA_INDEL] [-tnscope TNSCOPE_VCF]
                         [-platypus PLATYPUS_VCF]
                         [-arbsnv [ARBITRARY_SNVS ...]]
                         [-arbindel [ARBITRARY_INDELS ...]]

options:
  -h, --help            show this help message and exit
  -tbam TUMOR_BAM_FILE, --tumor-bam-file TUMOR_BAM_FILE
                        Tumor BAM File
  -nbam NORMAL_BAM_FILE, --normal-bam-file NORMAL_BAM_FILE
                        Normal BAM File
  -tumorSM TUMOR_SAMPLE, --tumor-sample TUMOR_SAMPLE
                        Tumor Name
  -normalSM NORMAL_SAMPLE, --normal-sample NORMAL_SAMPLE
                        Normal Name
  -mutect MUTECT_VCF, --mutect-vcf MUTECT_VCF
                        MuTect VCF
  -indelocator INDELOCATOR_VCF, --indelocator-vcf INDELOCATOR_VCF
                        Indelocator VCF
  -mutect2 MUTECT2_VCF, --mutect2-vcf MUTECT2_VCF
                        MuTect2 VCF
  -varscansnv VARSCAN_SNV, --varscan-snv VARSCAN_SNV
                        VarScan2 VCF
  -varscanindel VARSCAN_INDEL, --varscan-indel VARSCAN_INDEL
                        VarScan2 VCF
  -jsm JSM_VCF, --jsm-vcf JSM_VCF
                        JointSNVMix2 VCF
  -sniper SOMATICSNIPER_VCF, --somaticsniper-vcf SOMATICSNIPER_VCF
                        SomaticSniper VCF
  -vardict VARDICT_VCF, --vardict-vcf VARDICT_VCF
                        VarDict VCF
  -muse MUSE_VCF, --muse-vcf MUSE_VCF
                        MuSE VCF
  -lofreqsnv LOFREQ_SNV, --lofreq-snv LOFREQ_SNV
                        LoFreq VCF
  -lofreqindel LOFREQ_INDEL, --lofreq-indel LOFREQ_INDEL
                        LoFreq VCF
  -scalpel SCALPEL_VCF, --scalpel-vcf SCALPEL_VCF
                        Scalpel VCF
  -strelkasnv STRELKA_SNV, --strelka-snv STRELKA_SNV
                        Strelka VCF
  -strelkaindel STRELKA_INDEL, --strelka-indel STRELKA_INDEL
                        Strelka VCF
  -tnscope TNSCOPE_VCF, --tnscope-vcf TNSCOPE_VCF
                        TNscope VCF
  -platypus PLATYPUS_VCF, --platypus-vcf PLATYPUS_VCF
                        Platypus VCF
  -arbsnv [ARBITRARY_SNVS ...], --arbitrary-snvs [ARBITRARY_SNVS ...]
                        Additional SNV VCFs
  -arbindel [ARBITRARY_INDELS ...], --arbitrary-indels [ARBITRARY_INDELS ...]
                        Additional INDEL VCFs
```


## somaticseq_single

### Tool Description
SomaticSeq single mode

### Metadata
- **Docker Image**: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
- **Homepage**: http://bioinform.github.io/somaticseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/somaticseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: somaticseq single [-h] -bam BAM_FILE [-SM SAMPLE_NAME]
                         [-mutect MUTECT_VCF] [-mutect2 MUTECT2_VCF]
                         [-varscan VARSCAN_VCF] [-vardict VARDICT_VCF]
                         [-lofreq LOFREQ_VCF] [-scalpel SCALPEL_VCF]
                         [-strelka STRELKA_VCF] [-arbsnv [ARBITRARY_SNVS ...]]
                         [-arbindel [ARBITRARY_INDELS ...]]

options:
  -h, --help            show this help message and exit
  -bam BAM_FILE, --bam-file BAM_FILE
                        BAM File
  -SM SAMPLE_NAME, --sample-name SAMPLE_NAME
                        Sample Name
  -mutect MUTECT_VCF, --mutect-vcf MUTECT_VCF
                        MuTect VCF
  -mutect2 MUTECT2_VCF, --mutect2-vcf MUTECT2_VCF
                        MuTect2 VCF
  -varscan VARSCAN_VCF, --varscan-vcf VARSCAN_VCF
                        VarScan2 VCF
  -vardict VARDICT_VCF, --vardict-vcf VARDICT_VCF
                        VarDict VCF
  -lofreq LOFREQ_VCF, --lofreq-vcf LOFREQ_VCF
                        LoFreq VCF
  -scalpel SCALPEL_VCF, --scalpel-vcf SCALPEL_VCF
                        Scalpel VCF
  -strelka STRELKA_VCF, --strelka-vcf STRELKA_VCF
                        Strelka VCF
  -arbsnv [ARBITRARY_SNVS ...], --arbitrary-snvs [ARBITRARY_SNVS ...]
                        Additional SNV VCFs
  -arbindel [ARBITRARY_INDELS ...], --arbitrary-indels [ARBITRARY_INDELS ...]
                        Additional INDEL VCFs
```


## Metadata
- **Skill**: generated
