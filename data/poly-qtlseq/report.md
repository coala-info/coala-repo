# poly-qtlseq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| poly-qtlseq_polyQtlseq | Not completed | pipeline, skipped |
| poly-qtlseq_polyQtlseq_qc | PASS |  |
| poly-qtlseq_polyQtlseq_qtl | Failed | image problem: graph step crashes (SkiaSharp cannot load a font, run prints QTL-Seq analysis error and no graph images); synthetic data: planted-QTL VCF, tables found the planted 1.2-1.8 Mb region |

## poly-qtlseq_polyQtlseq

### Tool Description
Run the Polyploid QTL-seq pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
- **Homepage**: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/poly-qtlseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poly-qtlseq/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
- **Stars**: N/A
### Original Help Text
```text
Polyploid QTL-seq Ver 1.2.6

Run the Polyploid QTL-seq pipeline.

Usage: PolyploidQtlSeq [command] [options]

Options:
  -v|--version             Show version number.
  -h|--help                Show help message.
  -r|--refSeq              Reference sequence file.
  -p1|--parent1            Parent1 Directory.
  -p2|--parent2            Parent2 Directory.
  -b1|--bulk1              Bulk1 Directory.
  -b2|--bulk2              Bulk2 Directory.
  -o|--outputDir           Output Directory.
  -cs|--chrSize            Threshold for length of chromosomes to be analyzed.
                           Chromosomes with a length more than this value are
                           analyzed.
                           Default value is: 10000000.
  -cn|--chrNames           Specify the chromosome name to be analyzed. If there
                           are more than one, separate them with commas.
  -q|--minMQ               Minimum mapping quality at variant detection in
                           bcftools mpileup.
                           Default value is: 40.
  -Q|--minBQ               Minimum base quality at variant detection in bcftools
                           mpileup.
                           Default value is: 13.
  -C|--adjustMQ            Value for adjust mapping quality at variant detection
                           in bcftools mpileup.
                           Specify 0, to disable this function.
                           
                           Default value is: 60.
  -sc|--snpEffConfig       snpEff.config file. Not required if snpEff default
                           config file is used.
  -sd|--snpEffDatabase     SnpEff database name.
  -sm|--snpEffMaxHeap      SnpEff maximum heap size (GB).
                           Default value is: 6.
  -p1r|--p1MostAlleleRate  Most allele frequency for Parent1. Variants exceeding
                           this threshold is considered homozygous.
                           Default value is: 0.99.
  -p2r|--p2SnpIndexRange   SNP-index range for parent2.
                           Default value is: 0.15-0.375.
  -md|--minDepth           Minimum Depth threshold. The variants with even one
                           sample below this threshold are excluded for QTL
                           analysis.
                           Default value is: 40.
  -mb|--maxBulkSnpIndex    Maximum threshold for SNP-index for the Bulk samples.
                           Variants with a SNP-index exceeding this value are
                           excluded.
                           Default value is: 1.
  -p|--ploidy              Ploidy.
                           Default value is: 4.
  -np|--NPlex              Specify the plexity of Parent2 used for QTL analysis.
                           Default value is: 1.
  -n1|--NBulk1             Number of Individuals in bulk1.
                           Default value is: 20.
  -n2|--NBulk2             Number of Individuals in bulk2.
                           Default value is: 20.
  -N|--NRep                Number of simulation replicates to generate a null
                           distribution which is free from QTLs.
                           Default value is: 5000.
  -w|--window              Window size (kbp) of the sliding window analysis.
                           Default value is: 100.
  -s|--step                Step size (kbp) of the sliding window analysis.
                           Default value is: 20.
  -fw|--figWidth           Width (pixel) of the graph images.
                           Default value is: 1200.
  -fh|--figHeight          Height (pixel) of the graph images.
                           Default value is: 300.
  -xs|--xStep              X-axis scale interval (Mbp) of the graphs.
                           Default value is: 5.
  -di|--displayImpacts     Annotation Impact to be included in the SNP-index
                           file. Separate multiple items with commas.
                           Default value is: HIGH,MODERATE.
  -t|--thread              Number of threads to use.
                           Default value is: 20.
  -P|--paramsFile          Parameter file.

Commands:
  qc                       Quality Control by fastp.
  qtl                      QTL-Seq analysis.

Run 'PolyploidQtlSeq [command] -h|--help' for more information about a command.
```


