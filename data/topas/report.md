# topas CWL Generation Report

## topas_consensusseqlfromvcfs

### Tool Description
generate a consensus sequence from the SNPs of several VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/topas:1.0.1--0
- **Homepage**: https://github.com/subwaystation/TOPAS
- **Package**: https://anaconda.org/channels/bioconda/packages/topas/overview
- **Validation**: PASS

### Original Help Text
```text
TOPAS - TOolkit for Processing and Annotation of Sequence data
Use "java -jar topas.jar MODULE" to start a specific program
and replace MODULE with
   ValidateFasta       	validate a fasta file
   CorrectFasta        	correct a fasta file
   IndexFasta          	generate fasta index from a fasta file
   TabulateFasta       	tabulates a fasta file into: HEADER TAB SEQUENCE
   ExtractFasta        	sort a fasta file and return only the fasta sequences which match a given pattern
   PrimaryBaseFasta    	crawl through every sequence in a fasta file and replace secondary bases with primary ones
   ValidateGFF3        	validate a gff3 file
   FilterGFF3          	a GFF3 file can be filtered by seqid + range, source, type, score, strand, phase, attribute
   SortGFF3            	sorts a GFF3 File first by SeqId, then by Start/End
   FormatFastq         	format the sequence string line(s) and the quality string line(s) of a fastq file to a certain length
   ValidateFastq       	validate a fastq file
   IndexVCF            	generate vcf index from a vcf file
   FilterVCF           	a VCF file can be filtered by CHROM:START-END, ID and by INFO (SNP or INDEL)
   AnnotateVCF         	annotate a vcf file by reference of a vcf CHROM:POSITION to SEQID:START-END of a gff3 file
   ConsensusSeqFromVCFs	generate a consensus sequence from the SNPs of several VCF files
   AnalyseVcf          	analyse a given vcf file by given windows
   GenConS             	generate a consensus sequence from a GATK Unified Genotyper generated VCF file
   JoinExprTables      	join expression tables together (based on gene names)
   NormExprTable       	normalize expression table
   PhyCc               	crawl through a given SNP table in tsv format and calculate simple statistics
```

