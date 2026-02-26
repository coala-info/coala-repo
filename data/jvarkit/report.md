# jvarkit CWL Generation Report

## jvarkit_addlinearindextobed

### Tool Description
Add linear index to BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-25
- **GitHub**: https://github.com/lindenb/jvarkit
- **Stars**: N/A
### Original Help Text
```text
Usage: addlinearindextobed [options] Files
  Options:
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    -o, --out
      Output file. Optional . Default: stdout
  * -R, --reference, --dict
      A SAM Sequence dictionary source: it can be a *.dict file, a fasta file 
      indexed with 'picard CreateSequenceDictionary' or 'samtools dict', or 
      any hts file containing a dictionary (VCF, BAM, CRAM, intervals...)
    --version
      print version and exit
```


## jvarkit_backlocate

### Tool Description
Backlocate sequences to genomic coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: backlocate [options] Files
  Options:
  * -g, --gtf
      A GTF (General Transfer Format) file. See 
      https://www.ensembl.org/info/website/upload/gff.html . Please note that 
      CDS are only detected if a start and stop codons are defined.
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    -o, --out
      Output file. Optional . Default: stdout
    -p, --printSeq
      print mRNA & protein sequences
      Default: false
  * -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    --version
      print version and exit
```


## jvarkit_bam2haplotypes

### Tool Description
Create haplotypes from BAM files based on variants in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2haplotypes [options] Files
  Options:
    --alt
      How shall we handle ALT allele that are not in the VCF. skip, warn (skip 
      and warning), error (raise an error), N (replace with 'N')), all: use 
      all alleles.
      Default: all
      Possible Values: [skip, warn, error, N, all]
    --buffer-size
      When we're looking for variants in a lare VCF file, load the variants in 
      an interval of 'N' bases instead of doing a random access for each 
      variant. 
      Default: 1000
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    --ignore-discordant-rg
      In paired mode, ignore discordant read-groups RG-ID.
      Default: false
    --maxRecordsInRam
      When writing  files that need to be sorted, this will specify the number 
      of records stored in RAM before spilling to disk. Increasing this number 
      reduces the number of file  handles needed to sort a file, and increases 
      the amount of RAM needed
      Default: 50000
    -o, --out
      Output file. Optional . Default: stdout
    --paired
      Activate Paired-end mode. Variant can be supported by the read or/and is 
      mate. Input must be sorted on query name using for example 'samtools 
      collate'. 
      Default: false
    -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    --regions
      Limit analysis to this interval. A source of intervals. The following 
      suffixes are recognized: vcf, vcf.gz bed, bed.gz, gtf, gff, gff.gz, 
      gtf.gz.Otherwise it could be an empty string (no interval) or a list of 
      plain interval separated by '[ \t\n;,]'
    --tmpDir
      tmp working directory. Default: java.io.tmpDir
      Default: []
    --validation-stringency
      SAM Reader Validation Stringency
      Default: LENIENT
      Possible Values: [STRICT, LENIENT, SILENT]
  * -V, --vcf
      Indexed VCf file. Only diallelic SNP will be considered.
    --version
      print version and exit
```


## jvarkit_bam2raster

