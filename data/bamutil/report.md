# bamutil CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bamutil_bam2FastQ | PASS |  |
| bamutil_clipOverlap | PASS |  |
| bamutil_convert | PASS |  |
| bamutil_dedup | PASS |  |
| bamutil_dedup_LowMem | PASS |  |
| bamutil_diff | PASS |  |
| bamutil_dumpHeader | PASS |  |
| bamutil_dumpIndex | PASS |  |
| bamutil_dumpRefInfo | PASS |  |
| bamutil_filter | PASS |  |
| bamutil_findCigars | PASS |  |
| bamutil_gapInfo | PASS |  |
| bamutil_mergeBam | PASS |  |
| bamutil_polishBam | PASS |  |
| bamutil_readReference | PASS |  |
| bamutil_recab | PASS |  |
| bamutil_revert | PASS |  |
| bamutil_splitBam | PASS |  |
| bamutil_splitChromosome | PASS |  |
| bamutil_squeeze | PASS |  |
| bamutil_stats | PASS |  |
| bamutil_trimBam | PASS |  |
| bamutil_validate | PASS |  |
| bamutil_writeRegion | PASS |  |

## bamutil_convert

### Tool Description
Convert SAM/BAM to SAM/BAM

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 convert - Convert SAM/BAM to SAM/BAM
	./bam convert --in <inputFile> --out <outputFile.sam/bam/ubam (ubam is uncompressed bam)> [--refFile <reference filename>] [--useBases|--useEquals|--useOrigSeq] [--lshift] [--noeof] [--params]
	Required Parameters:
		--in         : the SAM/BAM file to be read
		--out        : the SAM/BAM file to be written
	Optional Parameters:
		--refFile    : reference file name
		--lshift     : left shift indels when writing records
		--noeof      : do not expect an EOF block on a bam file
		--params     : print the parameter settings
		--recover    : attempt error recovery while reading a bam file
	Optional Sequence Parameters (only specify one):
		--useOrigSeq : Leave the sequence as is (default & used if reference is not specified)
		--useBases   : Convert any '=' in the sequence to the appropriate base using the reference (requires --refFile)
		--useEquals  : Convert any bases that match the reference to '=' (requires --refFile)

Input Parameters
 --in [], --out [], --refFile [], --lshift, --noeof, --recover, --params
   SequenceConversion : --useBases, --useEquals, --useOrigSeq
            PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_writeRegion

### Tool Description
Write a file with reads in the specified region and/or have the specified read name

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 writeRegion - Write a file with reads in the specified region and/or have the specified read name
	./bam writeRegion --in <inputFilename>  --out <outputFilename> [--bamIndex <bamIndexFile>] [--refName <reference Name> | --refID <reference ID>] [--start <0-based start pos>] [--end <0-based end psoition>] [--bed <bed filename>] [--withinRegion] [--readName <readName>] [--rnFile <readNameFileName>] [--lshift] [--params] [--noeof]
	Required Parameters:
		--in        : the BAM file to be read
		--out       : the SAM/BAM file to write to
	Optional Parameters for Specifying a Region:
		--bamIndex  : the path/name of the bam index file
		              (if not specified, uses the --in value + ".bai")
		--refName   : the BAM reference Name to read
		              Either this or refID can be specified.
		              Defaults to all references.
		--refID     : the BAM reference ID to read.
		              Either this or refName can be specified.
		              Defaults to all references.
		              Specify -1 for unmapped
		--start     : inclusive 0-based start position.
		              Defaults to -1: meaning from the start of the reference.
		              Only applicable if refName/refID is set.
		--end       : exclusive 0-based end position.
		              Defaults to -1: meaning til the end of the reference.
		              Only applicable if refName/refID is set.
		--bed       : use the specified bed file for regions.
		--withinReg : only print reads fully enclosed within the region.
		--readName  : only print reads with this read name.
		--rnFile    : only print reads with read names found in the specified file,
		              delimited by comma, space, tab, or new line (',', ' ', '\t', or '\n').
	Optional Parameters For Other Operations:
		--lshift        : left shift indels when writing records
		--excludeFlags  : Skip any records with any of the specified flags set
		                  (specify an integer representation of the flags)
		--requiredFlags : Only process records with all of the specified flags set
		                  (specify an integer representation of the flags)
		--params        : print the parameter settings
		--noeof         : do not expect an EOF block on a bam file.

Input Parameters
          Required Parameters : --in [], --out []
   Optional Region Parameters : --bamIndex [], --refName [], --refID [-2],
                                --start [-1], --end [-1], --bed [],
                                --withinReg, --readName [], --rnFile []
    Optional Other Parameters : --lshift, --excludeFlags [],
                                --requiredFlags [], --noeof, --params
                    PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

Missing mandatory argument: --in
```

## bamutil_splitChromosome

### Tool Description
Split BAM by Chromosome

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 splitChromosome - Split BAM by Chromosome
	./bam splitChromosome --in <inputFilename>  --out <outputFileBaseName> [--noeof] [--bamout|--samout] [--params]
	Required Parameters:
		--in       : the BAM file to be split
		--out      : the base filename for the SAM/BAM files to write into.  Does not include the extension.
                 CHROM.bam or CHROM.sam will be appended to the basename where CHROM is the chromosome name.
	Optional Parameters:
		--noeof  : do not expect an EOF block on a bam file.
		--bamout : write the output files in BAM format (default).
		--samout : write the output files in SAM format.
		--params : print the parameter settings

Input Parameters
 --in [], --out [], --noeof, --params
   Output Type : --bamout [ON], --samout
     PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_splitBam

### Tool Description
Split a BAM file into multiple BAM files based on ReadGroup

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 splitBam - Split a BAM file into multiple BAM files based on ReadGroup
	 ./bam splitBam [-v] -i <inputBAMFile> -o <outPrefix> [-L logFile]
splitBam splits a BAM file into multiple BAM files based on
ReadGroup according to the following details.
	(1) Creates multiple output files named [outprefix].[RGID].bam, for
	each ReadGroup ID (RGID) in the BAM record
	(2) Headers are a copy of the original file, removing @RG and @PG
	headers where IDs match with the other ReadGroup IDs.
	(3) Copy each of the original file's BAM record to one of the output
file where the ReadGroup ID matches
Required arguments:
-i/--in [inputBAMFile] : Original BAM file containing readGroup info
-o/--out [outPrefix] : prefix of output bam files of [outprefix].[RGID].bam
Optional arguments:
-L/--log [logFile]  : log file name. default is listFile.log
-v/--verbose : turn on verbose mode
-n/--noeof : turn off the check for an EOF block at the end of a bam file
ERROR: At least one of the required argument is missing
ERROR : At least one of the required argument is missing
Exiting due to ERROR:
	ERROR: At least one of the required argument is missing
```

