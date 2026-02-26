# poly-qtlseq CWL Generation Report

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


## poly-qtlseq_bwa

### Tool Description
alignment via Burrows-Wheeler transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
- **Homepage**: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/poly-qtlseq/overview
- **Validation**: PASS

### Original Help Text
```text
Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.19-r1273
Contact: Heng Li <hli@ds.dfci.harvard.edu>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
         fastmap       identify super-maximal exact matches
         pemerge       merge overlapping paired ends (EXPERIMENTAL)
         aln           gapped/ungapped alignment
         samse         generate alignment (single ended)
         sampe         generate alignment (paired ended)
         bwasw         BWA-SW for long queries (DEPRECATED)

         shm           manage indices in shared memory
         fa2pac        convert FASTA to PAC format
         pac2bwt       generate BWT from PAC
         pac2bwtgen    alternative algorithm for generating BWT
         bwtupdate     update .bwt to the new format
         bwt2sa        generate SA from BWT and Occ

Note: To use BWA, you need to first index the genome with `bwa index'.
      There are three alignment algorithms in BWA: `mem', `bwasw', and
      `aln/samse/sampe'. If you are not sure which to use, try `bwa mem'
      first. Please `man ./bwa.1' for the manual.
```


## poly-qtlseq_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
- **Homepage**: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/poly-qtlseq/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.23 (using htslib 1.23)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     fqidx          index/extract FASTQ
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates
     ampliconclip   clip oligos from the end of reads

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     consensus      produce a consensus Pileup/FASTA/FASTQ
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA
     import         Converts FASTA or FASTQ files to SAM/BAM/CRAM
     reference      Generates a reference from aligned data
     reset          Reverts aligner changes in reads

  -- Statistics
     bedcov         read depth per BED region
     coverage       alignment depth and percent coverage
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     cram-size      list CRAM Content-ID and Data-Series sizes
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)
     ampliconstats  generate amplicon specific stats
     checksum       produce order-agnostic checksums of sequence content

  -- Viewing
     flags          explain BAM flags
     head           header viewer
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
     samples        list the samples in a set of SAM/BAM/CRAM files

  -- Misc
     help [cmd]     display this help message or help for [cmd]
     version        detailed version information
```