## poly-qtlseq_polyQtlseq_qc

### Tool Description
Quality Control by fastp.

### Metadata
- **Docker Image**: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
- **Homepage**: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/poly-qtlseq/overview
- **Validation**: PASS

### Original Help Text
```text
Quality Control by fastp.

Usage: PolyploidQtlSeq qc [options]

Options:
  -h|--help                Show help message.
  -i|--inputDir            Raw fastq directory.
  -o|--outputDir           Output directory.
  -l|--lengthRequired      Minimum read length after trimming. length_required
                           in fastp.
                           Default value is: 50.
  -n|--nBaseLimit          Maximum number of N bases. n_base_limit in fastp.
                           Default value is: 5.
  -q|--quality             Threshold for base quality. qualified_quality_phred
                           in fastp.
                           Default value is: 15.
  -Q|--cutTailMeanQuality  Threshold of average quality for trimming at 3' end.
                           cut_tail_mean_quality in fastp.
                           Default value is: 20.
  -W|--cutTailWindowSize   Window size when trimmed at 3' end.
                           cut_tail_window_size in fastp.
                           Default value is: 1.
  -t|--thread              Number of threads to use. Up to 16.
                           Default value is: 10.
  -P|--paramsFile          Parameter file.
```

## poly-qtlseq_polyQtlseq_qtl

### Tool Description
QTL-Seq analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
- **Homepage**: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/poly-qtlseq/overview
- **Validation**: PASS

### Original Help Text
```text
QTL-Seq analysis.

Usage: PolyploidQtlSeq qtl [options]

Options:
  -h|--help                Show help message.
  -i|--inputVcf            Input VCF file.
  -o|--outputDir           Output Directory.
  -p1r|--p1MostAlleleRate  Most allele frequency for Parent1. Variants exceeding
                           this threshold is considered homozygous.
                           Default value is: 0.99.
  -p2r|--p2SnpIndexRange   SNP-index range for parent2.
                           Default value is: 0.15-0.375.
  -md|--minDepth           Minimum Depth threshold. The variants with even one
                           sample below this threshold are excluded for QTL
                           analysis.
                           Default value is: 40.
  -mb|--maxBulkSnpIndex    Maximum threshold for SNP-index for the Bulk samples.
                           Variants with a SNP-index exceeding this value are
                           excluded.
                           Default value is: 1.
  -p|--ploidy              Ploidy.
                           Default value is: 4.
  -np|--NPlex              Specify the plexity of Parent2 used for QTL analysis.
                           Default value is: 1.
  -n1|--NBulk1             Number of Individuals in bulk1.
                           Default value is: 20.
  -n2|--NBulk2             Number of Individuals in bulk2.
                           Default value is: 20.
  -N|--NRep                Number of simulation replicates to generate a null
                           distribution which is free from QTLs.
                           Default value is: 5000.
  -w|--window              Window size (kbp) of the sliding window analysis.
                           Default value is: 100.
  -s|--step                Step size (kbp) of the sliding window analysis.
                           Default value is: 20.
  -fw|--figWidth           Width (pixel) of the graph images.
                           Default value is: 1200.
  -fh|--figHeight          Height (pixel) of the graph images.
                           Default value is: 300.
  -xs|--xStep              X-axis scale interval (Mbp) of the graphs.
                           Default value is: 5.
  -di|--displayImpacts     Annotation Impact to be included in the SNP-index
                           file. Separate multiple items with commas.
                           Default value is: HIGH,MODERATE.
  -t|--thread              Number of threads to use.
                           Default value is: 20.
  -P|--paramsFile          Parameter file.
```

## Metadata
- **Skill**: not generated
