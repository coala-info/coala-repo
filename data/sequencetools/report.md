# sequencetools CWL Generation Report

## sequencetools_pileupCaller

### Tool Description
PileupCaller is a tool to create genotype calls from bam files using read-sampling methods. To use this tool, you need to convert bam files into the mpileup-format, specified at http://www.htslib.org/doc/samtools.html (under "mpileup"). The recommended command line to create a multi-sample mpileup file to be processed with pileupCaller is

    samtools mpileup -B -q30 -Q30 -l <BED_FILE> -R -f <FASTA_REFERENCE_FILE>
        Sample1.bam Sample2.bam Sample3.bam | pileupCaller ...

You can lookup what these options do in the samtools documentation. Note that flag -B in samtools is very important to reduce reference bias in low coverage data.

### Metadata
- **Docker Image**: quay.io/biocontainers/sequencetools:1.6.0.0--hebebf5b_0
- **Homepage**: https://github.com/stschiff/sequenceTools
- **Package**: https://anaconda.org/channels/bioconda/packages/sequencetools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sequencetools/overview
- **Total Downloads**: 27.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/stschiff/sequenceTools
- **Stars**: N/A
### Original Help Text
```text
Usage: pileupCaller [--version] 
                    (--randomHaploid | --majorityCall [--downSampling] | 
                      --randomDiploid) [--keepIncongruentReads] 
                    [--seed <RANDOM_SEED>] [-d|--minDepth <DEPTH>] 
                    [--skipTransitions | --transitionsMissing | 
                      --singleStrandMode] (-f|--snpFile <FILE>) 
                    [(-e|--eigenstratOut <FILE_PREFIX>) [-z|----zip] | 
                      (-p|--plinkOut <FILE_PREFIX>) 
                      [--popNameAsPhenotype | --popNameAsBoth] [-z|----zip] |
                      --vcf] 
                    (--sampleNames NAME1,NAME2,... | --sampleNameFile <FILE>) 
                    [--samplePopName POP(s)]

  PileupCaller is a tool to create genotype calls from bam files using
  read-sampling methods. To use this tool, you need to convert bam files into
  the mpileup-format, specified at http://www.htslib.org/doc/samtools.html
  (under "mpileup"). The recommended command line to create a multi-sample
  mpileup file to be processed with pileupCaller is

      samtools mpileup -B -q30 -Q30 -l <BED_FILE> -R -f <FASTA_REFERENCE_FILE>
          Sample1.bam Sample2.bam Sample3.bam | pileupCaller ...

  You can lookup what these options do in the samtools documentation. Note that
  flag -B in samtools is very important to reduce reference bias in low coverage
  data.


  This tool is part of sequenceTools version 1.6.0.0

Available options:
  --version                Print version and exit
  -h,--help                Show this help text
  --randomHaploid          This method samples one read at random at each site,
                           and uses the allele on that read as the one for the
                           actual genotype. This results in a haploid call
  --majorityCall           Pick the allele supported by the most reads at a
                           site. If an equal numbers of alleles fulfil this,
                           pick one at random. This results in a haploid call.
                           See --downSampling for best practices for calling
                           rare variants
  --downSampling           When this switch is given, the MajorityCalling mode
                           will downsample from the total number of reads a
                           number of reads (without replacement) equal to the
                           --minDepth given. This mitigates reference bias in
                           the MajorityCalling model, which increases with
                           higher coverage. The recommendation for rare-allele
                           calling is --majorityCall --downsampling --minDepth 3
  --randomDiploid          Sample two reads at random (without replacement) at
                           each site and represent the individual by a diploid
                           genotype constructed from those two random picks.
                           This will always assign missing data to positions
                           where only one read is present, even if minDepth=1.
                           The main use case for this option is for estimating
                           mean heterozygosity across sites.
  --keepIncongruentReads   By default, pileupCaller now removes reads with
                           tri-allelic alleles that are neither of the two
                           alleles specified in the SNP file. To keep those
                           reads for sampling, set this flag. With this option
                           given, if the sampled read has a tri-allelic allele
                           that is neither of the two given alleles in the SNP
                           file, a missing genotype is generated. IMPORTANT
                           NOTE: The default behaviour has changed in
                           pileupCaller version 1.4.0. If you want to emulate
                           the previous behaviour, use this flag. I recommend
                           now to NOT set this flag and use the new behaviour.
  --seed <RANDOM_SEED>     random seed used for the random number generator. If
                           not given, use system clock to seed the random number
                           generator.
  -d,--minDepth <DEPTH>    specify the minimum depth for a call. For sites with
                           fewer reads than this number, declare Missing
                           (default: 1)
  --skipTransitions        skip transition SNPs entirely in the output,
                           resulting in a dataset with fewer sites.
  --transitionsMissing     mark transitions as missing in the output, but do
                           output the sites.
  --singleStrandMode       [THIS IS CURRENTLY AN EXPERIMENTAL FEATURE]. At C/T
                           polymorphisms, ignore reads aligning to the forward
                           strand. At G/A polymorphisms, ignore reads aligning
                           to the reverse strand. This should remove post-mortem
                           damage in ancient DNA libraries prepared with the
                           non-UDG single-stranded protocol.
  -f,--snpFile <FILE>      an Eigenstrat-formatted SNP list file for the
                           positions and alleles to call. All positions in the
                           SNP file will be output, adding missing data where
                           there is no data. Note that pileupCaller
                           automatically checks whether alleles in the SNP file
                           are flipped with respect to the human reference, and
                           in those cases flips the genotypes accordingly. But
                           it assumes that the strand-orientation of the SNPs
                           given in the SNP list is the one in the reference
                           genome used in the BAM file underlying the pileup
                           input. Note that both the SNP file and the incoming
                           pileup data have to be ordered by chromosome and
                           position, and this is checked. The chromosome order
                           in humans is 1-22,X,Y,MT. Chromosome can generally
                           begin with "chr". In case of non-human data with
                           different chromosome names, you should convert all
                           names to numbers. They will always considered to be
                           numerically ordered, even beyond 22. Finally, I note
                           that for internally, X is converted to 23, Y to 24
                           and MT to 90. This is the most widely used encoding
                           in Eigenstrat databases for human data, so using a
                           SNP file with that encoding will automatically be
                           correctly aligned to pileup data with actual
                           chromosome names X, Y and MT (or chrX, chrY and
                           chrMT, respectively).
  -e,--eigenstratOut <FILE_PREFIX>
                           Set Eigenstrat as output format. Specify the
                           filenames for the EigenStrat SNP, IND and GENO file
                           outputs: <FILE_PREFIX>.snp, <FILE_PREFIX>.ind and
                           <FILE_PREFIX>.geno. If not set, output will be
                           FreqSum (Default). Note that freqSum format,
                           described at
                           https://rarecoal-docs.readthedocs.io/en/latest/rarecoal-tools.html#vcf2freqsum,
                           is useful for testing your pipeline, since it's
                           output to standard out
  -z,----zip               GZip the output Eigenstrat or Plink genotype and SNP
                           files. Filenames will be appended with '.gz'. To zip
                           FreqSum or VCF output, just zip the standard output
                           of this program, for example `pileupCaller ... --vcf
                           | gzip -c > out.vcf.gz
  -p,--plinkOut <FILE_PREFIX>
                           Set Plink as output format. Specify the filenames for
                           the Plink BIM, FAM and BED file outputs:
                           <FILE_PREFIX>.bim, <FILE_PREFIX>.fam and
                           <FILE_PREFIX>.bed. If not set, output will be FreqSum
                           (Default). Note that freqSum format, described at
                           https://rarecoal-docs.readthedocs.io/en/latest/rarecoal-tools.html#vcf2freqsum,
                           is useful for testing your pipeline, since it's
                           output to standard out
  --popNameAsPhenotype     Only valid for Plink Output: Write the population
                           name into the last column of the fam file, as a
                           Phenotype according to the Plink Spec. By default,
                           the population name is specified as the first column
                           only (family name in the Plink spec)
  --popNameAsBoth          Only valid for Plink Output: Write the population
                           name into both the first and last column of the fam
                           file, so both as Family-ID and as a Phenotype
                           according to the Plink Spec. By default, the
                           population name is specified only as the first column
                           (family name in the Plink spec)
  -z,----zip               GZip the output Eigenstrat or Plink genotype and SNP
                           files. Filenames will be appended with '.gz'. To zip
                           FreqSum or VCF output, just zip the standard output
                           of this program, for example `pileupCaller ... --vcf
                           | gzip -c > out.vcf.gz
  --vcf                    output VCF format to stdout
  --sampleNames NAME1,NAME2,...
                           give the names of the samples as comma-separated list
                           (no spaces)
  --sampleNameFile <FILE>  give the names of the samples in a file with one name
                           per line
  --samplePopName POP(s)   specify the population name(s) of the samples, which
                           are included in the output *.ind.txt file in
                           Eigenstrat output. This will be ignored if the output
                           format is not Eigenstrat. If a single name is given,
                           it is applied to all samples, if multiple are given,
                           their number must match the the number of samples
                           (default: Left "Unknown")
```


## sequencetools_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/sequencetools:1.6.0.0--hebebf5b_0
- **Homepage**: https://github.com/stschiff/sequenceTools
- **Package**: https://anaconda.org/channels/bioconda/packages/sequencetools/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.21 (using htslib 1.21)

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

