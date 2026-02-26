# bactopia-variants CWL Generation Report

## bactopia-variants

### Tool Description
This is snippy 4.6.0

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia-variants:1.0.2--hdfd78af_0
- **Homepage**: https://bactopia.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia-variants/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia-variants/overview
- **Total Downloads**: 4.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia-variants
- **Stars**: N/A
### Original Help Text
```text
[02:44:42] This is snippy 4.6.0
[02:44:42] Written by Torsten Seemann
[02:44:42] Obtained from https://github.com/tseemann/snippy
[02:44:42] Detected operating system: linux
[02:44:42] Enabling bundled linux tools.
[02:44:42] Found bwa - /usr/local/bin/bwa
[02:44:42] Found bcftools - /usr/local/bin/bcftools
[02:44:42] Found samtools - /usr/local/bin/samtools
[02:44:42] Found java - /usr/local/bin/java
[02:44:42] Found snpEff - /usr/local/bin/snpEff
[02:44:42] Found samclip - /usr/local/bin/samclip
[02:44:42] Found seqtk - /usr/local/bin/seqtk
[02:44:42] Found parallel - /usr/local/bin/parallel
[02:44:42] Found freebayes - /usr/local/bin/freebayes
[02:44:42] Found freebayes-parallel - /usr/local/bin/freebayes-parallel
[02:44:42] Found fasta_generate_regions.py - /usr/local/bin/fasta_generate_regions.py
[02:44:42] Found vcfstreamsort - /usr/local/bin/vcfstreamsort
[02:44:42] Found vcfuniq - /usr/local/bin/vcfuniq
[02:44:42] Found vcffirstheader - /usr/local/bin/vcffirstheader
[02:44:42] Found gzip - /usr/bin/gzip
[02:44:42] Found vt - /usr/local/bin/vt
[02:44:42] Found snippy-vcf_to_tab - /usr/local/bin/snippy-vcf_to_tab
[02:44:42] Found snippy-vcf_report - /usr/local/bin/snippy-vcf_report
[02:44:42] Checking version: samtools --version is >= 1.7 - ok, have 1.19
[02:44:42] Checking version: bcftools --version is >= 1.7 - ok, have 1.14
[02:44:42] Checking version: freebayes --version is >= 1.1 - ok, have 1.3.6
[02:44:44] Checking version: snpEff -version is >= 4.3 - ok, have 4.5
[02:44:44] Checking version: bwa is >= 0.7.12 - ok, have 0.7.17
[02:44:44] Please supply a reference FASTA/GBK/EMBL file with --reference
/usr/local/bin/bactopia-variants: line 18: .args: command not found
/usr/local/bin/bactopia-variants: line 19: --cpus: command not found
/usr/local/bin/bactopia-variants: line 20: --outdir: command not found
/usr/local/bin/bactopia-variants: line 21: --reference: command not found
/usr/local/bin/bactopia-variants: line 22: --prefix: command not found
usage: vcf-annotator.py [-h] [--output STRING] [--version]
                        VCF_FILE GENBANK_FILE
vcf-annotator.py: error: the following arguments are required: GENBANK_FILE
grep: /.vcf: No such file or directory
[E::hts_open_format_impl] Failed to open file /.bam
Failed to open BAM file /.bam
usage: mask-consensus [-h] [--mincov INT] [--version]
                      SAMPLE REFERENCE SUBS_FASTA SUBS_VCF COVERAGE
mask-consensus: error: the following arguments are required: REFERENCE, SUBS_FASTA, SUBS_VCF, COVERAGE
/usr/local/bin/bactopia-variants: line 36: \: command not found
/usr/local/bin/bactopia-variants: line 37: \: command not found
/usr/local/bin/bactopia-variants: line 38: /.consensus.subs.fa: No such file or directory
/usr/local/bin/bactopia-variants: line 39: /.subs.vcf: No such file or directory
/usr/local/bin/bactopia-variants: line 40: /.coverage.txt: Permission denied
/usr/local/bin/bactopia-variants: line 41: ${params.mincov}: bad substitution
/usr/local/bin/bactopia-variants: line 45: ${params.skip_compression}: bad substitution
mv: cannot move '/' to 'results/': Device or resource busy
mv: cannot stat 'results/*.log': No such file or directory
```

