# jasminesv CWL Generation Report

## jasminesv_jasmine

### Tool Description
Merge variants from multiple VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
- **Homepage**: https://github.com/mkirsche/Jasmine
- **Package**: https://anaconda.org/channels/bioconda/packages/jasminesv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jasminesv/overview
- **Total Downloads**: 44.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mkirsche/Jasmine
- **Stars**: N/A
### Original Help Text
```text
Error: No list of VCFs specified


Jasmine version 1.1.5
Usage: jasmine [args]
  Example: jasmine file_list=filelist.txt out_file=out.vcf

Required args:
  file_list (String) - a file listing paths to unzipped VCF files to merge (on separate lines)
  out_file  (String) - the name of the file to output the merged variants to

Optional args:
  max_dist_linear (float)  [0.5]      - the proportion of the length of each variant to set distance threshold to
  max_dist        (int)    [inf]      - the maximum distance variants can be apart when being merged
  min_dist        (int)    [100]      - the minimum distance threshold a variant can have when using max_dist_linear
  kd_tree_norm    (int)    [2]        - the power to use in kd-tree distances (1 is Manhattan, 2 is Euclidean, etc.)
  min_seq_id      (float)  [0]        - the minimum sequence identity for two insertions to be merged
  k_jaccard       (int)    [9]        - the kmer size to use when computing Jaccard similarity of insertions
  max_dup_length  (int)    [10k]      - the maximum length of duplication that can be converted to an insertion
  min_support     (int)    [1]        - the minimum number of callsets a variant must be in to be output
  threads         (int)    [1]        - the number of threads to use for merging the variants
  spec_reads      (int)    [10]       - the minimum number of reads a variant needs to be in the specific callset
  spec_len        (int)    [30]       - the minimum length a variant needs to be in the specific callset
  genome_file     (String) []         - the reference genome being used
  bam_list        (String) []         - a file listing paths to BAMs in the same order as the VCFs
  iris_args       (String) []         - a comma-separated list of optional arguments to pass to Iris
  out_dir         (String) [output]   - the directory where intermediate files go
  samtools_path   (String) [samtools] - the path to the samtools executable used for coverting duplications
  chr_norm_file   (String) []         - the path to a file containing chromosome name mappings, if they are being normalized
  sample_dists    (String) []         - the path to a file containing distance thresholds for each sample, one per line
  min_overlap     (float)  [0]        - the minimum reciprocal overlap for DEL/INV/DUP SVs
  --ignore_strand                     - allow variants with different strands to be merged
  --ignore_type                       - allow variants with different types to be merged
  --dup_to_ins                        - convert duplications to insertions for SV merging and then convert them back
  --mark_specific                     - mark calls in the original VCF files that have enough support to called specific
  --run_iris                          - run Iris before merging for refining the sequences of insertions
  --pre_normalize                     - run type normalization before merging
  --use_edit_dist                     - use edit distance for comparing insertion sequences instead of Jaccard
  --preprocess_only                   - only run the preprocessing and not the actual merging or post-processing
  --postprocess_only                  - only run the postprocessing and not the actual merging or pre-processing
  --keep_var_ids                      - don't change variant IDs (should only be used if input IDs are unique across samples)
  --use_end                           - use the end coordinate as the second coordinate instead of the variant length
  --output_genotypes                  - print the genotypes of the consensus variants in all of the samples they came from
  --ignore_merged_inputs              - ignore merging info such as support vectors which is already present in the inputs
  --centroid_merging                  - require every group to have a centroid which is within the distance threshold of each variant
  --clique_merging                    - require every group to have each pair within in it be mergeable
  --allow_intrasample                 - allow variants in the same sample to be merged
  --normalize_type                    - convert all variants to INS/DEL/DUP/INV/TRA
  --leave_breakpoints                 - leave breakpoints as they are even if they are inconsistent
  --require_first_sample              - only output merged variants which include a variant from the first sample
  --comma_filelist                    - input VCFs are given comma-separated instead of providing a txt file
  --normalize_chrs                    - normalize chromosome names (to NCBI standards - without "chr" - by default)
  --non_mutual_distance               - no longer require a pair of points to be within both of their distance thresholds
  --default_zero_genotype             - marks genotype as 0|0 instead of ./. for any samples in which a merged variant is absent
  --nonlinear_dist                    - disable distance threshold depending on variant length and use max_dist instead

Notes:
  genome_file is required if the dup_to_ins option or the run_iris option is used.
  bam_list is required if the run_iris option is used.
  Setting both max_dist_linear and max_dist sets thresholds to minimum of max_dist and max_dist_linear * sv_length.
  Setting both max_dist_linear and min_dist sets thresholds to maximum of min_dist and max_dist_linear * sv_length.
  Setting min_dist to -1 removes the minimum threshold.
```


## jasminesv_igv_jasmine

### Tool Description
Jasmine IGV Screenshot Maker

### Metadata
- **Docker Image**: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
- **Homepage**: https://github.com/mkirsche/Jasmine
- **Package**: https://anaconda.org/channels/bioconda/packages/jasminesv/overview
- **Validation**: PASS