## bamutil_findCigars

### Tool Description
Output just the reads that contain any of the specified CIGAR operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 findCigars - Output just the reads that contain any of the specified CIGAR operations.
	./bam findCigars --in <inputFile> --out <outputFile.sam/bam/ubam (ubam is uncompressed bam)> [--cinsert] [--cdel] [--cpad] [--cskip] [--chardClip] [--csoftClip] [--nonM] [--noeof] [--params]
	Required Parameters:
		--in         : the SAM/BAM file to be read
		--out        : the SAM/BAM file to be written
	Optional Parameters:
		--cinsert     : output reads that contain insertions ('I').
		--cdel        : output reads that contain deletions ('D').
		--cpad        : output reads that contain pads ('P').
		--cskip       : output reads that contain skips ('N').
		--chardClip   : output reads that contain hard clips ('H').
		--csoftClip   : output reads that contain soft clips ('S').
		--nonM       : output reads that contain any non match/mismatch (anything other than 'M', '=', 'X')
		--noeof      : do not expect an EOF block on a bam file.
		--params     : print the parameter settings

Input Parameters
 --in [], --out [], --cinsert, --cdel, --cpad, --cskip, --chardClip,
               --csoftClip, --nonM, --noeof, --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_clipOverlap

### Tool Description
Clip overlapping read pairs in a SAM/BAM File already sorted by Coordinate or ReadName

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 clipOverlap - Clip overlapping read pairs in a SAM/BAM File already sorted by Coordinate or ReadName
	./bam clipOverlap --in <inputFile> --out <outputFile> [--storeOrig <tag>] [--readName] [--noRNValidate] [--stats] [--overlapsOnly] [--excludeFlags <flag>] [--poolSize <numRecords allowed to allocate>] [--poolSkipOverlap] [--noeof] [--params]
	Required Parameters:
		--in           : the SAM/BAM file to clip overlaping read pairs for
		--out          : the SAM/BAM file to be written
	Optional Parameters:
		--storeOrig    : Store the original cigar in the specified tag.
		--readName     : Original file is sorted by Read Name instead of coordinate.
		--noRNValidate   : Turn off alpha-numeric read name sorting validation.
		--stats        : Print some statistics on the overlaps.
		--overlapsOnly : Only output overlapping read pairs
		--excludeFlags : Skip records with any of the specified flags set, default 0xF0C
		--unmapped     : Mark records that would be completely clipped as unmapped
		--noeof        : Do not expect an EOF block on a bam file.
		--params       : Print the parameter settings to stderr
	Clipping By Coordinate Optional Parameters:
		--poolSize     : Maximum number of records the program is allowed to allocate
		                 for clipping on Coordinate sorted files. (Default: 1000000)
		--poolSkipClip : Skip clipping reads to free of usable records when the
		                 poolSize is hit. The default action is to just clip the
		                 first read in a pair to free up the record.

Input Parameters
                         Required Parameters : --in [], --out []
                         Optional Parameters : --storeOrig [], --readName,
                                               --noRNValidate, --stats,
                                               --overlapsOnly,
                                               --excludeFlags [0xF0C],
                                               --unmapped, --noeof, --params
   Coordinate Processing Optional Parameters : --poolSize [1000000],
                                               --poolSkipOverlap
                                   PhoneHome : --noPhoneHome,
                                               --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_filter

### Tool Description
Filter reads by clipping ends with too high of a mismatch percentage and by marking reads unmapped if the quality of mismatches is too high

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 filter - Filter reads by clipping ends with too high of a mismatch percentage and by marking reads unmapped if the quality of mismatches is too high
	./bam filter --in <inputFilename>  --refFile <referenceFilename>  --out <outputFilename> [--noeof] [--qualityThreshold <qualThresh>] [--defaultQualityInt <defaultQual>] [--mismatchThreshold <mismatchThresh>] [--params]
	Required Parameters:
		--in       : the SAM/BAM file to be read
		--refFile  : the reference file
		--out      : the SAM/BAM file to write to
	Optional Parameters:
		--noeof             : do not expect an EOF block on a bam file.
		--qualityThreshold  : maximum sum of the mismatch qualities before marking
		                      a read unmapped. (Defaults to 60)
		--defaultQualityInt : quality value to use for mismatches that do not have a quality
		                      (Defaults to 20)
		--mismatchThreshold : decimal value indicating the maximum ratio of mismatches to
		                      matches and mismatches allowed before clipping from the ends
		                      (Defaults to .10)
		--params            : print the parameter settings

Input Parameters
 --in [], --out [-], --refFile [], --noeof, --qualityThreshold [60],
               --defaultQualityInt [20], --mismatchThreshold [0.10], --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_revert

### Tool Description
Revert SAM/BAM replacing the specified fields with their previous values (if known) and removes specified tags

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 revert - Revert SAM/BAM replacing the specified fields with their previous values (if known) and removes specified tags
	./bam revert --in <inputFile> --out <outputFile.sam/bam/ubam (ubam is uncompressed bam)> [--cigar] [--qual] [--keepTags] [--rmBQ] [--rmTags <Tag:Type[,Tag:Type]*>] [--noeof] [--params]
	Required Parameters:
		--in         : the SAM/BAM file to be read
		--out        : the SAM/BAM file to be written
	Optional Parameters:
		--cigar      : update the cigar and the position based on the OC & OP tags.
		--qual       : update the quality based on the OQ tag.
		--keepTags   : keep the tags that are used to update the record.  Default is to remove them.
		--rmBQ       : Remove the BQ Tag.
		--rmTags     : Remove the specified Tags formatted as Tag:Type,Tag:Type,Tag:Type...
		--noeof      : do not expect an EOF block on a bam file.
		--params     : print the parameter settings

