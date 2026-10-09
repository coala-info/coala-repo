# liqa CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| liqa_diff | Failed | image problem: perl is not installed and the R package gcmr is missing in the image |
| liqa_novel | PASS |  |
| liqa_quantify | PASS |  |
| liqa_refgene | Failed | image problem: perl is not installed in the image, but the PreProcess_gtf.pl and PreProcess.pl scripts need it |

## liqa_refgene

### Tool Description
Preprocess a reference annotation file into the isoform compatible matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/WGLab/LIQA
- **Package**: https://anaconda.org/channels/bioconda/packages/liqa/overview
- **Validation**: PASS

### Original Help Text
```text
liqa -task refgene -ref <reference_file> -format <reference_file_format(gtf/ucsc)> -out <output_file>
```

## liqa_quantify

### Tool Description
Quantify isoform expression from long-read RNA-seq alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/WGLab/LIQA
- **Package**: https://anaconda.org/channels/bioconda/packages/liqa/overview
- **Validation**: PASS

### Original Help Text
```text
liqa -task quantify -refgene <refgene_file> -bam <bam_file> -out <output_file> -max_distance <max distance> -f_weight <weight of F function>
```

## liqa_diff

### Tool Description
Detect differential splicing genes between two conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/WGLab/LIQA
- **Package**: https://anaconda.org/channels/bioconda/packages/liqa/overview
- **Validation**: PASS

### Original Help Text
```text
liqa    -task diff
	-condition_1 <isoform_expression_estimation_file_for_condition1>
	-condition_2 <isoform_expression_estimation_file_for_condition2>
	-out <test_results_file>
```

## liqa_novel

### Tool Description
Detect novel isoforms from long-read RNA-seq alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/WGLab/LIQA
- **Package**: https://anaconda.org/channels/bioconda/packages/liqa/overview
- **Validation**: PASS

### Original Help Text
```text
liqa -task novel -refgene <refgene_file> -bam <bam_file> -out <output_file> -num_cover <# bp coverage> -num_support_read <# support reads>
```

## Metadata
- **Skill**: generated

