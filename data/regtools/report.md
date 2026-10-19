# regtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| regtools_cis-ase_identify | PASS | output identical to the expected file shipped in the regtools integration tests |
| regtools_cis-splice-effects_associate | PASS | output identical to the expected file shipped in the regtools integration tests |
| regtools_cis-splice-effects_identify | PASS | output identical to the expected file shipped in the regtools integration tests |
| regtools_junctions_annotate | PASS | output identical to the expected file shipped in the regtools integration tests |
| regtools_junctions_extract | PASS | output identical to the expected file shipped in the regtools integration tests |
| regtools_variants_annotate | PASS | output identical to the expected file shipped in the regtools integration tests |

## regtools_junctions_extract

### Tool Description
Identify exon-exon junctions from alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
- **Homepage**: https://github.com/griffithlab/regtools
- **Package**: https://anaconda.org/channels/bioconda/packages/regtools/overview
- **Validation**: PASS

### Original Help Text
```text
Program:	regtools
Version:	1.0.0
Usage:		regtools junctions extract [options] indexed_alignments.bam
Options:
		-a INT	Minimum anchor length. Junctions which satisfy a minimum 
			 anchor length on both sides are reported. [8]
		-m INT	Minimum intron length. [70]
		-M INT	Maximum intron length. [500000]
		-o FILE	The file to write output to. [STDOUT]
		-r STR	The region to identify junctions 
			 in "chr:start-end" format. Entire BAM by default.
		-s INT	Strandness mode 
			 XS, use XS tags provided by aligner; RF, first-strand; FR, second-strand. REQUIRED
		-t STR	Tag used in bam to label strand. [XS]
		-b STR	The file containing the barcodes of interest for single cell data.

Error parsing inputs!(2)
```

## regtools_junctions_annotate

### Tool Description
Annotate the junctions.

### Metadata
- **Docker Image**: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
- **Homepage**: https://github.com/griffithlab/regtools
- **Package**: https://anaconda.org/channels/bioconda/packages/regtools/overview
- **Validation**: PASS

### Original Help Text
```text
Program:	regtools
Version:	1.0.0
Usage:		regtools junctions annotate [options] junctions.bed ref.fa annotations.gtf
Options:	-S include single exon genes
		-o FILE	The file to write output to. [STDOUT]

Error parsing inputs!(2)
```

## regtools_variants_annotate

### Tool Description
Annotate variants with splicing information.

### Metadata
- **Docker Image**: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
- **Homepage**: https://github.com/griffithlab/regtools
- **Package**: https://anaconda.org/channels/bioconda/packages/regtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:		regtools variants annotate [options] variants.vcf annotations.gtf
Options:
		-o FILE	The file to write output to. [STDOUT]
		-e INT	Maximum distance from the start/end of an exon 
			 to annotate a variant as relevant to splicing, the variant 
			 is in exonic space, i.e a coding variant. [3]
		-i INT	Maximum distance from the start/end of an exon 
			 to annotate a variant as relevant to splicing, the variant 
			 is in intronic space. [2]
		-I	Annotate variants in intronic space within a transcript(not to be used with -i).
		-E	Annotate variants in exonic space within a transcript(not to be used with -e).
		-S	Don't skip single exon transcripts.


Program:	regtools
Version:	1.0.0
Error parsing inputs!(2)
```

## regtools_cis-ase_identify

### Tool Description
Identify cis allele specific expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
- **Homepage**: https://github.com/griffithlab/regtools
- **Package**: https://anaconda.org/channels/bioconda/packages/regtools/overview
- **Validation**: PASS

### Original Help Text
```text
Program:	regtools
Version:	1.0.0
Usage:		regtools cis-ase identify [options] somatic_variants.vcf polymorphism.vcf tumor_dna_alignments.bam tumor_rna_alignments.bam ref.fa annotations.gtf
Options:
		-o STR Output file containing the ase variants in VCF format. [STDOUT]
		-d INT Minimum total read-depth for a somatic/ASE variant. [10]
		-w INT Window around a somatic variant to look for transcripts. ASE variants will be in these transcripts[1000]
		-B Use the binomial model for modeling ASE in RNAseq(uses the beta model by default)
		-E Look at all polymorphisms for ASE, not just exonic.