Input Parameters
 --in [], --out [], --cigar, --qual, --keepTags, --rmBQ, --rmTags [], --noeof,
               --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_squeeze

### Tool Description
Reduces files size by dropping OQ fields, duplicates, & specified tags, using '=' when a base matches the reference, binning quality scores, and replacing readNames with unique integers

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 squeeze -  reduces files size by dropping OQ fields, duplicates, & specified tags, using '=' when a base matches the reference, binning quality scores, and replacing readNames with unique integers
	./bam squeeze --in <inputFile> --out <outputFile.sam/bam/ubam (ubam is uncompressed bam)> [--refFile <refFilePath/Name>] [--keepOQ] [--keepDups] [--readName <readNameMapFile.txt>] [--sReadName <readNameMapFile.txt>] [--rmTags <Tag:Type[,Tag:Type]*>] [--noeof] [--params] [--binQualS <minQualBin2>,<minQualBin3><...>] [--binQualF <filename>] [--binMid|binHigh|binCustom]
	Required Parameters:
		--in         : the SAM/BAM file to be read
		--out        : the SAM/BAM file to be written
	Optional Parameters:
		--refFile    : reference file name used to convert any bases that match the reference to '='
		--keepOQ     : keep the OQ tag rather than removing it.  Default is to remove it.
		--keepDups   : keep duplicates rather than removing records marked duplicate.  Default is to remove them.
		--sReadName  : Replace read names with unique integers and write the mapping to the specified file.
                   This version requires the input file to have been presorted by readname, but
                   no validation is done to ensure this.  If it is not sorted, a readname will
                   get mapped to multiple new values.
		--readName   : Replace read names with unique integers and write the mapping to the specified file.
                   This version does not require the input file to have been presorted by readname,
                   but uses a lot of memory since it stores all the read names.
		--rmTags     : Remove the specified Tags formatted as Tag:Type,Tag:Type,Tag:Type...
		--noeof      : do not expect an EOF block on a bam file.
		--params     : print the parameter settings
	Quality Binning Parameters (optional):
	  Bin qualities by phred score, into the ranges specified by binQualS or binQualF (both cannot be used)
	  Ranges are specified by comma separated minimum phred score for the bin, example: 1,17,20,30,40,50,70
	  The first bin always starts at 0, so does not need to be specified.
	  By default, the bin value is the low end of the range.
		--binQualS   : Bin the Qualities as specified (phred): minQualOfBin2, minQualofBin3...
		--binQualF   : Bin the Qualities based on the specified file
		--binCustom  : Use the custom point of the quality bin (followed by colon) for the quality value of the bin.
		--binMid     : Use the mid point of the quality bin range for the quality value of the bin.
		--binHigh    : Use the high end of the quality bin range for the quality value of the bin.

Input Parameters
                   Required Parameters : --in [], --out []
                   Optional Parameters : --refFile [], --keepOQ, --keepDups,
                                         --readName [], --sReadName [],
                                         --rmTags [], --noeof, --params
                             PhoneHome : --noPhoneHome,
                                         --phoneHomeThinning [50]
   Optional Quality Binning Parameters : --binQualS [], --binQualF [],
                                         --binMid, --binCustom, --binHigh

--in is a mandatory argument, but was not specified
```

## bamutil_trimBam

### Tool Description
Trim the ends of reads in a SAM/BAM file changing read ends to 'N' and quality to '!' or softclipping the ends (resulting file will not be sorted)

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 trimBam - Trim the ends of reads in a SAM/BAM file changing read ends to 'N' and quality to '!' or softclipping the ends (resulting file will not be sorted)
	./bam trimBam [inFile] [outFile] [num-bases-to-trim-on-each-side]
Alternately, the number of bases from each side can be specified (either or both -L/-R (--left/--right) can be specified):
	./bam trimBam [inFile] [outFile] -L [num-bases-to-trim-from-left] -R [num-bases-to-trim-from-right]
By default reverse strands are reversed and then the left & right are trimmed .
This means that --left actually trims from the right of the read in the SAM/BAM for reverse reads.
Optionally --ignoreStrand/-i can be specified to ignore the strand information and treat forward/reverse the same.
trimBam will modify the sequences to 'N', and the quality string to '!', unless --clip/-c is specified.
--clip/-c indicates to soft clip instead of modifying the sequence or quality
	When clipping:
	  * if the entire read would be soft clipped, no clipping is done, and instead the read is marked as unmapped
	  * mate information is not updated (start positions/mapping may change after soft clipping)
	        * run samtools fixmate to fix mate information (will first need to sort by read name)
	  * output is not sorted (start positions/mapping may change after soft clipping)
	        * run samtools sort to resort by coordinate (after fixmate)
	  * soft clips already in the read are maintained or added to
	        * if 3 bases were clipped and 2 are specified to be clipped, no change is made to that end
	        * if 3 bases were clipped and 5 are specified to be clipped, 2 additional bases are clipped from that end
ERROR: Incorrect number of parameters specified
```

## bamutil_mergeBam

### Tool Description
merge multiple BAMs and headers appending ReadGroupIDs if necessary

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 mergeBam - merge multiple BAMs and headers appending ReadGroupIDs if necessary
Usage: mergeBam [-v] [--log logFile] [--ignorePI] --list <listFile> --out <outFile>

Required parameters :
--out/-o : Output BAM file (sorted)
--in/-i  : BAM file to be input, must be more than one of these options.
            cannot be used with --list/-l
--list/-l : RGAList File. Tab-delimited list consisting of following columns (with headers):
	BAM* : Input BAM file name to be merged
	ID* : Unique read group identifier
	SM* : Sample name
	LB : Library name
	DS : Description
	PU : Platform unit
	PI : Predicted median insert size
	CN : Name of sequencing center producing the read
	DT : Date the rn was produced
	PL : Platform/technology used to produce the read
	* (Required fields)
