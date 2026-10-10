# methylextract CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| methylextract_MethylExtract.pl | PASS | E. coli bisulfite read pairs aligned with Bismark; CpG methylation 79.8 percent, same as the Bismark extractor; fixed outDir flag and writable input folder |
| methylextract_MethylExtractBSCR.pl | PASS | conversion rate 0.696 on all cytosines, consistent with the Bismark methylation counts; new CWL |
| methylextract_MethylExtractBSPvalue.pl | PASS | error probability added to 55939 CpG rows, 9395 significant at FDR 0.05; new CWL |

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

## methylextract_MethylExtractBSCR.pl

### Tool Description
Estimates the bisulfite conversion rate from alignments and a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylextract:1.9.1--0
- **Homepage**: http://bioinfo2.ugr.es/MethylExtract/
- **Package**: https://anaconda.org/channels/bioconda/packages/methylextract/overview
- **Validation**: PASS

### Original Help Text
```text


################   MethylExtractBSCR   ###############
###############   Command-line help   ###############

Launch as:
  perl MethExtractBSCR.pl seqFile=<sequence file> inFile=<alignments input file> flagW=<Watson FLAGs (multiple FLAGs comma separated)> flagC=<Crick FLAGs (multiple FLAGs comma separated)> [OPTIONS]
Optional Quality parameters:
  qscore=<fastq quality score: phred33-quals, phred64-quals,solexa-quals, solexa1.3-quals or NA> [default: phred33-quals]
  minQ=<minimun PHRED quality per sequenced nucleotide> [default: 20]
  FirstIgnor=<number of first bases ignored> [default: 0]
  LastIgnor=<number of last bases ignored> [default: 0]
```

## methylextract_MethylExtractBSPvalue.pl

### Tool Description
Calculates the bisulfite error probability of each methylation value in a MethylExtract output.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylextract:1.9.1--0
- **Homepage**: http://bioinfo2.ugr.es/MethylExtract/
- **Package**: https://anaconda.org/channels/bioconda/packages/methylextract/overview
- **Validation**: PASS

### Original Help Text
```text


################   MethylExtractErrorProbability   ###############
######################   Command-line help   #####################

Launch as:
  perl MethylExtractBSPvalue.pl inFile=<input file> BSCR=<Bisulfite conversion rate> [OPTIONS]

Optional parameters:
  outFile=<Output file> [default: inFile.prob]
  errorInterval=<Error interval allowed> [default: 0.2]
  FDR=<False discovery rate allowed> [default: NA]
```