Error parsing inputs!(2)
```

## regtools_cis-splice-effects_identify

### Tool Description
Identify splice variants and aberrant junctions from variants and alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
- **Homepage**: https://github.com/griffithlab/regtools
- **Package**: https://anaconda.org/channels/bioconda/packages/regtools/overview
- **Validation**: PASS

### Original Help Text
```text
Program:	regtools
Version:	1.0.0
Usage:		regtools cis-splice-effects identify [options] variants.vcf alignments.bam ref.fa annotations.gtf
Options:
		-o STR	Output file containing the aberrant splice junctions with annotations. [STDOUT]
		-v STR	Output file containing variants annotated as splice relevant (VCF format).
		-j STR	Output file containing the aberrant junctions in BED12 format.
		-s INT	Strandness mode 
			 XS, use XS tags provided by aligner; RF, first-strand; FR, second-strand. intron-motif, infer strand using canonical intron motifs. REQUIRED
		-C	Override strand assignments by inferring based on canonical motifs. Does not need to be specified if passing '-s intron-motif'.
		-t STR	Tag used in bam to label strand. [XS]
		-a INT	Minimum anchor length. Junctions which satisfy a minimum 
			 anchor length on both sides are reported. [8]
		-m INT	Minimum intron length. [70]
		-M INT	Maximum intron length. [500000]
		-w INT	Window size in b.p to identify splicing events in.
			 The tool identifies events in variant.start +/- w basepairs.
			 Default behaviour is to look at the window between previous and next exons.
		-e INT	Maximum distance from the start/end of an exon 
			 to annotate a variant as relevant to splicing, the variant 
			 is in exonic space, i.e a coding variant. [3]
		-i INT	Maximum distance from the start/end of an exon 
			 to annotate a variant as relevant to splicing, the variant 
			 is in intronic space. [2]
		-I	Annotate variants in intronic space within a transcript(not to be used with -i).
		-E	Annotate variants in exonic space within a transcript(not to be used with -e).
		-S	Don't skip single exon transcripts.
		-b STR	The file containing the barcodes of interest for single cell data.
		-C	Tells cis-splice-effects identify that you want intron-motif method to take priority when assigning strand. i.e. decide strandedness based on the fasta rather than what is encoded in the alignment file.

Error parsing inputs!(2)
```

## regtools_cis-splice-effects_associate

### Tool Description
Associate variants with splicing events from a junctions file.

### Metadata
- **Docker Image**: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
- **Homepage**: https://github.com/griffithlab/regtools
- **Package**: https://anaconda.org/channels/bioconda/packages/regtools/overview
- **Validation**: PASS

### Original Help Text
```text
Program:	regtools
Version:	1.0.0
Usage:		regtools cis-splice-effects associate [options] variants.vcf junctions.bed ref.fa annotations.gtf
Options:
		-o STR	Output file containing the aberrant splice junctions with annotations. [STDOUT]
		-v STR	Output file containing variants annotated as splice relevant (VCF format).
		-j STR	Output file containing the aberrant junctions in BED12 format.
		-a INT	Minimum anchor length. Junctions which satisfy a minimum 
			 anchor length on both sides are reported. [8]
		-m INT	Minimum intron length. [70]
		-M INT	Maximum intron length. [500000]
		-w INT	Window size in b.p to identify splicing events in.
			 The tool identifies events in variant.start +/- w basepairs.
			 Default behaviour is to look at the window between previous and next exons.
		-e INT	Maximum distance from the start/end of an exon 
			 to annotate a variant as relevant to splicing, the variant 
			 is in exonic space, i.e a coding variant. [3]
		-i INT	Maximum distance from the start/end of an exon 
			 to annotate a variant as relevant to splicing, the variant 
			 is in intronic space. [2]
		-I	Annotate variants in intronic space within a transcript(not to be used with -i).
		-E	Annotate variants in exonic space within a transcript(not to be used with -e).
		-S	Don't skip single exon transcripts.

Error parsing inputs!(2)
```

## Metadata
- **Skill**: generated