Optional parameters : 
--regions/-r : list of intervals, '<chr>:<start>-<end>', to merge separated by commas, ','
--regionFile/-R : file containing list of intervals, '<chr>:<start>-<end>', to merge, one per line
--ignorePI/-I : Ignore the RG PI field when comparing headers
--log/-L : Log file
--verbose/-v : Turn on verbose mode
ERROR: At least one of the required argument is missing
ERROR : At least one of the required argument is missing
Exiting due to ERROR:
	ERROR: At least one of the required argument is missing
```

## bamutil_polishBam

### Tool Description
adds/updates header lines & adds the RG tag to each record

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 polishBam - adds/updates header lines & adds the RG tag to each record
Usage: polishBam (options) --in <inBamFile> --out <outBamFile>

Required parameters : 
-i/--in : input BAM file
-o/--out : output BAM file
Optional parameters :
-v : turn on verbose mode
-l/--log : writes logfile with specified name.
--HD : add @HD header line
--RG : add @RG header line
--PG : add @PG header line
--CO : add @CO header line
-f/--fasta : fasta reference file to compute MD5sums and update SQ tags
--AS : AS tag for genome assembly identifier
--UR : UR tag for @SQ tag (if different from --fasta)
--SP : SP tag for @SQ tag
--checkSQ : check the consistency of SQ tags (SN and LN) with existing header lines. Must be used with --fasta option

ERROR: Input and output files are required
ERROR : Input and output files are required
Exiting due to ERROR:
	ERROR: Input and output files are required
```

## bamutil_dedup

### Tool Description
Mark Duplicates

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ./bam dedup --in <InputBamFile> --out <OutputBamFile> [--minQual <minPhred>] [--log <logFile>] [--oneChrom] [--rmDups] [--force] [--excludeFlags <flag>] [--verbose] [--noeof] [--params] [--recab] --refFile <ReferenceFile> [--dbsnp <dbsnpFile>] [--minBaseQual <minBaseQual>] [--maxBaseQual <maxBaseQual>] [--blended <weight>] [--fitModel] [--fast] [--keepPrevDbsnp] [--keepPrevNonAdjacent] [--useLogReg] [--qualField <tag>] [--storeQualTag <tag>] [--buildExcludeFlags <flag>] [--applyExcludeFlags <flag>] [--binQualS <minQualBin2>,<minQualBin3><...>] [--binQualF <filename>] [--binMid|binHigh|binCustom]

Required parameters :
	--in <infile>   : Input BAM file name (must be sorted)
	--out <outfile> : Output BAM file name (same order with original file)
Optional parameters : 
	--minQual <int> : Only add scores over this phred quality when determining a read's quality (default: 15)
	--log <logfile> : Log and summary statistics (default: [outfile].log, or stderr if --out starts with '-')
	--oneChrom      : Treat reads with mates on different chromosomes as single-ended.
	--rmDups        : Remove duplicates (default is to mark duplicates)
	--force         : Allow an already mark-duplicated BAM file, unmarking any previously marked 
	                  duplicates and apply this duplicate marking logic.  Default is to throw errors
	                  and exit when trying to run on an already mark-duplicated BAM
	--excludeFlags <flag>    : exclude reads with any of these flags set when determining or marking duplicates
	                           by default (0xB04): exclude unmapped, secondary reads, QC failures, and supplementary reads
	--verbose       : Turn on verbose mode
	--noeof         : Do not expect an EOF block on a bam file.
	--params        : Print the parameter settings
	--recab         : Recalibrate in addition to deduping

Recab Specific Required Parameters
	--refFile <reference file>    : reference file name
Recab Specific Optional Parameters : 
	--dbsnp <known variance file> : dbsnp file of positions
	--minBaseQual <minBaseQual>   : minimum base quality of bases to recalibrate (default: 5)
	--maxBaseQual <maxBaseQual>   : maximum recalibrated base quality (default: 50)
	                                qualities over this value will be set to this value.
	                                This setting is applied after binning (if applicable).
	--blended <weight>            : blended model weight
	--fitModel                    : check if the logistic regression model fits the data
	                                overriden by fast, but automatically applied by useLogReg
	--fast                        : use a compact representation that only allows:
	                                   * at most 256 Read Groups
	                                   * maximum quality 63
	                                   * at most 127 cycles
	                                overrides fitModel, but is overridden by useLogReg
	                                uses up to about 2.25G more memory than running without --fast.
	--keepPrevDbsnp               : do not exclude entries where the previous base is in dbsnp when
	                                building the recalibration table
	                                By default they are excluded from the table.
	--keepPrevNonAdjacent         : do not exclude entries where the previous base is not adjacent
	                                (not a Cigar M/X/=) when building the recalibration table
	                                By default they are excluded from the table (except the first cycle).
	--useLogReg                   : use logistic regression calculated quality for the new quality
	                                automatically applies fitModel and overrides fast.
	--qualField <quality tag>     : tag to get the starting base quality
	                                (default is to get it from the Quality field)
	--storeQualTag <quality tag>  : tag to store the previous quality into
	--buildExcludeFlags <flag>    : exclude reads with any of these flags set when building the
	                                recalibration table.  Default is 0xF04
	--applyExcludeFlags <flag>    : do not apply the recalibration table to any reads with any of these flags set
	Quality Binning Parameters (optional):
	  Bin qualities by phred score, into the ranges specified by binQualS or binQualF (both cannot be used)
	  Ranges are specified by comma separated minimum phred score for the bin, example: 1,17,20,30,40,50,70
	  The first bin always starts at 0, so does not need to be specified.
	  By default, the bin value is the low end of the range.
		--binQualS   : Bin the Qualities as specified (phred): minQualOfBin2, minQualofBin3...
		--binQualF   : Bin the Qualities based on the specified file
		--binCustom  : Use the custom point of the quality bin (followed by colon) for the quality value of the bin.
		--binMid     : Use the mid point of the quality bin range for the quality value of the bin.
		--binHigh    : Use the high end of the quality bin range for the quality value of the bin.