### Tool Description
Create raster images from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2raster [options] Files
  Options:
    -clip, --clip
      Show clipping
      Default: false
    -depth, --depth
      Depth track height.
      Default: 100
    --groupby
      Group Reads by. Data partitioning using the SAM Read Group (see 
      https://gatkforums.broadinstitute.org/gatk/discussion/6472/ ) . It can 
      be any combination of sample, library....
      Default: sample
      Possible Values: [readgroup, sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center, any]
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    --highlight
      hightligth those positions.
      Default: []
    --mapqopacity
      How to handle the MAPQ/ opacity of the reads. all_opaque: no opacity, 
      handler 1: transparency under MAPQ=60
      Default: handler1
      Possible Values: [all_opaque, handler1]
    --limit, --maxrows
      Limit number of rows to 'N' lines. negative: no limit.
      Default: -1
    -minh, --minh
      Min. distance between two reads.
      Default: 2
    -N, --name
      print read name instead of base
      Default: false
    --noReadGradient
      Do not use gradient for reads
      Default: false
    -nobase, --nobase
      hide bases
      Default: false
    -o, --output
      Output file. Optional . Default: stdout [20180829] filename can be also 
      an existing directory or a zip file, in witch case, each individual will 
      be saved in the zip/dir.
    -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
  * -r, --region
      Restrict to that region. An interval as the following syntax : 
      "chrom:start-end" or "chrom:middle+extend"  or "chrom:start-end+extend" 
      or "chrom:start-end+extend-percent%".A program might use a Reference 
      sequence to fix the chromosome name (e.g: 1->chr1)
    -srf, --samRecordFilter
      A filter expression. Reads matching the expression will be filtered-out. 
      Empty String means 'filter out nothing/Accept all'. See https://github.com/lindenb/jvarkit/blob/master/src/main/resources/javacc/com/github/lindenb/jvarkit/util/bio/samfilter/SamFilterParser.jj 
      for a complete syntax. 'default' is 'mapqlt(1) || Duplicate() || 
      FailsVendorQuality() || NotPrimaryAlignment() || 
      SupplementaryAlignment()' 
      Default: mapqlt(1) || Duplicate() || FailsVendorQuality() || NotPrimaryAlignment() || SupplementaryAlignment()
    --spaceyfeature
      number of pixels between features
      Default: 4
    -V, --variants, --vcf
      VCF files used to fill the position to hightlight with POS
      Default: []
    --version
      print version and exit
    -w, --width
      Image width
      Default: 1000
```


## jvarkit_bam2sql

### Tool Description
Convert BAM files to SQL

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2sql [options] Files
  Options:
    -c, --cigar
      print cigar data
      Default: false
    -f, --flag
      expands details about sam flag
      Default: false
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    -o, --out
      Output file. Optional . Default: stdout
  * -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    -r, --region
      An interval as the following syntax : "chrom:start-end" or 
      "chrom:middle+extend"  or "chrom:start-end+extend" or 
      "chrom:start-end+extend-percent%".A program might use a Reference 
      sequence to fix the chromosome name (e.g: 1->chr1)
      Default: <empty string>
    --version
      print version and exit
```


## jvarkit_bam2svg

### Tool Description
Create SVG images from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2svg [options] Files
  Options:
    --bases
      print bases in read
      Default: false
    --gff, --gff3
      Optional Tabix indexed GFF3 file.
    --groupby
      Group Reads by. Data partitioning using the SAM Read Group (see 
      https://gatkforums.broadinstitute.org/gatk/discussion/6472/ ) . It can 
      be any combination of sample, library....
      Default: sample
      Possible Values: [readgroup, sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center, any]
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
  * -i, --interval, --region
      An interval as the following syntax : "chrom:start-end" or 
      "chrom:middle+extend"  or "chrom:start-end+extend" or 
      "chrom:start-end+extend-percent%".A program might use a Reference 
      sequence to fix the chromosome name (e.g: 1->chr1)
    --mapq
      min mapping quality
      Default: 1
  * -o, --output
      An existing directory or a filename ending with the '.zip' or '.tar' or 
      '.tar.gz' suffix.
    --prefix
      file prefix
      Default: <empty string>
  * -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    -c, --showclipping, --clip
      Show clipping
      Default: false
    -S, --vcf
      Indexed VCF. the Samples's name must be the same than in the BAM
    --version
      print version and exit
    -w, --width
      Page width
      Default: 1000
    -D
      custom parameters. '-Dkey=value'. Undocumented.
      Syntax: -Dkey=value
      Default: {}
```


## jvarkit_bam2xml

### Tool Description
Convert BAM to XML

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/jvarkit: line 9: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
[SEVERE][MultiBamLauncher]java.nio.file.NoSuchFileException: -help
htsjdk.samtools.util.RuntimeIOException: java.nio.file.NoSuchFileException: -help
	at htsjdk.samtools.PathInputResource$1.get(SamInputResource.java:370)
	at htsjdk.samtools.PathInputResource$1.get(SamInputResource.java:364)
	at htsjdk.samtools.util.Lazy.get(Lazy.java:25)
	at htsjdk.samtools.PathInputResource.asUnbufferedSeekableStream(SamInputResource.java:412)
	at htsjdk.samtools.PathInputResource.asUnbufferedInputStream(SamInputResource.java:417)
	at htsjdk.samtools.SamReaderFactory$SamReaderFactoryImpl.open(SamReaderFactory.java:377)
	at htsjdk.samtools.SamReaderFactory.open(SamReaderFactory.java:106)
	at htsjdk.samtools.SamReaderFactory.open(SamReaderFactory.java:90)
	at com.github.lindenb.jvarkit.jcommander.MultiBamLauncher.doWork(MultiBamLauncher.java:215)
	at com.github.lindenb.jvarkit.util.jcommander.Launcher.instanceMain(Launcher.java:735)
	at com.github.lindenb.jvarkit.util.jcommander.Launcher.instanceMainWithExit(Launcher.java:898)
	at com.github.lindenb.jvarkit.tools.bam2xml.Bam2Xml.main(Bam2Xml.java:480)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at com.github.lindenb.jvarkit.tools.jvarkit.JvarkitCentral$Command.execute(JvarkitCentral.java:355)
	at com.github.lindenb.jvarkit.tools.jvarkit.JvarkitCentral.run(JvarkitCentral.java:911)
	at com.github.lindenb.jvarkit.tools.jvarkit.JvarkitCentral.main(JvarkitCentral.java:922)
Caused by: java.nio.file.NoSuchFileException: -help
	at java.base/sun.nio.fs.UnixException.translateToIOException(UnixException.java:92)
	at java.base/sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:106)
	at java.base/sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:111)
	at java.base/sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:262)
	at java.base/java.nio.file.Files.newByteChannel(Files.java:380)
	at java.base/java.nio.file.Files.newByteChannel(Files.java:432)
	at htsjdk.samtools.seekablestream.SeekablePathStream.<init>(SeekablePathStream.java:39)
	at htsjdk.samtools.PathInputResource$1.get(SamInputResource.java:368)
	... 16 more
[INFO][Launcher]bam2xml Exited with failure (-1)
```


## jvarkit_bamclip2insertion

### Tool Description
Clip reads to a given insertion point and output them as BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/jvarkit: line 9: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
[SEVERE][BamClipToInsertion]java.io.FileNotFoundException: -help (No such file or directory)
htsjdk.samtools.util.RuntimeIOException: java.io.FileNotFoundException: -help (No such file or directory)
	at htsjdk.samtools.FileInputResource$1.get(SamInputResource.java:299)
	at htsjdk.samtools.FileInputResource$1.get(SamInputResource.java:293)
	at htsjdk.samtools.util.Lazy.get(Lazy.java:25)
	at htsjdk.samtools.FileInputResource.asUnbufferedSeekableStream(SamInputResource.java:334)
	at htsjdk.samtools.FileInputResource.asUnbufferedInputStream(SamInputResource.java:342)
	at htsjdk.samtools.SamReaderFactory$SamReaderFactoryImpl.open(SamReaderFactory.java:377)
	at com.github.lindenb.jvarkit.util.jcommander.Launcher.openSamReader(Launcher.java:850)
	at com.github.lindenb.jvarkit.tools.misc.BamClipToInsertion.doWork(BamClipToInsertion.java:218)
	at com.github.lindenb.jvarkit.util.jcommander.Launcher.instanceMain(Launcher.java:735)
	at com.github.lindenb.jvarkit.util.jcommander.Launcher.instanceMainWithExit(Launcher.java:898)
	at com.github.lindenb.jvarkit.tools.misc.BamClipToInsertion.main(BamClipToInsertion.java:314)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at com.github.lindenb.jvarkit.tools.jvarkit.JvarkitCentral$Command.execute(JvarkitCentral.java:355)
	at com.github.lindenb.jvarkit.tools.jvarkit.JvarkitCentral.run(JvarkitCentral.java:911)
	at com.github.lindenb.jvarkit.tools.jvarkit.JvarkitCentral.main(JvarkitCentral.java:922)
Caused by: java.io.FileNotFoundException: -help (No such file or directory)
	at java.base/java.io.RandomAccessFile.open0(Native Method)
	at java.base/java.io.RandomAccessFile.open(RandomAccessFile.java:366)
	at java.base/java.io.RandomAccessFile.<init>(RandomAccessFile.java:285)
	at java.base/java.io.RandomAccessFile.<init>(RandomAccessFile.java:231)
	at htsjdk.samtools.seekablestream.SeekableFileStream.<init>(SeekableFileStream.java:47)
	at htsjdk.samtools.FileInputResource$1.get(SamInputResource.java:297)
	... 15 more
[INFO][Launcher]bamclip2insertion Exited with failure (-1)
```


## jvarkit_bamcmpcoverage

### Tool Description
Calculate coverage statistics for BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bamcmpcoverage [options] Files
  Options:
    -b, --bed
      restrict to region
    --filter
      A JEXL Expression that will be used to filter out some sam-records (see 
      https://software.broadinstitute.org/gatk/documentation/article.php?id=1255). 
      An expression should return a boolean value (true=exclude, false=keep 
      the read). An empty expression keeps everything. The variable 'record' 
      is the current observed read, an instance of SAMRecord (https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/SAMRecord.html).
      Default: record.getMappingQuality()<1 || record.getDuplicateReadFlag() || record.getReadFailsVendorQualityCheckFlag() || record.isSecondaryOrSupplementary()
    --groupby
      Group Reads by. Data partitioning using the SAM Read Group (see 
      https://gatkforums.broadinstitute.org/gatk/discussion/6472/ ) . It can 
      be any combination of sample, library....
      Default: sample
      Possible Values: [readgroup, sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center, any]
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    -M, --maxDepth
      max depth
      Default: 1000
    -m, --minDepth
      min depth
      Default: 0
    -o, --output
      Output file. Optional . Default: stdout
    -r, --region
      restrict to region
    --version
      print version and exit
    -w, --width
      image width
      Default: 1000
```


## jvarkit_bamliftover

### Tool Description
LiftOver BAM/SAM/CRAM files to a new reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bamliftover [options] Files
  Options:
    --bamcompression
      Compression Level. 0: no compression. 9: max compression;
      Default: 5
  * -f, --chain
      LiftOver file.
  * -R2, --destination-dict
      A SAM Sequence dictionary source: it can be a *.dict file, a fasta file 
      indexed with 'picard CreateSequenceDictionary' or 'samtools dict', or 
      any hts file containing a dictionary (VCF, BAM, CRAM, intervals...)
    --drop-seq
      drop SEQ and QUAL
      Default: false
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    -m, --minmatch
      lift over min-match.
      Default: 0.95
    -o, --out
      Output file. Optional . Default: stdout
    -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    --regions
      Limit analysis to this interval. A source of intervals. The following 
      suffixes are recognized: vcf, vcf.gz bed, bed.gz, gtf, gff, gff.gz, 
      gtf.gz.Otherwise it could be an empty string (no interval) or a list of 
      plain interval separated by '[ \t\n;,]'
    --samoutputformat
      Sam output format.
      Default: SAM
      Possible Values: [BAM, SAM, CRAM]
    --save-position
      Save original position in SMA attribute
      Default: false
    --unmapped
      discard unmapped reads/unlifted reads
      Default: false
    --validation-stringency
      SAM Reader Validation Stringency
      Default: LENIENT
      Possible Values: [STRICT, LENIENT, SILENT]
    --version
      print version and exit
```


## jvarkit_bammatrix

### Tool Description
Create a matrix of read counts per region.

### Metadata
- **Docker Image**: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
- **Homepage**: https://github.com/lindenb/jvarkit
- **Package**: https://anaconda.org/channels/bioconda/packages/jvarkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bammatrix [options] Files
  Options:
    --color-scale
      Color scale
      Default: LOG
      Possible Values: [LINEAR, LOG]
    -d, --distance
      Don't evaluate a point if the distance between the regions is lower than 
      'd'. Negative: don't consider distance.
      Default: -1
    --gtf, -g
      Optional gtf file to draw the exons. A GTF (General Transfer Format) 
      file. See https://www.ensembl.org/info/website/upload/gff.html . Please 
      note that CDS are only detected if a start and stop codons are defined.
    -h, --help
      print help and exit
    --helpFormat
      What kind of help. One of [usage,markdown,xml].
    --higligth, -B
      Optional Bed file to hightlight regions of interest
    --mapq
      minimal mapping quality
      Default: 30
    -C, --min-common
      Don't print a point if there are less than 'c' common names at the 
      intersection 
      Default: 0
    --name, -name
      user read name or use 'BX:Z:'/'MI:i:' attribute from 10x genomics  as 
      the read name. "Chromium barcode sequence that is error-corrected and 
      confirmed against a list of known-good barcode sequences.". See https://support.10xgenomics.com/genome-exome/software/pipelines/latest/output/bam
      Default: READ_NAME
      Possible Values: [READ_NAME, BX, MI]
    --no-coverage
      Don't print coverage
      Default: false
    -o, --output
      Output file. Optional . Default: stdout
    --pixel
      pixel size. Each dot at intersection will have the following size
      Default: 1
    -R, --reference
      Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
  * -r, -r1, --region
      first region.An interval as the following syntax : "chrom:start-end" or 
      "chrom:middle+extend"  or "chrom:start-end+extend" or 
      "chrom:start-end+extend-percent%".A program might use a Reference 
      sequence to fix the chromosome name (e.g: 1->chr1)
    -r2, --region2
      2nd region. Default: use first region. An interval as the following 
      syntax : "chrom:start-end" or "chrom:middle+extend"  or 
      "chrom:start-end+extend" or "chrom:start-end+extend-percent%".A program 
      might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)
    -sa, --sa
      Use other canonical alignements from the 'SA:Z:*' attribute
      Default: false
    -s, --size
      matrix size in pixel
      Default: 1000
    -su, --supplementary
      Use other supplementary alignements
      Default: false
    --version
      print version and exit
```