### Original Help Text
```text
Jasmine IGV Screenshot Maker
Usage: igv_jasmine [args]
  Example: igv_jasmine vcf_file=merged.vcf genome_file=genome.fa bam_filelist=bams.txt out_prefix=igv

Required args:
  vcf_file      (String) - the VCF file with merged SVs
  genome_file   (String) - the FASTA file with the reference genome
  bam_filelist  (String) - a comma-separated list of BAM files
  out_prefix    (String) - the prefix of the output directory and filenames

Optional args:
  info_filter=KEY,VALUE  - filter by an INFO field value (multiple allowed) e.g., info_filter=SUPP_VEC,101
  grep_filter=QUERY      - filter to only lines containing a given QUERY
  vcf_filelist  (String) - the txt file with a list of input VCFs in the same order as BAM files
  bed_file      (String) - a bed file with a list of ranges (use instead of vcf_file)
  --precise              - require variant to contain "PRECISE" as an INFO field
  --specific             - shorthand for info_filter=IS_SPECIFIC,1
  --squish               - squishes tracks to fit more reads
  --svg                  - save as an SVG instead of a PNG
  --normalize_chr_names  - normalize the VCF chromosome names to strip "chr"
```


## jasminesv_split_jasmine

### Tool Description
Merge variants from multiple VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
- **Homepage**: https://github.com/mkirsche/Jasmine
- **Package**: https://anaconda.org/channels/bioconda/packages/jasminesv/overview
- **Validation**: PASS

### Original Help Text
```text
Error: No list of VCFs specified


Jasmine version 1.1.5
Usage: jasmine [args]
  Example: jasmine file_list=filelist.txt out_file=out.vcf

Required args:
  file_list (String) - a file listing paths to unzipped VCF files to merge (on separate lines)
  out_file  (String) - the name of the file to output the merged variants to

Optional args:
  max_dist_linear (float)  [0.5]      - the proportion of the length of each variant to set distance threshold to
  max_dist        (int)    [inf]      - the maximum distance variants can be apart when being merged
  min_dist        (int)    [100]      - the minimum distance threshold a variant can have when using max_dist_linear
  kd_tree_norm    (int)    [2]        - the power to use in kd-tree distances (1 is Manhattan, 2 is Euclidean, etc.)
  min_seq_id      (float)  [0]        - the minimum sequence identity for two insertions to be merged
  k_jaccard       (int)    [9]        - the kmer size to use when computing Jaccard similarity of insertions
  max_dup_length  (int)    [10k]      - the maximum length of duplication that can be converted to an insertion
  min_support     (int)    [1]        - the minimum number of callsets a variant must be in to be output
  threads         (int)    [1]        - the number of threads to use for merging the variants
  spec_reads      (int)    [10]       - the minimum number of reads a variant needs to be in the specific callset
  spec_len        (int)    [30]       - the minimum length a variant needs to be in the specific callset
  genome_file     (String) []         - the reference genome being used
  bam_list        (String) []         - a file listing paths to BAMs in the same order as the VCFs
  iris_args       (String) []         - a comma-separated list of optional arguments to pass to Iris
  out_dir         (String) [output]   - the directory where intermediate files go
  samtools_path   (String) [samtools] - the path to the samtools executable used for coverting duplications
  chr_norm_file   (String) []         - the path to a file containing chromosome name mappings, if they are being normalized
  sample_dists    (String) []         - the path to a file containing distance thresholds for each sample, one per line
  min_overlap     (float)  [0]        - the minimum reciprocal overlap for DEL/INV/DUP SVs
  --ignore_strand                     - allow variants with different strands to be merged
  --ignore_type                       - allow variants with different types to be merged
  --dup_to_ins                        - convert duplications to insertions for SV merging and then convert them back
  --mark_specific                     - mark calls in the original VCF files that have enough support to called specific
  --run_iris                          - run Iris before merging for refining the sequences of insertions
  --pre_normalize                     - run type normalization before merging
  --use_edit_dist                     - use edit distance for comparing insertion sequences instead of Jaccard
  --preprocess_only                   - only run the preprocessing and not the actual merging or post-processing
  --postprocess_only                  - only run the postprocessing and not the actual merging or pre-processing
  --keep_var_ids                      - don't change variant IDs (should only be used if input IDs are unique across samples)
  --use_end                           - use the end coordinate as the second coordinate instead of the variant length
  --output_genotypes                  - print the genotypes of the consensus variants in all of the samples they came from
  --ignore_merged_inputs              - ignore merging info such as support vectors which is already present in the inputs
  --centroid_merging                  - require every group to have a centroid which is within the distance threshold of each variant
  --clique_merging                    - require every group to have each pair within in it be mergeable
  --allow_intrasample                 - allow variants in the same sample to be merged
  --normalize_type                    - convert all variants to INS/DEL/DUP/INV/TRA
  --leave_breakpoints                 - leave breakpoints as they are even if they are inconsistent
  --require_first_sample              - only output merged variants which include a variant from the first sample
  --comma_filelist                    - input VCFs are given comma-separated instead of providing a txt file
  --normalize_chrs                    - normalize chromosome names (to NCBI standards - without "chr" - by default)
  --non_mutual_distance               - no longer require a pair of points to be within both of their distance thresholds
  --default_zero_genotype             - marks genotype as 0|0 instead of ./. for any samples in which a merged variant is absent
  --nonlinear_dist                    - disable distance threshold depending on variant length and use max_dist instead

Notes:
  genome_file is required if the dup_to_ins option or the run_iris option is used.
  bam_list is required if the run_iris option is used.
  Setting both max_dist_linear and max_dist sets thresholds to minimum of max_dist and max_dist_linear * sv_length.
  Setting both max_dist_linear and min_dist sets thresholds to maximum of min_dist and max_dist_linear * sv_length.
  Setting min_dist to -1 removes the minimum threshold.
```

