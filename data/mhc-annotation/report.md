# mhc-annotation CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mhc-annotation_mhca_annotate | PASS | GFF output is byte-identical to the author's test template |
| mhc-annotation_mhca_check_CDS | PASS |  |
| mhc-annotation_mhca_refseq2fullfasta | Failed | image problem: samtools is missing in the image but the script runs samtools faidx |
| mhc-annotation_mhca_update_feature_table | Not completed | runs only after a '>test1' record header was added by hand to the old feature table (mhca annotate does not write it), so the update cannot be confirmed on unedited input. |

## mhc-annotation_mhca_annotate

### Tool Description
Annotate a human MHC haplotype (FASTA) with gene and transcript information

### Metadata
- **Docker Image**: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
- **Homepage**: https://github.com/DiltheyLab/MHC-annotation
- **Package**: https://anaconda.org/channels/bioconda/packages/mhc-annotation/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhca annotate [-h] [--skip_imgt] [--skip_rsg] [--skip_rs]
                     [--skip_mapping] [--locus_tag_prefix LOCUS_TAG_PREFIX]
                     [--manual_corrections MANUAL_CORRECTIONS]
                     [--imgt_folder IMGT_FOLDER]
                     [--refseqgene_full_fasta REFSEQGENE_FULL_FASTA]
                     [--refseq_full_fasta REFSEQ_FULL_FASTA]
                     haplotype output_folder

positional arguments:
  haplotype             Input Haplotype in fasta format.
  output_folder

options:
  -h, --help            show this help message and exit
  --skip_imgt           Use this if you don't want to use IMGT as a data
                        source.
  --skip_rsg            Use this if you don't want to use RefSeqGene as a data
                        source.
  --skip_rs             Use this if you don't want to use RefSeq as a data
                        source.
  --skip_mapping        If you already have used minimap2 and want to skip
                        this step.
  --locus_tag_prefix LOCUS_TAG_PREFIX
                        Comma separated file containing the locus_tag_prefix
                        for the haplotype
  --manual_corrections MANUAL_CORRECTIONS
                        Comma separated file with manual corrections
  --imgt_folder IMGT_FOLDER
                        Folder which holds the start to stop codon fastas and
                        the full fastas with exon boundary information.
  --refseqgene_full_fasta REFSEQGENE_FULL_FASTA
                        Fasta file with exon boundary information (boundaries
                        denoted as: '|'). This can be generated from the
                        RefSeqGene genbank file and the genbank2fullfasta
                        method of this package. If this parameter is omitted,
                        a precompiled version of this is used.
  --refseq_full_fasta REFSEQ_FULL_FASTA
                        Fasta file with exon boundary information (boundaries
                        denoted as: '|'). This can be generated from a RefSeq
                        dataset. For details have a look at the
                        refseq2fullfasta script of this package. If this
                        parameter is omitted, a precompiled version of this is
                        used.
```

## mhc-annotation_mhca_check_CDS

### Tool Description
Check whether the transcripts in an annotation GFF would produce meaningful coding products

### Metadata
- **Docker Image**: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
- **Homepage**: https://github.com/DiltheyLab/MHC-annotation
- **Package**: https://anaconda.org/channels/bioconda/packages/mhc-annotation/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhca check_CDS [-h] haplotype annotation_gff

positional arguments:
  haplotype       Input Haplotype in fasta format.
  annotation_gff

options:
  -h, --help      show this help message and exit
```

## mhc-annotation_mhca_refseq2fullfasta

### Tool Description
Make a RefSeq full fasta (with exon boundaries) from a genome reference and a RefSeq gene table

### Metadata
- **Docker Image**: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
- **Homepage**: https://github.com/DiltheyLab/MHC-annotation
- **Package**: https://anaconda.org/channels/bioconda/packages/mhc-annotation/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhca refseq2fullfasta [-h] reference refseq_genes outfile

positional arguments:
  reference     Genome reference file. Usually hg38 in fasta format
  refseq_genes  Refseq tab-separated file
  outfile       Output fasta file.

options:
  -h, --help    show this help message and exit
```

## mhc-annotation_mhca_update_feature_table

### Tool Description
Update records in a feature table with the features of another feature table

### Metadata
- **Docker Image**: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
- **Homepage**: https://github.com/DiltheyLab/MHC-annotation
- **Package**: https://anaconda.org/channels/bioconda/packages/mhc-annotation/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhca update_feature_table [-h]
                                 old_feature_table record_id
                                 update_feature_table new_feature_table

positional arguments:
  old_feature_table     Old feature table file.
  record_id             ID of record that will be updated
  update_feature_table  Feature table file with new features.
  new_feature_table     New updated feature table file.

options:
  -h, --help            show this help message and exit
```

