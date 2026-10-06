# vardict-java CWL Generation Report

## Metadata
- **Skill**: generated

## vardict-java_var2vcf_valid.pl

### Tool Description
Convert VarDict output to VCF format with validation filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
- **Homepage**: https://github.com/joachimwolff/VarDictJava
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict-java/overview
- **Validation**: PASS

### Original Help Text
```text
##fileformat=VCFv4.2
##source=VarDict_v1.8.2
##INFO=<ID=SAMPLE,Number=1,Type=String,Description="Sample name (with whitespace translated to underscores)">
##INFO=<ID=TYPE,Number=1,Type=String,Description="Variant Type: SNV Insertion Deletion Complex">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##INFO=<ID=END,Number=1,Type=Integer,Description="Chr End Position">
##INFO=<ID=VD,Number=1,Type=Integer,Description="Variant Depth">
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##INFO=<ID=BIAS,Number=1,Type=String,Description="Strand Bias Info">
##INFO=<ID=REFBIAS,Number=1,Type=String,Description="Reference depth by strand">
##INFO=<ID=VARBIAS,Number=1,Type=String,Description="Variant depth by strand">
##INFO=<ID=PMEAN,Number=1,Type=Float,Description="The mean distance to the nearest 5 or 3 prime read end (whichever is closer) in all reads that support the variant call">
##INFO=<ID=PSTD,Number=1,Type=Float,Description="Position STD in reads">
##INFO=<ID=QUAL,Number=1,Type=Float,Description="Mean quality score in reads">
##INFO=<ID=QSTD,Number=1,Type=Float,Description="Quality score STD in reads">
##INFO=<ID=SBF,Number=1,Type=Float,Description="Strand Bias Fisher p-value">
##INFO=<ID=ODDRATIO,Number=1,Type=Float,Description="Strand Bias Odds ratio">
##INFO=<ID=MQ,Number=1,Type=Float,Description="Mean Mapping Quality">
##INFO=<ID=SN,Number=1,Type=Float,Description="Signal to noise">
##INFO=<ID=HIAF,Number=1,Type=Float,Description="Allele frequency using only high quality bases">
##INFO=<ID=ADJAF,Number=1,Type=Float,Description="Adjusted AF for indels due to local realignment">
##INFO=<ID=SHIFT3,Number=1,Type=Integer,Description="No. of bases to be shifted to 3 prime for deletions due to alternative alignment">
##INFO=<ID=MSI,Number=1,Type=Float,Description="MicroSatellite. > 1 indicates MSI">
##INFO=<ID=MSILEN,Number=1,Type=Float,Description="MicroSatellite unit length in bp">
##INFO=<ID=NM,Number=1,Type=Float,Description="Mean mismatches in reads">
##INFO=<ID=LSEQ,Number=1,Type=String,Description="5' flanking seq">
##INFO=<ID=RSEQ,Number=1,Type=String,Description="3' flanking seq">
##INFO=<ID=GDAMP,Number=1,Type=Integer,Description="No. of amplicons supporting variant">
##INFO=<ID=TLAMP,Number=1,Type=Integer,Description="Total of amplicons covering variant">
##INFO=<ID=NCAMP,Number=1,Type=Integer,Description="No. of amplicons don't work">
##INFO=<ID=AMPFLAG,Number=1,Type=Integer,Description="Top variant in amplicons don't match">
##INFO=<ID=HICNT,Number=1,Type=Integer,Description="High quality variant reads">
##INFO=<ID=HICOV,Number=1,Type=Integer,Description="High quality total reads">
##INFO=<ID=SPLITREAD,Number=1,Type=Integer,Description="No. of split reads supporting SV">
##INFO=<ID=SPANPAIR,Number=1,Type=Integer,Description="No. of pairs supporting SV">
##INFO=<ID=SVTYPE,Number=1,Type=String,Description="SV type: INV DUP DEL INS FUS">
##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="The length of SV in bp">
##INFO=<ID=DUPRATE,Number=1,Type=Float,Description="Duplication rate in fraction">
##FILTER=<ID=q22.5,Description="Mean Base Quality Below 22.5">
##FILTER=<ID=Q10,Description="Mean Mapping Quality Below 10">
##FILTER=<ID=p8,Description="Mean Position in Reads Less than 8">
##FILTER=<ID=SN1.5,Description="Signal to Noise Less than 1.5">
##FILTER=<ID=Bias,Description="Strand Bias">
##FILTER=<ID=pSTD,Description="Position in Reads has STD of 0">
##FILTER=<ID=d3,Description="Total Depth < 3">
##FILTER=<ID=v2,Description="Var Depth < 2">
##FILTER=<ID=f0.02,Description="Allele frequency < 0.02">
##FILTER=<ID=MSI12,Description="Variant in MSI region with 12 non-monomer MSI or 13 monomer MSI">
##FILTER=<ID=NM5.25,Description="Mean mismatches in reads >= 5.25, thus likely false positive">
##FILTER=<ID=InGap,Description="The variant is in the deletion gap, thus likely false positive">
##FILTER=<ID=InIns,Description="The variant is adjacent to an insertion variant">
##FILTER=<ID=Cluster0bp,Description="Two variants are within 0 bp">
##FILTER=<ID=LongMSI,Description="The somatic variant is flanked by long A/T (>=14)">
##FILTER=<ID=AMPBIAS,Description="Indicate the variant has amplicon bias.">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##FORMAT=<ID=VD,Number=1,Type=Integer,Description="Variant Depth">
##FORMAT=<ID=AD,Number=R,Type=Integer,Description="Allelic depths for the ref and alt alleles in the order listed">
##FORMAT=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##FORMAT=<ID=RD,Number=2,Type=Integer,Description="Reference forward, reverse reads">
##FORMAT=<ID=ALD,Number=2,Type=Integer,Description="Variant forward, reverse reads">
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	
/usr/local/bin/var2vcf_valid.pl version 1.8.2 calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: var2vcf_valid.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -P -d -v -f -p -q -F -Q -o -N -m -I -c -r -O -X -k -V -M -x -T -b -G
	Boolean (without arguments): -h -u -t -a -H -S -C -E -A

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
Use of uninitialized value $sample_nowhitespace in substitution (s///) at /usr/local/bin/var2vcf_valid.pl line 44.
Use of uninitialized value $sample in join or string at /usr/local/bin/var2vcf_valid.pl line 116.
```