Input Parameters
                   Required Parameters : --in [], --out []
                   Optional Parameters : --minQual [15], --log [], --oneChrom,
                                         --recab, --rmDups, --force,
                                         --excludeFlags [0xB04], --verbose,
                                         --noeof, --params
                             PhoneHome : --noPhoneHome,
                                         --phoneHomeThinning [50]
             Required Recab Parameters : --refFile []
             Optional Recab Parameters : --dbsnp [], --minBaseQual [5],
                                         --maxBaseQual [50], --blended,
                                         --fitModel, --fast, --keepPrevDbsnp,
                                         --keepPrevNonAdjacent, --useLogReg,
                                         --qualField [], --storeQualTag [],
                                         --buildExcludeFlags [0x0F04],
                                         --applyExcludeFlags [0x0000]
   Optional Quality Binning Parameters : --binQualS [], --binQualF [],
                                         --binMid, --binCustom, --binHigh

Specify an input file
```

## bamutil_dedup_LowMem

### Tool Description
Mark Duplicates using only a little memory

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ./bam dedup_LowMem --in <InputBamFile> --out <OutputBamFile> [--minQual <minPhred>] [--log <logFile>] [--oneChrom] [--rmDups] [--force] [--excludeFlags <flag>] [--verbose] [--noeof] [--params] [--recab] --refFile <ReferenceFile> [--dbsnp <dbsnpFile>] [--minBaseQual <minBaseQual>] [--maxBaseQual <maxBaseQual>] [--blended <weight>] [--fitModel] [--fast] [--keepPrevDbsnp] [--keepPrevNonAdjacent] [--useLogReg] [--qualField <tag>] [--storeQualTag <tag>] [--buildExcludeFlags <flag>] [--applyExcludeFlags <flag>] [--binQualS <minQualBin2>,<minQualBin3><...>] [--binQualF <filename>] [--binMid|binHigh|binCustom]

Required parameters :
	--in <infile>   : Input BAM file name (must be sorted)
	--out <outfile> : Output BAM file name (same order with original file)
Optional parameters : 
	--minQual <int> : Only add scores over this phred quality when determining a read's quality (default: 15)
	--log <logfile> : Log and summary statistics (default: [outfile].log, or stderr if --out starts with '-')
	--oneChrom      : Treat reads with mates on different chromosomes as single-ended.
	--rmDups        : Remove duplicates (default is to mark duplicates)
	--force         : Allow an already mark-duplicated BAM file, unmarking any previously marked 
	                  duplicates and apply this duplicate marking logic.  Default is to throw errors
	                  and exit when trying to run on an already mark-duplicated BAM
	--excludeFlags <flag>    : exclude reads with any of these flags set when determining or marking duplicates
	                           by default (0xB04): exclude unmapped, secondary reads, QC failures, and supplementary reads
	--verbose       : Turn on verbose mode
	--noeof         : Do not expect an EOF block on a bam file.
	--params        : Print the parameter settings
	--recab         : Recalibrate in addition to dedup_LowMem

Recab Specific Required Parameters
	--refFile <reference file>    : reference file name
Recab Specific Optional Parameters : 
	--dbsnp <known variance file> : dbsnp file of positions
	--minBaseQual <minBaseQual>   : minimum base quality of bases to recalibrate (default: 5)
	--maxBaseQual <maxBaseQual>   : maximum recalibrated base quality (default: 50)
	                                qualities over this value will be set to this value.
	                                This setting is applied after binning (if applicable).
	--blended <weight>            : blended model weight
	--fitModel                    : check if the logistic regression model fits the data
	                                overriden by fast, but automatically applied by useLogReg
	--fast                        : use a compact representation that only allows:
	                                   * at most 256 Read Groups
	                                   * maximum quality 63
	                                   * at most 127 cycles
	                                overrides fitModel, but is overridden by useLogReg
	                                uses up to about 2.25G more memory than running without --fast.
	--keepPrevDbsnp               : do not exclude entries where the previous base is in dbsnp when
	                                building the recalibration table
	                                By default they are excluded from the table.
	--keepPrevNonAdjacent         : do not exclude entries where the previous base is not adjacent
	                                (not a Cigar M/X/=) when building the recalibration table
	                                By default they are excluded from the table (except the first cycle).
	--useLogReg                   : use logistic regression calculated quality for the new quality
	                                automatically applies fitModel and overrides fast.
	--qualField <quality tag>     : tag to get the starting base quality
	                                (default is to get it from the Quality field)
	--storeQualTag <quality tag>  : tag to store the previous quality into
	--buildExcludeFlags <flag>    : exclude reads with any of these flags set when building the
	                                recalibration table.  Default is 0xF04
	--applyExcludeFlags <flag>    : do not apply the recalibration table to any reads with any of these flags set
	Quality Binning Parameters (optional):
	  Bin qualities by phred score, into the ranges specified by binQualS or binQualF (both cannot be used)
	  Ranges are specified by comma separated minimum phred score for the bin, example: 1,17,20,30,40,50,70
	  The first bin always starts at 0, so does not need to be specified.
	  By default, the bin value is the low end of the range.
		--binQualS   : Bin the Qualities as specified (phred): minQualOfBin2, minQualofBin3...
		--binQualF   : Bin the Qualities based on the specified file
		--binCustom  : Use the custom point of the quality bin (followed by colon) for the quality value of the bin.
		--binMid     : Use the mid point of the quality bin range for the quality value of the bin.
		--binHigh    : Use the high end of the quality bin range for the quality value of the bin.

Input Parameters
                   Required Parameters : --in [], --out []
                   Optional Parameters : --minQual [15], --log [], --oneChrom,
                                         --recab, --rmDups, --force,
                                         --excludeFlags [0xB04], --verbose,
                                         --noeof, --params
                             PhoneHome : --noPhoneHome,
                                         --phoneHomeThinning [50]
             Required Recab Parameters : --refFile []
             Optional Recab Parameters : --dbsnp [], --minBaseQual [5],
                                         --maxBaseQual [50], --blended,
                                         --fitModel, --fast, --keepPrevDbsnp,
                                         --keepPrevNonAdjacent, --useLogReg,
                                         --qualField [], --storeQualTag [],
                                         --buildExcludeFlags [0x0F04],
                                         --applyExcludeFlags [0x0000]
   Optional Quality Binning Parameters : --binQualS [], --binQualF [],
                                         --binMid, --binCustom, --binHigh

Specify an input file
```

