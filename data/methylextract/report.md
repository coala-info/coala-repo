# methylextract CWL Generation Report

## methylextract_MethylExtract.pl

### Tool Description
MethylExtract is a tool for cytosine methylation profiling and SNV calling from bisulfite sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylextract:1.9.1--0
- **Homepage**: http://bioinfo2.ugr.es/MethylExtract/
- **Package**: https://anaconda.org/channels/bioconda/packages/methylextract/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methylextract/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
################   MethylExtract   ###############
##############   Command-line help   #############

Launch as:
  perl MethylExtract.pl seq=<sequences directory or multifasta single file> inDir=<alignments' directory> flagW=<Watson FLAGs (multiple FLAGs comma separated)> flagC=<Crick FLAGs (multiple FLAGs comma separated)> [OPTIONS]

Optional Quality parameters:
  qscore=<fastq quality score: phred33-quals, phred64-quals,solexa-quals, solexa1.3-quals or NA> [default: phred33-quals]
  delDup=<delete duplicated reads: Y or N> [default: N]
  simDupPb=<number of similar nucleotides to detect a duplicated read> [default: 32]
  FirstIgnor=<number of first bases ignored (5' end)> [default: 0]
  LastIgnor=<number of last bases ignored (3' end)> [default:0]
  peOverlap=<discard second mate overlapping segment on pair-end alignment reads: Y or N> [default: N]
  minDepthMeth=<minimum number of reads requiered to consider a methylation value in a certain position> [default: 1]
  minDepthSNV=<minimum number of reads requiered to consider a SNV value in a certain position> [default: 1]
  minQ=<minimun PHRED quality per sequenced nucleotide> [default: 20]
  methNonCpGs=<nonCpG contexts methylated to discard read> [default: 0.9] (methNonCpGs=0 deactivates bisulfite read check)
  varFraction=<Minimum allele frequency> [default: 0.1]
  maxStrandBias=<Maximum strand bias> [default: 0.7] (maxStrandBias=0 deactivates the threshold)
  maxPval=<Variation p-value threshold> [default: 0.05]
Optional working parameters:
  p=<threads number> [default: 4]
  chromDiv=<number of chromosome divisions to sort reads> [default: 400]
  memNumReads=<number of lines kept on memory for each thread> [default: 200000]
  chromSplitted=<skip alignment chromosome splitting, files must be chromosome splitted and named by chromosome (example: chr1.sam,etc...)> [default: N]
Optional output parameters:
  context=<methylation context to extract: CG, CHG, CHH or ALL> [default: CG]
  outDir=<output directory> [default: inDir]
  bedOut=<methylation output in BED format> [default: N]
  wigOut=<methylation output in WIG format> [default: N]
```

