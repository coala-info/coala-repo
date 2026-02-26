# sgcocaller CWL Generation Report

## sgcocaller_autophase

### Tool Description
sgcocaller is a tool for phasing and analyzing single-cell DNA sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
- **Homepage**: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sgcocaller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sgcocaller/overview
- **Total Downloads**: 14.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
0.3.9
  Usage:
      sgcocaller autophase [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      sgcocaller phase [options] <BAM> <VCF> <barcodeFile> <out_prefix> 
      sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix> 
      sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix>
      sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      

Arguments:

  <BAM> the read alignment file with records of single-cell DNA reads
  
  <VCF> the variant call file with records of SNPs

  <barcodeFile> the text file containing the list of cell barcodes

  <out_prefix>  the prefix of output files

  <out_vcf> the output vcf aftering phasing blocks in hapfile
  
  <gtMtxFile> the output gtMtx.mtx file from running sgcocaller phase

  <phasedSnpAnnotFile>  the output phased_snpAnnot.txt from running sgcocaller phase

Options:
  -t --threads <threads>  number of BAM decompression threads [default: 4]
  --barcodeTag <barcodeTag>  the cell barcode tag in BAM [default: CB]
  --minMAPQ <mapq>  Minimum MAPQ for read filtering [default: 20]
  --baseq <baseq>  base quality threshold for a base to be used for counting [default: 13]
  --chrom <chrom>  the selected chromsome (whole genome if not supplied,separate by comma if multiple chroms)
  --minDP <minDP>  the minimum DP for a SNP to be included in the output file [default: 1]
  --maxDP <maxDP>  the maximum DP for a SNP to be included in the output file [default: 5]
  --maxTotalDP <maxTotalDP>  the maximum DP across all barcodes for a SNP to be included in the output file [default: 25]
  --minTotalDP <minTotalDP>  the minimum DP across all barcodes for a SNP to be included in the output file [default: 10]
  --minSNPdepth <minSNPdepth>  the minimum depth of cell coverage for a SNP to be includes in generated genotype matrix file [default: 1]
  --thetaREF <thetaREF>  the theta for the binomial distribution conditioning on hidden state being REF [default: 0.1]
  --thetaALT <thetaALT>  the theta for the binomial distribution conditioning on hidden state being ALT [default: 0.9]
  --cmPmb <cmPmb>  the average centiMorgan distances per megabases default 0.1 cm per Mb [default: 0.1]
  --phased  the input VCF for calling crossovers contains the phased GT of heterozygous SNPs
  --outvcf  generate the output in vcf format (sgcocaller phase)  
  --templateCell <templateCell>  the cell's genotype to be used a template cell, as the cell's index (0-starting) in the barcode file, default as not supplied [default: -1]
  --maxDissim <maxDissim>  the maximum dissimilarity for a pair of cell to be selected as potential template cells due to not having crossovers in either cell [default: 0.0099]
  --maxExpand <maxExpand>  the maximum number of iterations to look for locally coexisting positions for inferring missing SNPs in template haplotype sequence [default: 1000]
  --posteriorProbMin <posteriorProbMin>  the min posterior probability for inferring missing SNPs [default: 0.99]
  --lookBeyondSnps <lookBeyondSnps>  the number of local SNPs to use when finding switch positions [default: 25]
  --minSwitchScore <minSwitchScore>  the minimum switch score for a site to be identified as having a switch error in the inferred haplotype  [default: 50.0]
  --minPositiveSwitchScores <minPositiveSwitchScores>  the min number of continuing SNPs with positive switch scores to do switch error correction [default: 8]  
  --binSize <binSize>  the size of SNP bins for scanning swith errors, users are recommended to increase this option when SNP density is high. [default: 2000]
  --stepSize <stepSize>  the move step size used in combination with --binSize. [default: 200]
  --dissimThresh <dissimThresh>  the threshold used on the allele concordance ratio for determining if a SNP bin contains a crossover. [default: 0.0099]
  --batchSize <batchSize>  the number of cells to process in one batch when running sxo. This option is only needed when the memory is limited. 
  --notSortMtx  do not sort the output mtx. 
  --maxUseNcells <maxUseNcells>  the number of cells to use for calculating switch scores. All cells are used if not set
  -h --help  show help


  Examples
      ./sgcocaller autophase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller phase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller xo --threads 4 possorted_bam.bam phased_hetSNPs.vcf.gz barcodeFile.tsv ./percell/ccsnp
      ./sgcocaller sxo snp_phase.txt phaseOutputPrefix barcodeFile.tsv ./percell/ccsnp
```


## sgcocaller_phase

### Tool Description
sgcocaller phase command

### Metadata
- **Docker Image**: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
- **Homepage**: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sgcocaller/overview
- **Validation**: PASS

### Original Help Text
```text
0.3.9
  Usage:
      sgcocaller autophase [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      sgcocaller phase [options] <BAM> <VCF> <barcodeFile> <out_prefix> 
      sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix> 
      sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix>
      sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      

Arguments:

  <BAM> the read alignment file with records of single-cell DNA reads
  
  <VCF> the variant call file with records of SNPs

  <barcodeFile> the text file containing the list of cell barcodes

  <out_prefix>  the prefix of output files

  <out_vcf> the output vcf aftering phasing blocks in hapfile
  
  <gtMtxFile> the output gtMtx.mtx file from running sgcocaller phase

  <phasedSnpAnnotFile>  the output phased_snpAnnot.txt from running sgcocaller phase

Options:
  -t --threads <threads>  number of BAM decompression threads [default: 4]
  --barcodeTag <barcodeTag>  the cell barcode tag in BAM [default: CB]
  --minMAPQ <mapq>  Minimum MAPQ for read filtering [default: 20]
  --baseq <baseq>  base quality threshold for a base to be used for counting [default: 13]
  --chrom <chrom>  the selected chromsome (whole genome if not supplied,separate by comma if multiple chroms)
  --minDP <minDP>  the minimum DP for a SNP to be included in the output file [default: 1]
  --maxDP <maxDP>  the maximum DP for a SNP to be included in the output file [default: 5]
  --maxTotalDP <maxTotalDP>  the maximum DP across all barcodes for a SNP to be included in the output file [default: 25]
  --minTotalDP <minTotalDP>  the minimum DP across all barcodes for a SNP to be included in the output file [default: 10]
  --minSNPdepth <minSNPdepth>  the minimum depth of cell coverage for a SNP to be includes in generated genotype matrix file [default: 1]
  --thetaREF <thetaREF>  the theta for the binomial distribution conditioning on hidden state being REF [default: 0.1]
  --thetaALT <thetaALT>  the theta for the binomial distribution conditioning on hidden state being ALT [default: 0.9]
  --cmPmb <cmPmb>  the average centiMorgan distances per megabases default 0.1 cm per Mb [default: 0.1]
  --phased  the input VCF for calling crossovers contains the phased GT of heterozygous SNPs
  --outvcf  generate the output in vcf format (sgcocaller phase)  
  --templateCell <templateCell>  the cell's genotype to be used a template cell, as the cell's index (0-starting) in the barcode file, default as not supplied [default: -1]
  --maxDissim <maxDissim>  the maximum dissimilarity for a pair of cell to be selected as potential template cells due to not having crossovers in either cell [default: 0.0099]
  --maxExpand <maxExpand>  the maximum number of iterations to look for locally coexisting positions for inferring missing SNPs in template haplotype sequence [default: 1000]
  --posteriorProbMin <posteriorProbMin>  the min posterior probability for inferring missing SNPs [default: 0.99]
  --lookBeyondSnps <lookBeyondSnps>  the number of local SNPs to use when finding switch positions [default: 25]
  --minSwitchScore <minSwitchScore>  the minimum switch score for a site to be identified as having a switch error in the inferred haplotype  [default: 50.0]
  --minPositiveSwitchScores <minPositiveSwitchScores>  the min number of continuing SNPs with positive switch scores to do switch error correction [default: 8]  
  --binSize <binSize>  the size of SNP bins for scanning swith errors, users are recommended to increase this option when SNP density is high. [default: 2000]
  --stepSize <stepSize>  the move step size used in combination with --binSize. [default: 200]
  --dissimThresh <dissimThresh>  the threshold used on the allele concordance ratio for determining if a SNP bin contains a crossover. [default: 0.0099]
  --batchSize <batchSize>  the number of cells to process in one batch when running sxo. This option is only needed when the memory is limited. 
  --notSortMtx  do not sort the output mtx. 
  --maxUseNcells <maxUseNcells>  the number of cells to use for calculating switch scores. All cells are used if not set
  -h --help  show help


  Examples
      ./sgcocaller autophase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller phase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller xo --threads 4 possorted_bam.bam phased_hetSNPs.vcf.gz barcodeFile.tsv ./percell/ccsnp
      ./sgcocaller sxo snp_phase.txt phaseOutputPrefix barcodeFile.tsv ./percell/ccsnp
```


## sgcocaller_swphase

### Tool Description
sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix>

### Metadata
- **Docker Image**: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
- **Homepage**: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sgcocaller/overview
- **Validation**: PASS

### Original Help Text
```text
0.3.9
  Usage:
      sgcocaller autophase [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      sgcocaller phase [options] <BAM> <VCF> <barcodeFile> <out_prefix> 
      sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix> 
      sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix>
      sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      

Arguments:

  <BAM> the read alignment file with records of single-cell DNA reads
  
  <VCF> the variant call file with records of SNPs

  <barcodeFile> the text file containing the list of cell barcodes

  <out_prefix>  the prefix of output files

  <out_vcf> the output vcf aftering phasing blocks in hapfile
  
  <gtMtxFile> the output gtMtx.mtx file from running sgcocaller phase

  <phasedSnpAnnotFile>  the output phased_snpAnnot.txt from running sgcocaller phase

Options:
  -t --threads <threads>  number of BAM decompression threads [default: 4]
  --barcodeTag <barcodeTag>  the cell barcode tag in BAM [default: CB]
  --minMAPQ <mapq>  Minimum MAPQ for read filtering [default: 20]
  --baseq <baseq>  base quality threshold for a base to be used for counting [default: 13]
  --chrom <chrom>  the selected chromsome (whole genome if not supplied,separate by comma if multiple chroms)
  --minDP <minDP>  the minimum DP for a SNP to be included in the output file [default: 1]
  --maxDP <maxDP>  the maximum DP for a SNP to be included in the output file [default: 5]
  --maxTotalDP <maxTotalDP>  the maximum DP across all barcodes for a SNP to be included in the output file [default: 25]
  --minTotalDP <minTotalDP>  the minimum DP across all barcodes for a SNP to be included in the output file [default: 10]
  --minSNPdepth <minSNPdepth>  the minimum depth of cell coverage for a SNP to be includes in generated genotype matrix file [default: 1]
  --thetaREF <thetaREF>  the theta for the binomial distribution conditioning on hidden state being REF [default: 0.1]
  --thetaALT <thetaALT>  the theta for the binomial distribution conditioning on hidden state being ALT [default: 0.9]
  --cmPmb <cmPmb>  the average centiMorgan distances per megabases default 0.1 cm per Mb [default: 0.1]
  --phased  the input VCF for calling crossovers contains the phased GT of heterozygous SNPs
  --outvcf  generate the output in vcf format (sgcocaller phase)  
  --templateCell <templateCell>  the cell's genotype to be used a template cell, as the cell's index (0-starting) in the barcode file, default as not supplied [default: -1]
  --maxDissim <maxDissim>  the maximum dissimilarity for a pair of cell to be selected as potential template cells due to not having crossovers in either cell [default: 0.0099]
  --maxExpand <maxExpand>  the maximum number of iterations to look for locally coexisting positions for inferring missing SNPs in template haplotype sequence [default: 1000]
  --posteriorProbMin <posteriorProbMin>  the min posterior probability for inferring missing SNPs [default: 0.99]
  --lookBeyondSnps <lookBeyondSnps>  the number of local SNPs to use when finding switch positions [default: 25]
  --minSwitchScore <minSwitchScore>  the minimum switch score for a site to be identified as having a switch error in the inferred haplotype  [default: 50.0]
  --minPositiveSwitchScores <minPositiveSwitchScores>  the min number of continuing SNPs with positive switch scores to do switch error correction [default: 8]  
  --binSize <binSize>  the size of SNP bins for scanning swith errors, users are recommended to increase this option when SNP density is high. [default: 2000]
  --stepSize <stepSize>  the move step size used in combination with --binSize. [default: 200]
  --dissimThresh <dissimThresh>  the threshold used on the allele concordance ratio for determining if a SNP bin contains a crossover. [default: 0.0099]
  --batchSize <batchSize>  the number of cells to process in one batch when running sxo. This option is only needed when the memory is limited. 
  --notSortMtx  do not sort the output mtx. 
  --maxUseNcells <maxUseNcells>  the number of cells to use for calculating switch scores. All cells are used if not set
  -h --help  show help


  Examples
      ./sgcocaller autophase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller phase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller xo --threads 4 possorted_bam.bam phased_hetSNPs.vcf.gz barcodeFile.tsv ./percell/ccsnp
      ./sgcocaller sxo snp_phase.txt phaseOutputPrefix barcodeFile.tsv ./percell/ccsnp
```


## sgcocaller_sxo

### Tool Description
sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix>

### Metadata
- **Docker Image**: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
- **Homepage**: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sgcocaller/overview
- **Validation**: PASS

### Original Help Text
```text
0.3.9
  Usage:
      sgcocaller autophase [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      sgcocaller phase [options] <BAM> <VCF> <barcodeFile> <out_prefix> 
      sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix> 
      sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix>
      sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      

Arguments:

  <BAM> the read alignment file with records of single-cell DNA reads
  
  <VCF> the variant call file with records of SNPs

  <barcodeFile> the text file containing the list of cell barcodes

  <out_prefix>  the prefix of output files

  <out_vcf> the output vcf aftering phasing blocks in hapfile
  
  <gtMtxFile> the output gtMtx.mtx file from running sgcocaller phase

  <phasedSnpAnnotFile>  the output phased_snpAnnot.txt from running sgcocaller phase

Options:
  -t --threads <threads>  number of BAM decompression threads [default: 4]
  --barcodeTag <barcodeTag>  the cell barcode tag in BAM [default: CB]
  --minMAPQ <mapq>  Minimum MAPQ for read filtering [default: 20]
  --baseq <baseq>  base quality threshold for a base to be used for counting [default: 13]
  --chrom <chrom>  the selected chromsome (whole genome if not supplied,separate by comma if multiple chroms)
  --minDP <minDP>  the minimum DP for a SNP to be included in the output file [default: 1]
  --maxDP <maxDP>  the maximum DP for a SNP to be included in the output file [default: 5]
  --maxTotalDP <maxTotalDP>  the maximum DP across all barcodes for a SNP to be included in the output file [default: 25]
  --minTotalDP <minTotalDP>  the minimum DP across all barcodes for a SNP to be included in the output file [default: 10]
  --minSNPdepth <minSNPdepth>  the minimum depth of cell coverage for a SNP to be includes in generated genotype matrix file [default: 1]
  --thetaREF <thetaREF>  the theta for the binomial distribution conditioning on hidden state being REF [default: 0.1]
  --thetaALT <thetaALT>  the theta for the binomial distribution conditioning on hidden state being ALT [default: 0.9]
  --cmPmb <cmPmb>  the average centiMorgan distances per megabases default 0.1 cm per Mb [default: 0.1]
  --phased  the input VCF for calling crossovers contains the phased GT of heterozygous SNPs
  --outvcf  generate the output in vcf format (sgcocaller phase)  
  --templateCell <templateCell>  the cell's genotype to be used a template cell, as the cell's index (0-starting) in the barcode file, default as not supplied [default: -1]
  --maxDissim <maxDissim>  the maximum dissimilarity for a pair of cell to be selected as potential template cells due to not having crossovers in either cell [default: 0.0099]
  --maxExpand <maxExpand>  the maximum number of iterations to look for locally coexisting positions for inferring missing SNPs in template haplotype sequence [default: 1000]
  --posteriorProbMin <posteriorProbMin>  the min posterior probability for inferring missing SNPs [default: 0.99]
  --lookBeyondSnps <lookBeyondSnps>  the number of local SNPs to use when finding switch positions [default: 25]
  --minSwitchScore <minSwitchScore>  the minimum switch score for a site to be identified as having a switch error in the inferred haplotype  [default: 50.0]
  --minPositiveSwitchScores <minPositiveSwitchScores>  the min number of continuing SNPs with positive switch scores to do switch error correction [default: 8]  
  --binSize <binSize>  the size of SNP bins for scanning swith errors, users are recommended to increase this option when SNP density is high. [default: 2000]
  --stepSize <stepSize>  the move step size used in combination with --binSize. [default: 200]
  --dissimThresh <dissimThresh>  the threshold used on the allele concordance ratio for determining if a SNP bin contains a crossover. [default: 0.0099]
  --batchSize <batchSize>  the number of cells to process in one batch when running sxo. This option is only needed when the memory is limited. 
  --notSortMtx  do not sort the output mtx. 
  --maxUseNcells <maxUseNcells>  the number of cells to use for calculating switch scores. All cells are used if not set
  -h --help  show help


  Examples
      ./sgcocaller autophase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller phase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller xo --threads 4 possorted_bam.bam phased_hetSNPs.vcf.gz barcodeFile.tsv ./percell/ccsnp
      ./sgcocaller sxo snp_phase.txt phaseOutputPrefix barcodeFile.tsv ./percell/ccsnp
```


## sgcocaller_xo

### Tool Description
sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>

### Metadata
- **Docker Image**: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
- **Homepage**: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sgcocaller/overview
- **Validation**: PASS

### Original Help Text
```text
0.3.9
  Usage:
      sgcocaller autophase [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      sgcocaller phase [options] <BAM> <VCF> <barcodeFile> <out_prefix> 
      sgcocaller swphase [options] <gtMtxFile> <phasedSnpAnnotFile> <referenceVCF> <out_prefix> 
      sgcocaller sxo [options] <SNPPhaseFile> <phaseOutputPrefix> <barcodeFile> <out_prefix>
      sgcocaller xo [options] <BAM> <VCF> <barcodeFile> <out_prefix>
      

Arguments:

  <BAM> the read alignment file with records of single-cell DNA reads
  
  <VCF> the variant call file with records of SNPs

  <barcodeFile> the text file containing the list of cell barcodes

  <out_prefix>  the prefix of output files

  <out_vcf> the output vcf aftering phasing blocks in hapfile
  
  <gtMtxFile> the output gtMtx.mtx file from running sgcocaller phase

  <phasedSnpAnnotFile>  the output phased_snpAnnot.txt from running sgcocaller phase

Options:
  -t --threads <threads>  number of BAM decompression threads [default: 4]
  --barcodeTag <barcodeTag>  the cell barcode tag in BAM [default: CB]
  --minMAPQ <mapq>  Minimum MAPQ for read filtering [default: 20]
  --baseq <baseq>  base quality threshold for a base to be used for counting [default: 13]
  --chrom <chrom>  the selected chromsome (whole genome if not supplied,separate by comma if multiple chroms)
  --minDP <minDP>  the minimum DP for a SNP to be included in the output file [default: 1]
  --maxDP <maxDP>  the maximum DP for a SNP to be included in the output file [default: 5]
  --maxTotalDP <maxTotalDP>  the maximum DP across all barcodes for a SNP to be included in the output file [default: 25]
  --minTotalDP <minTotalDP>  the minimum DP across all barcodes for a SNP to be included in the output file [default: 10]
  --minSNPdepth <minSNPdepth>  the minimum depth of cell coverage for a SNP to be includes in generated genotype matrix file [default: 1]
  --thetaREF <thetaREF>  the theta for the binomial distribution conditioning on hidden state being REF [default: 0.1]
  --thetaALT <thetaALT>  the theta for the binomial distribution conditioning on hidden state being ALT [default: 0.9]
  --cmPmb <cmPmb>  the average centiMorgan distances per megabases default 0.1 cm per Mb [default: 0.1]
  --phased  the input VCF for calling crossovers contains the phased GT of heterozygous SNPs
  --outvcf  generate the output in vcf format (sgcocaller phase)  
  --templateCell <templateCell>  the cell's genotype to be used a template cell, as the cell's index (0-starting) in the barcode file, default as not supplied [default: -1]
  --maxDissim <maxDissim>  the maximum dissimilarity for a pair of cell to be selected as potential template cells due to not having crossovers in either cell [default: 0.0099]
  --maxExpand <maxExpand>  the maximum number of iterations to look for locally coexisting positions for inferring missing SNPs in template haplotype sequence [default: 1000]
  --posteriorProbMin <posteriorProbMin>  the min posterior probability for inferring missing SNPs [default: 0.99]
  --lookBeyondSnps <lookBeyondSnps>  the number of local SNPs to use when finding switch positions [default: 25]
  --minSwitchScore <minSwitchScore>  the minimum switch score for a site to be identified as having a switch error in the inferred haplotype  [default: 50.0]
  --minPositiveSwitchScores <minPositiveSwitchScores>  the min number of continuing SNPs with positive switch scores to do switch error correction [default: 8]  
  --binSize <binSize>  the size of SNP bins for scanning swith errors, users are recommended to increase this option when SNP density is high. [default: 2000]
  --stepSize <stepSize>  the move step size used in combination with --binSize. [default: 200]
  --dissimThresh <dissimThresh>  the threshold used on the allele concordance ratio for determining if a SNP bin contains a crossover. [default: 0.0099]
  --batchSize <batchSize>  the number of cells to process in one batch when running sxo. This option is only needed when the memory is limited. 
  --notSortMtx  do not sort the output mtx. 
  --maxUseNcells <maxUseNcells>  the number of cells to use for calculating switch scores. All cells are used if not set
  -h --help  show help


  Examples
      ./sgcocaller autophase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller phase possorted_bam.bam hetSNPs.vcf.gz barcodeFile.tsv phaseOutputPrefix
      ./sgcocaller xo --threads 4 possorted_bam.bam phased_hetSNPs.vcf.gz barcodeFile.tsv ./percell/ccsnp
      ./sgcocaller sxo snp_phase.txt phaseOutputPrefix barcodeFile.tsv ./percell/ccsnp
```


## Metadata
- **Skill**: generated