## bamutil_recab

### Tool Description
Recalibrate

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ./bam recab (options) --in <InputBamFile> --out <OutputFile> [--log <logFile>] [--verbose] [--noeof] [--params] --refFile <ReferenceFile> [--dbsnp <dbsnpFile>] [--minBaseQual <minBaseQual>] [--maxBaseQual <maxBaseQual>] [--blended <weight>] [--fitModel] [--fast] [--keepPrevDbsnp] [--keepPrevNonAdjacent] [--useLogReg] [--qualField <tag>] [--storeQualTag <tag>] [--buildExcludeFlags <flag>] [--applyExcludeFlags <flag>] [--binQualS <minQualBin2>,<minQualBin3><...>] [--binQualF <filename>] [--binMid|binHigh|binCustom]

Required General Parameters :
	--in <infile>   : input BAM file name
	--out <outfile> : output recalibration file name
Optional General Parameters : 
	--log <logfile> : log and summary statistics (default: [outfile].log)
	--verbose       : Turn on verbose mode
	--noeof         : do not expect an EOF block on a bam file.
	--params        : print the parameter settings

Recab Specific Required Parameters
	--refFile <reference file>    : reference file name
Recab Specific Optional Parameters : 
	--dbsnp <known variance file> : dbsnp file of positions
	--minBaseQual <minBaseQual>   : minimum base quality of bases to recalibrate (default: 5)
	--maxBaseQual <maxBaseQual>   : maximum recalibrated base quality (default: 50)
	                                qualities over this value will be set to this value.
	                                This setting is applied after binning (if applicable).
	--blended <weight>            : blended model weight
	--fitModel                    : check if the logistic regression model fits the data
	                                overriden by fast, but automatically applied by useLogReg
	--fast                        : use a compact representation that only allows:
	                                   * at most 256 Read Groups
	                                   * maximum quality 63
	                                   * at most 127 cycles
	                                overrides fitModel, but is overridden by useLogReg
	                                uses up to about 2.25G more memory than running without --fast.
	--keepPrevDbsnp               : do not exclude entries where the previous base is in dbsnp when
	                                building the recalibration table
	                                By default they are excluded from the table.
	--keepPrevNonAdjacent         : do not exclude entries where the previous base is not adjacent
	                                (not a Cigar M/X/=) when building the recalibration table
	                                By default they are excluded from the table (except the first cycle).
	--useLogReg                   : use logistic regression calculated quality for the new quality
	                                automatically applies fitModel and overrides fast.
	--qualField <quality tag>     : tag to get the starting base quality
	                                (default is to get it from the Quality field)
	--storeQualTag <quality tag>  : tag to store the previous quality into
	--buildExcludeFlags <flag>    : exclude reads with any of these flags set when building the
	                                recalibration table.  Default is 0xF04
	--applyExcludeFlags <flag>    : do not apply the recalibration table to any reads with any of these flags set
	Quality Binning Parameters (optional):
	  Bin qualities by phred score, into the ranges specified by binQualS or binQualF (both cannot be used)
	  Ranges are specified by comma separated minimum phred score for the bin, example: 1,17,20,30,40,50,70
	  The first bin always starts at 0, so does not need to be specified.
	  By default, the bin value is the low end of the range.
		--binQualS   : Bin the Qualities as specified (phred): minQualOfBin2, minQualofBin3...
		--binQualF   : Bin the Qualities based on the specified file
		--binCustom  : Use the custom point of the quality bin (followed by colon) for the quality value of the bin.
		--binMid     : Use the mid point of the quality bin range for the quality value of the bin.
		--binHigh    : Use the high end of the quality bin range for the quality value of the bin.

Input Parameters
           Required Generic Parameters : --in [], --out []
           Optional Generic Parameters : --log [], --verbose, --noeof,
                                         --params
                             PhoneHome : --noPhoneHome,
                                         --phoneHomeThinning [50]
             Required Recab Parameters : --refFile []
             Optional Recab Parameters : --dbsnp [], --minBaseQual [5],
                                         --maxBaseQual [50], --blended,
                                         --fitModel, --fast, --keepPrevDbsnp,
                                         --keepPrevNonAdjacent, --useLogReg,
                                         --qualField [], --storeQualTag [],
                                         --buildExcludeFlags [0x0F04],
                                         --applyExcludeFlags [0x0000]
   Optional Quality Binning Parameters : --binQualS [], --binQualF [],
                                         --binMid, --binCustom, --binHigh

Missing required --in parameter
```

## bamutil_validate

### Tool Description
Validate a SAM/BAM File

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 validate - Validate a SAM/BAM File
	./bam validate --in <inputFile> [--noeof] [--so_flag|--so_coord|--so_query] [--maxErrors <numErrors>] [--verbose] [--printableErrors <numReportedErrors>] [--disableStatistics] [--params]
	Required Parameters:
		--in : the SAM/BAM file to be validated
	Optional Parameters:
		--noeof             : do not expect an EOF block on a bam file.
		--refFile           : the reference file
		--so_flag           : validate the file is sorted based on the header's @HD SO flag.
		--so_coord          : validate the file is sorted based on the coordinate.
		--so_query          : validate the file is sorted based on the query name.
		--maxErrors         : Number of records with errors/invalids to allow before quiting.
		                      -1 (default) indicates to not quit until the entire file is validated.
		                      0 indicates not to read/validate anything.
		--verbose           : Print specific error details rather than just a summary
		--printableErrors   : Maximum number of records with errors to print the details of
		                      before suppressing them when in verbose (defaults to 100)
		--disableStatistics : Turn off statistic generation
		--params            : Print the parameter settings

Input Parameters
 --in [], --noeof, --refFile [], --maxErrors [-1], --verbose,
               --printableErrors [100], --disableStatistics, --params
   SortOrder : --so_flag, --so_coord, --so_query
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument for validate, but was not specified
```

