# varifier CWL Generation Report

## varifier_make_truth_vcf

### Tool Description
Make truth VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/varifier:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/iqbal-lab-org/varifier
- **Package**: https://anaconda.org/channels/bioconda/packages/varifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/varifier/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/iqbal-lab-org/varifier
- **Stars**: N/A
### Original Help Text
```text
usage: varifier make_truth_vcf [options] <truth_fasta> <ref_fasta> <outdir>

Make truth VCF file

positional arguments:
  truth_fasta           FASTA file of truth genome
  ref_fasta             FASTA file of reference genome
  outdir                Name of output directory

options:
  -h, --help            show this help message and exit
  --debug               More verbose logging, and less file cleaning
  --flank_length INT    Length of sequence to add either side of variant when
                        making probe sequences [100]
  --max_recall_ref_len INT
                        Do not include variants where REF length is more than
                        this number. Default is no limit
  --split_ref           When using MUMmer, split the ref genome into one file
                        per sequence, and run MUMmer on each split.
                        Experimental - should improve run time for big genomes
  --no_maxmatch         When using nucmer to get expected calls for recall, do
                        not use the --maxmatch option. May reduce sensitivity
                        to finding all variants
  --global_align        Only use this with small genomes (ie virus) that have
                        one sequence each, in the same orientation. Instead of
                        using minimap2/nucmer to find variants, do a global
                        alignment for greater accuracy
  --global_align_min_coord INT
                        Only used if also using --global_align. Do not output
                        variants where the REF allele starts before the given
                        (1-based) coordinate. When running vcf_eval, only
                        applies to recall, not precision [1]
  --global_align_max_coord INT
                        Only used if also using --global_align. Do not output
                        variants where the REF allele ends after the given
                        (1-based) coordinate. When running vcf_eval, only
                        applies to recall, not precision [infinity]
  --use_non_acgt        Only used if also using --global_align. When writing
                        initial VCF file (before removing FPs using probe
                        mapping), include records that have non-ACGT
                        characters in their alleles
  --truth_mask FILENAME
                        BED file of truth genome regions to mask. Any variants
                        in the VCF matching to the mask are flagged and will
                        not count towards precision or recall if the output
                        VCF is used with vcf_eval
  --cpus INT            Number of CPUs to use when running nucmer and minimap2
                        [1]
  --sanitise_truth_gaps
                        Only used if also using --global_align. Use the global
                        alignment to change gap lengths in the truth fasta so
                        that gaps are same length as missing sequence from the
                        reference
```


## varifier_vcf_eval

### Tool Description
Evaluate VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/varifier:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/iqbal-lab-org/varifier
- **Package**: https://anaconda.org/channels/bioconda/packages/varifier/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varifier vcf_eval [options] <truth_fasta> <vcf_fasta> <vcf_file> <outdir>

Evaluate VCF file

positional arguments:
  truth_fasta           FASTA file of truth genome
  vcf_fasta             FASTA file corresponding to vcf_file
  vcf_in                VCF file to evaluate
  outdir                Name of output directory

options:
  -h, --help            show this help message and exit
  --debug               More verbose logging, and less file cleaning
  --flank_length INT    Length of sequence to add either side of variant when
                        making probe sequences [100]
  --max_recall_ref_len INT
                        Do not include variants where REF length is more than
                        this number. Default is no limit
  --split_ref           When using MUMmer, split the ref genome into one file
                        per sequence, and run MUMmer on each split.
                        Experimental - should improve run time for big genomes
  --no_maxmatch         When using nucmer to get expected calls for recall, do
                        not use the --maxmatch option. May reduce sensitivity
                        to finding all variants
  --global_align        Only use this with small genomes (ie virus) that have
                        one sequence each, in the same orientation. Instead of
                        using minimap2/nucmer to find variants, do a global
                        alignment for greater accuracy
  --global_align_min_coord INT
                        Only used if also using --global_align. Do not output
                        variants where the REF allele starts before the given
                        (1-based) coordinate. When running vcf_eval, only
                        applies to recall, not precision [1]
  --global_align_max_coord INT
                        Only used if also using --global_align. Do not output
                        variants where the REF allele ends after the given
                        (1-based) coordinate. When running vcf_eval, only
                        applies to recall, not precision [infinity]
  --use_non_acgt        Only used if also using --global_align. When writing
                        initial VCF file (before removing FPs using probe
                        mapping), include records that have non-ACGT
                        characters in their alleles
  --force               Replace outdir if it already exists
  --filter_pass FILTER1[,FILTER2[,...]]
                        Defines how to handle FILTER column of input VCF file.
                        Comma-separated list of filter names. A VCF line is
                        kept if any of its FILTER entries are in the provided
                        list. Put '.' in the list to keep records where the
                        filter column is '.'. Default behaviour is to ignore
                        the filter column and use all records
  --ref_mask FILENAME   BED file of ref regions to mask. Any variants in the
                        VCF overlapping the mask are removed at the start of
                        the pipeline
  --truth_mask FILENAME
                        BED file of truth genome regions to mask. Any variants
                        in the VCF matching to the mask are flagged and do not
                        count towards precision or recall
  --truth_vcf FILENAME  VCF file of variant calls between vcf_fasta and
                        truth_fasta, where reference of this VCF file is
                        truth_fasta. If provided, used to calculate recall
  --use_ref_calls       Include 0/0 genotype calls when calculating TPs and
                        precision. By default they are ignored
  --cpus INT            Number of CPUs to use when running nucmer and minimap2
                        to get recall, eveything else is single-core/thread.
                        If you have a big genome, more efficient to run
                        make_truth_vcf with >1 CPU, then use its output with
                        --truth_vcf when running vcf_eval. [1]
```


## Metadata
- **Skill**: generated
