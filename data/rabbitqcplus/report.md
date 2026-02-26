# rabbitqcplus CWL Generation Report

## rabbitqcplus

### Tool Description
RabbitQCPlus

### Metadata
- **Docker Image**: quay.io/biocontainers/rabbitqcplus:2.3.0--h5ca1c30_1
- **Homepage**: https://github.com/RabbitBio/RabbitQCPlus
- **Package**: https://anaconda.org/channels/bioconda/packages/rabbitqcplus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rabbitqcplus/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabbitBio/RabbitQCPlus
- **Stars**: N/A
### Original Help Text
```text
RabbitQCPlus
Usage: rabbitqcplus [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -i,--inFile1 TEXT           input fastq name 1
  -I,--inFile2 TEXT           input fastq name 2
  -o,--outFile1 TEXT          output fastq name 1
  -O,--outFile2 TEXT          output fastq name 2
  --notKeepOrder              do not keep order as input when outputting reads (may slightly improve performance if opened), default is off
  --compressLevel INT         output file compression level (1 - 9), default is 4
  --useIgzip                  use igzip instead of pugz/zlib, default is off
  --overWrite                 overwrite out file if already exists.
  --phred64                   input is using phred64 scoring, default is phred33
  --stdin                     input from stdin, or -i /dev/stdin, only for se data or interleaved pe data(which means use --interleavedIn)
  --stdout                    output to stdout, or -o /dev/stdout, only for se data or interleaved pe data(which means use --interleavedOut)
  -w,--threadNum INT          number of thread used to do QC, including (de)compression for compressed data, default is 8
  --TGS                       process third generation sequencing (TGS) data (only for se data, does not support trimming and will not produce output files), default is off
  --noInsertSize              no insert size analysis (only for pe data), default is to do insert size analysis
  --interleavedIn             use interleaved input (only for pe data), default is off
  --interleavedOut            use interleaved output (only for pe data), default is off
  --pugzThread INT            pugz thread number for each input file, automatic assignment according to the number of total threads (-w) by default. Note: must >=2 threads when specified manually
                              
  --pigzThread INT            pigz thread number for each output file, automatic assignment according to the number of total threads (-w) by default. Note: must >=2 threads when specified manually
                              
  -V,--version                application version


Trim Adapter:
  -a,--noTrimAdapter          don't trim adapter, default is off
  --decAdaForSe               detect adapter for se data, default is on
  --decAdaForPe               detect adapter for pe data, default is off, tool prefers to use overlap to find adapter
  --printWhatTrimmed          if print what trimmed to *_trimmed_adapters.txt or not, default is not
  --adapterSeq1 TEXT          specify adapter sequence for read1
  --adapterSeq2 TEXT          specify adapter sequence for read2
  --adapterFastaFile TEXT     specify adapter sequences use fasta file


Filter:
  -5,--trim5End               do sliding window from 5end to 3end to trim low quality bases, default is off
  -3,--trim3End               do sliding window from 5end to 3end to trim low quality bases, default is off
  --trimFront1 INT            number of bases to trim from front in read1, default is 0
  --trimFront2 INT            number of bases to trim from front in read2, default is 0
  --trimTail1 INT             number of bases to trim from tail in read1, default is 0
  --trimTail2 INT             number of bases to trim from tail in read2, default is 0
  -g,--trimPolyg              do polyg tail trim, default is off
  -x,--trimPolyx              do polyx tail trim, default is off


UMI Operation:
  -u,--addUmi                 do unique molecular identifier (umi) processing, default is off
  --umiLen INT                umi length if it is in read1/read2, default is 0
  --umiLoc TEXT               specify the location of umi, can be (index1/index2/read1/read2/per_index/per_read), default is 0
  --umiPrefix TEXT            identification to be added in front of umi, default is no prefix
  --umiSkip INT               the number bases to skip if umi exists, default is 0


Over-representation Operation:
  -p,--doOverrepresentation   do over-representation sequence analysis, default is off
  -P,--overrepresentationSampling INT
                              do overrepresentation every [] reads, default is 20
  --printORPSeqs              if print overrepresentation sequences to *ORP_sequences.txt or not, default is not


Error Correction Operation:
  --correctData               sample correcting low quality bases using information from overlap (faster but less accurate), default is off
  --correctWithCare           correct data use care engine (slower but much more accurate), default is off
  --pairmode TEXT             SE (single-end) or PE (paired-end), default is SE
  --coverage INT              Estimated coverage of input file (i.e. number_of_reads * read_length / genome_size)
  --hashmaps INT              The requested number of hash maps. Must be greater than 0. The actual number of used hash maps may be lower to respect the set memory limit, default is 48
  --kmerlength INT            The kmer length for minhashing. If 0 or missing, it is automatically determined, default is 0
  --enforceHashmapCount       If the requested number of hash maps cannot be fulfilled, the program terminates without error correction, default is off
  --useQualityScores          If set, quality scores (if any) are considered during read correction, default is off
  --qualityScoreBits INT      How many bits should be used to store a single quality score. Allowed values: 1,2,8. If not 8, a lossy compression via binning is used, default is 8
  --excludeAmbiguous          If set, reads which contain at least one ambiguous nucleotide will not be corrected, default is off
  --maxmismatchratio FLOAT    Overlap between anchor and candidate must contain at most (maxmismatchratio * overlapsize) mismatches, default is 0.2
  --minalignmentoverlap INT   Overlap between anchor and candidate must be at least this long, default is 30
  --minalignmentoverlapratio FLOAT
                              Overlap between anchor and candidate must be at least as long as (minalignmentoverlapratio * candidatelength), default is 0.3
  --errorfactortuning FLOAT   errorfactortuning, default is 0.06
  --coveragefactortuning FLOAT
                              coveragefactortuning, default is 0.6
  --showProgress              If set, progress bar is shown during correction, default is off
  --tempdir TEXT              Directory to store temporary files, default is the output directory
  --save-preprocessedreads-to TEXT
                              Save binary dump of data structure which stores input reads to disk
  --load-preprocessedreads-from TEXT
                              Load binary dump of read data structure from disk
  --save-hashtables-to TEXT   Save binary dump of hash tables to disk
  --load-hashtables-from TEXT Load binary dump of hash tables from disk
  --memHashtables TEXT        Memory limit in bytes for hash tables and hash table construction. Can use suffix K,M,G, e.g. 20G means 20 gigabyte. This option is not a hard limit, default is a bit less than memory
  --memTotal TEXT             Total memory limit in bytes. Can use suffix K,M,G, e.g. 20G means 20 gigabyte. This option is not a hard limit, default is all free memory
  --hashloadfactor FLOAT      Load factor of hashtables. 0.0 < hashloadfactor < 1.0. Smaller values can improve the runtime at the expense of greater memory usage, default is 0.8
  --fixedNumberOfReads INT    Process only the first n reads, default is 0
  --singlehash                Use 1 hashtables with h smallest unique hashes, default is off
  --correctionQualityLabels   If set, correction quality label will be appended to output read headers, default is off
  --candidateCorrection       If set, candidate reads will be corrected,too, default is off
  --candidateCorrectionNewColumns INT
                              If candidateCorrection is set, a candidates with an absolute shift of candidateCorrectionNewColumns compared to anchor are corrected, default is 15
  --correctionType INT        0: Classic, 2: Print . Print is only supported in the cpu version, default is 0
  --correctionTypeCands INT   0: Classic, 2: Print. Print is only supported in the cpu version, default is 0
```