## bamutil_diff

### Tool Description
Diff 2 coordinate sorted SAM/BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 diff - Diff 2 coordinate sorted SAM/BAM files.
	./bam diff --in1 <inputFile> --in2 <inputFile> [--out <outputFile>] [--all] [--flag] [--mapQual] [--mate] [--isize] [--seq] [--baseQual] [--tags <Tag:Type[,Tag:Type]*>] [--everyTag] [--noCigar] [--noPos] [--onlyDiffs] [--recPoolSize <int>] [--posDiff <int>] [--noeof] [--params]
	Required Parameters:
		--in1         : first coordinate sorted SAM/BAM file to be diffed
		--in2         : second coordinate sorted SAM/BAM file to be diffed
	Optional Parameters:
		--out         : output filename, use .bam extension to output in SAM/BAM format instead of diff format.
		                In SAM/BAM format there will be 3 output files:
		                    1) the specified name with record diffs
		                    2) specified name with _only_<in1>.sam/bam with records only in the in1 file
		                    3) specified name with _only_<in2>.sam/bam with records only in the in2 file
		--all         : diff all the SAM/BAM fields.
		--flag        : diff the flags.
		--mapQual     : diff the mapping qualities.
		--mate        : diff the mate chrom/pos.
		--isize       : diff the insert sizes.
		--seq         : diff the sequence bases.
		--baseQual    : diff the base qualities.
		--tags        : diff the specified Tags formatted as Tag:Type,Tag:Type,Tag:Type...
		--everyTag    : diff all the Tags
		--noCigar     : do not diff the the cigars.
		--noPos       : do not diff the positions.
		--onlyDiffs   : only print the fields that are different, otherwise for any diff all the fields that are compared are printed.
		--recPoolSize : number of records to allow to be stored at a time, default value: 1000000
		                Set to -1 for unlimited number of records
		--posDiff     : max base pair difference between possibly matching records, default value: 100000
		--noeof       : do not expect an EOF block on a bam file.
		--params      : print the parameter settings

Input Parameters
 --in1 [], --in2 [], --out [-], --all, --flag, --mapQual, --mate, --isize,
               --seq, --baseQual, --tags [], --everyTags, --noCigar, --noPos,
               --onlyDiffs, --recPoolSize [1000000], --posDiff [100000],
               --noeof, --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in1 is a mandatory argument, but was not specified
```

## bamutil_stats

### Tool Description
Stats a SAM/BAM File

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 stats - Stats a SAM/BAM File
	./bam stats --in <inputFile> [--basic] [--qual] [--phred] [--pBaseQC <outputFileName>] [--cBaseQC <outputFileName>] [--maxNumReads <maxNum>][--unmapped] [--bamIndex <bamIndexFile>] [--regionList <regFileName>] [--requiredFlags <integerRequiredFlags>] [--excludeFlags <integerExcludeFlags>] [--noeof] [--params] [--withinRegion] [--baseSum] [--bufferSize <buffSize>] [--minMapQual <minMapQ>] [--dbsnp <dbsnpFile>]
	Required Parameters:
		--in : the SAM/BAM file to calculate stats for
	Types of Statistics that can be generated:
		--basic         : Turn on basic statistic generation
		--qual          : Generate a count for each quality (displayed as non-phred quality)
		--phred         : Generate a count for each quality (displayed as phred quality)
		--pBaseQC       : Write per base statistics as Percentages to the specified file. (use - for stdout)
		                  pBaseQC & cBaseQC cannot both be specified.
		--cBaseQC       : Write per base statistics as Counts to the specified file. (use - for stdout)
		                  pBaseQC & cBaseQC cannot both be specified.
	Optional Parameters:
		--maxNumReads   : Maximum number of reads to process
		                  Defaults to -1 to indicate all reads.
		--unmapped      : Only process unmapped reads (requires a bamIndex file)
		--bamIndex      : The path/name of the bam index file
		                  (if required and not specified, uses the --in value + ".bai")
		--regionList    : File containing the regions to be processed chr<tab>start_pos<tab>end_pos.
		                  Positions are 0 based and the end_pos is not included in the region.
		                  Uses bamIndex.
		--excludeFlags  : Skip any records with any of the specified flags set
		                  (specify an integer representation of the flags)
		--requiredFlags : Only process records with all of the specified flags set
		                  (specify an integer representation of the flags)
		--noeof         : Do not expect an EOF block on a bam file.
		--params        : Print the parameter settings.
	Optional phred/qual Only Parameters:
		--withinRegion  : Only count qualities if they fall within regions specified.
		                  Only applicable if regionList is also specified.
	Optional BaseQC Only Parameters:
		--baseSum       : Print an overall summary of the baseQC for the file to stderr.
		--bufferSize    : Size of the pileup buffer for calculating the BaseQC parameters.
		                  Default: 1024
		--minMapQual    : The minimum mapping quality for filtering reads in the baseQC stats.
		--dbsnp         : The dbSnp file of positions to exclude from baseQC analysis.

Input Parameters
                   Required Parameters : --in []
                   Types of Statistics : --basic, --qual, --phred,
                                         --pBaseQC [], --cBaseQC []
                   Optional Parameters : --maxNumReads [-1], --unmapped,
                                         --bamIndex [], --regionList [],
                                         --excludeFlags, --requiredFlags,
                                         --noeof, --params
   Optional phred/qual Only Parameters : --withinRegion
       Optional BaseQC Only Parameters : --baseSum, --bufferSize [1024],
                                         --minMapQual, --dbsnp []
                             PhoneHome : --noPhoneHome,
                                         --phoneHomeThinning [50]

--in is a mandatory argument for stats, but was not specified
```

## bamutil_gapInfo

