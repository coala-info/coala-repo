# pigpen CWL Generation Report

## pigpen

### Tool Description
Pipeline for Identification Of Guanosine Positions Erroneously Notated

### Metadata
- **Docker Image**: quay.io/biocontainers/pigpen:0.0.9--pyhdfd78af_0
- **Homepage**: https://github.com/TaliaferroLab/OINC-seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pigpen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pigpen/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-05-21
- **GitHub**: https://github.com/TaliaferroLab/OINC-seq
- **Stars**: N/A
### Original Help Text
```text
usage: pigpen [-h] --datatype {single,paired} --samplenames SAMPLENAMES
              [--controlsamples CONTROLSAMPLES] [--gff GFF] --gfftype
              {GENCODE,Ensembl} [--genomeFasta GENOMEFASTA] [--nproc NPROC]
              [--useSNPs] [--snpfile SNPFILE] [--maskbed MASKBED]
              [--ROIbed ROIBED] [--SNPcoverage SNPCOVERAGE]
              [--SNPfreq SNPFREQ] [--onlyConsiderOverlap] [--use_g_t]
              [--use_g_c] [--use_g_x] [--use_ng_xg] [--use_read1]
              [--use_read2] --minMappingQual MINMAPPINGQUAL
              [--minPhred MINPHRED] [--nConv NCONV] --outputDir OUTPUTDIR

                    ,-,-----,
    PIGPEN     **** \ \ ),)`-'
              <`--'> \ \` 
              /. . `-----,
    OINC! >  ('')  ,      @~
              `-._,  ___  /
-|-|-|-|-|-|-|-| (( /  (( / -|-|-| 
|-|-|-|-|-|-|-|- '''   ''' -|-|-|-
-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|

   Pipeline for Identification 
      Of Guanosine Positions
       Erroneously Notated

options:
  -h, --help            show this help message and exit
  --datatype {single,paired}
                        Single end or paired end data?
  --samplenames SAMPLENAMES
                        Comma separated list of samples to quantify.
  --controlsamples CONTROLSAMPLES
                        Comma separated list of control samples (i.e. those
                        where no *induced* conversions are expected). May be a
                        subset of samplenames. Required if SNPs are to be
                        considered and a snpfile is not supplied.
  --gff GFF             Genome annotation in gff format.
  --gfftype {GENCODE,Ensembl}
                        Source of genome annotation file.
  --genomeFasta GENOMEFASTA
                        Genome sequence in fasta format. Required if SNPs are
                        to be considered.
  --nproc NPROC         Number of processors to use. Default is 1.
  --useSNPs             Consider SNPs?
  --snpfile SNPFILE     VCF file of snps to mask. If --useSNPs but a --snpfile
                        is not supplied, a VCF of snps will be created using
                        --controlsamples.
  --maskbed MASKBED     Optional. Bed file of positions to mask from analysis.
  --ROIbed ROIBED       Optional. Bed file of specific regions of interest in
                        which to quantify conversions. If supplied, only
                        conversions in these regions will be quantified.
  --SNPcoverage SNPCOVERAGE
                        Minimum coverage to call SNPs. Default = 20
  --SNPfreq SNPFREQ     Minimum variant frequency to call SNPs. Default = 0.4
  --onlyConsiderOverlap
                        Only consider conversions seen in both reads of a read
                        pair? Only possible with paired end data.
  --use_g_t             Consider G->T conversions?
  --use_g_c             Consider G->C conversions?
  --use_g_x             Consider G->deletion conversions?
  --use_ng_xg           Consider NG->deletionG conversions?
  --use_read1           Use read1 when looking for conversions? Only useful
                        with paired end data.
  --use_read2           Use read2 when looking for conversions? Only useful
                        with paired end data.
  --minMappingQual MINMAPPINGQUAL
                        Minimum mapping quality for a read to be considered in
                        conversion counting. STAR unique mappers have MAPQ
                        255.
  --minPhred MINPHRED   Minimum phred quality score for a base to be
                        considered. Default = 30
  --nConv NCONV         Minimum number of required G->T and/or G->C
                        conversions in a read pair in order for those
                        conversions to be counted. Default is 1.
  --outputDir OUTPUTDIR
                        Output directory.
```