### Tool Description
Print information on the gap between read pairs in a SAM/BAM File.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 gapInfo - Print information on the gap between read pairs in a SAM/BAM File.
	./bam gapInfo --in <inputFile> --out <outputFile> [--noeof] [--params]
	Required Parameters:
		--in          : the SAM/BAM file to print read pair gap info for
		--out         : the output file to be written
	Optional Parameters:
		--refFile     : reference file, used to skip gaps that include reference base 'N' (for runs without --detailed)		--detailed    : Print  the details for each read pair
	Optional Parameters for the Detailed Option:
		--checkFirst  : Check the first in pair flag and print "NotFirst" if it isn't first
		--checkStrand : Check the strand flag and print "Reverse" if it is reverse complimented
		--noeof       : Do not expect an EOF block on a bam file.
		--params      : Print the parameter settings to stderr

Input Parameters
            Required Parameters : --in [], --out []
            Optional Parameters : --refFile [], --detailed
   Optional Detailed Parameters : --checkFirst, --checkStrand, --noeof,
                                  --params
                      PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_dumpHeader

### Tool Description
Print SAM/BAM Header

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 dumpHeader - Print SAM/BAM Header
	./bam dumpHeader <inputFile>
```

## bamutil_dumpRefInfo

### Tool Description
Print SAM/BAM Reference Name Information

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 dumpRefInfo - Print SAM/BAM Reference Name Information
	./bam dumpRefInfo --in <inputFilename> [--noeof] [--printRecordRefs] [--params]
	Required Parameters:
		--in               : the SAM/BAM file to be read
	Optional Parameters:
		--noeof            : do not expect an EOF block on a bam file.
		--printRecordRefs  : print the reference information for the records in the file (grouped by reference).
		--params           : print the parameter settings

Input Parameters
 --in [], --noeof, --printRecordRefs, --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## bamutil_dumpIndex

### Tool Description
Print BAM Index File in English

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 dumpIndex - Print BAM Index File in English
	./bam dumpIndex --bamIndex <bamIndexFile> [--refID <ref#>] [--summary] [--params]
	Required Parameters:
		--bamIndex : the path/name of the bam index file to display
	Optional Parameters:
		--refID    : the reference ID to read, defaults to print all
		--summary  : only print a summary - 1 line per reference.
		--params   : print the parameter settings

Input Parameters
 --bamIndex [], --refID [-1], --summary, --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

Missing mandatory argument: --bamIndex
```

## bamutil_readReference

### Tool Description
Print the reference string for the specified region

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 readReference - Print the reference string for the specified region
	./bam readReference --refFile <referenceFilename> --refName <reference Name> --start <0 based start> --end <0 based end>|--numBases <number of bases> [--params]
	Required Parameters:
		--refFile  : the reference
		--refName  : the SAM/BAM reference Name to read
		--start    : inclusive 0-based start position
		--params   : print the parameter settings
	Required Length Parameter (one but not both needs to be specified):
		--end      : exclusive 0-based end position
		--numBases : number of bases from start to display

Input Parameters
 --refFile [], --refName [], --start [-1], --end [-1], --numBases [-1],
               --params
   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

Missing Required Parameter
```

## bamutil_bam2FastQ

### Tool Description
Convert the specified BAM file to fastQs.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

 bam2FastQ - Convert the specified BAM file to fastQs.
	./bam bam2FastQ --in <inputFile> [--readName] [--splitRG] [--qualField <tag>] [--refFile <referenceFile>] [--outBase <outputFileBase>] [--firstOut <1stReadInPairOutFile>] [--merge|--secondOut <2ndReadInPairOutFile>] [--unpairedOut <unpairedOutFile>] [--firstRNExt <firstInPairReadNameExt>] [--secondRNExt <secondInPairReadNameExt>] [--rnPlus] [--noReverseComp] [--region <chr>[:<pos>[:<base>]]] [--gzip] [--noeof] [--params]
	Required Parameters:
		--in       : the SAM/BAM file to convert to FastQ
	Optional Parameters:
		--readname      : Process the BAM as readName sorted instead
		                  of coordinate if the header does not indicate a sort order.
		--splitRG       : Split into RG specific fastqs.
		--qualField     : Use the base quality from the specified tag
		                  rather than from the Quality field (default)
		--merge         : Generate 1 interleaved (merged) FASTQ for paired-ends (unpaired in a separate file)
		                  use firstOut to override the filename of the interleaved file.
		--refFile       : Reference file for converting '=' in the sequence to the actual base
		                  if '=' are found and the refFile is not specified, 'N' is written to the FASTQ
		--firstRNExt    : read name extension to use for first read in a pair
		                  default is "/1"
		--secondRNExt   : read name extension to use for second read in a pair
		                  default is "/2"
		--rnPlus        : Add the Read Name/extension to the '+' line of the fastq records
		--noReverseComp : Do not reverse complement reads marked as reverse
		--region        : Only convert reads containing the specified region/nucleotide.
		                  Position formatted as: chr:pos:base
		                  pos (0-based) & base are optional.
		--gzip          : Compress the output FASTQ files using gzip
		--noeof         : Do not expect an EOF block on a bam file.
		--params        : Print the parameter settings to stderr
	Optional OutputFile Names:
		--outBase       : Base output name for generated output files
		--firstOut      : Output name for the first in pair file
		                  over-rides setting of outBase
		--secondOut     : Output name for the second in pair file
		                  over-rides setting of outBase
		--unpairedOut   : Output name for unpaired reads
		                  over-rides setting of outBase

Input Parameters
         Required Parameters : --in []
         Optional Parameters : --readName, --splitRG, --qualField [], --merge,
                               --refFile [], --firstRNExt [/1],
                               --secondRNExt [/2], --rnPlus,
                               --noReverseComp [ON], --region [], --gzip,
                               --noeof, --params
   Optional OutputFile Names : --outBase [], --firstOut [], --secondOut [],
                               --unpairedOut []
                   PhoneHome : --noPhoneHome, --phoneHomeThinning [50]

--in is a mandatory argument, but was not specified
```

## Metadata
- **Skill**: generated

