# stringmlst CWL Generation Report

## stringmlst_stringMLST.py

### Tool Description
Readme for stringMLST

### Metadata
- **Docker Image**: quay.io/biocontainers/stringmlst:0.6.3--py_0
- **Homepage**: https://github.com/jordanlab/stringMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/stringmlst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stringmlst/overview
- **Total Downloads**: 58.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jordanlab/stringMLST
- **Stars**: N/A
### Original Help Text
```text
Readme for stringMLST
=============================================================================================
Usage
./stringMLST.py
[--buildDB]
[--predict]
[-1 filename_fastq1][--fastq1 filename_fastq1]
[-2 filename_fastq2][--fastq2 filename_fastq2]
[-d directory][--dir directory][--directory directory]
[-l list_file][--list list_file]
[-p][--paired]
[-s][--single]
[-c][--config]
[-P][--prefix]
[-z][--fuzzy]
[-a]
[-C][--coverage]
[-k]
[-o output_filename][--output output_filename]
[-x][--overwrite]
[-t]
[-r]
[-v]
[-h][--help]
==============================================================================================
There are two steps to predicting ST using stringMLST.
1. Create DB : stringMLST.py --buildDB
2. Predict : stringMLST --predict
1. stringMLST.py --buildDB
Synopsis:
stringMLST.py --buildDB -c <config file> -k <kmer length(optional)> -P <DB prefix(optional)>
    config file : is a tab delimited file which has the information for typing scheme ie loci, its multifasta file and profile definition file.
        Format :
            [loci]
            locus1      locusFile1
            locus2      locusFile2
            [profile]
            profile     profileFile
    kmer length : is the kmer length for the db. Note, while processing this should be smaller than the read length.
        We suggest kmer lengths of 35, 66 depending on the read length.
    DB prefix(optional) : holds the information for DB files to be created and their location. This module creates 3 files with this prefix.
        You can use a folder structure with prefix to store your db at particular location.
Required arguments
--buildDB
    Identifier for build db module
-c,--config = <configuration file>
    Config file in the format described above.
    All the files follow the structure followed by pubmlst. Refer extended document for details.
Optional arguments
-k = <kmer length>
    Kmer size for which the db has to be formed(Default k = 35). Note the tool works best with kmer length in between 35 and 66
    for read lengths of 55 to 150 bp. Kmer size can be increased accordingly. It is advised to keep lower kmer sizes
    if the quality of reads is not very good.
-P,--prefix = <prefix>
    Prefix for db and log files to be created(Default = kmer). Also you can specify folder where you want the dbb to be created.
-a
        File location to write build log
-h,--help
  Prints the help manual for this application
 --------------------------------------------------------------------------------------------
2. stringMLST.py --predict
stringMLST --predict : can run in three modes
  1) single sample (default mode)
  2) batch mode : run stringMLST for all the samples in a folder (for a particular specie)
  3) list mode : run stringMLST on samples specified in a file
stringMLST can process both single and paired end files. By default program expects paired end files.
Synopsis
stringMLST.py --predict -1 <fastq file> -2 <fastq file> -d <directory location> -l <list file> -p -s -P <DB prefix(optional)> -k <kmer length(optional)> -o <output file> -x
Required arguments
--predict
    Identifier for predict module
Optional arguments
-1,--fastq1 = <fastq1_filename>
  Path to first fastq file for paired end sample and path to the fastq file for single end file.
  Should have extension fastq or fq.
-2,--fastq2 = <fastq2_filename>
  Path to second fastq file for paired end sample.
  Should have extension fastq or fq.
-d,--dir,--directory = <directory>
  BATCH MODE : Location of all the samples for batch mode.
-C,--coverage
    Calculate sequence coverage for each allele. Turns on read generation (-r) and turns off fuzzy (-z 1)
    Requires bwa, bamtools and samtools be in your path
-k = <kmer_length>
  Kmer length for which the db was created(Default k = 35). Could be verified by looking at the name of the db file.
  Could be used if the reads are of very bad quality or have a lot of N's.
-l,--list = <list_file>
  LIST MODE : Location of list file and flag for list mode.
  list file should have full file paths for all the samples/files.
  Each sample takes one line. For paired end samples the 2 files should be tab separated on single line.
-o,--output = <output_filename>
  Prints the output to a file instead of stdout.
-p,--paired
  Flag for specifying paired end files. Default option so would work the same if you do not specify for all modes.
  For batch mode the paired end samples should be differentiated by 1/2.fastq or 1/2.fq
-P,--prefix = <prefix>
    Prefix using which the db was created(Defaults = kmer). The location of the db could also be provided.
-r
  A separate reads file is created which has all the reads covering all the locus.
-s,--single
  Flag for specifying single end files.
-t
  Time for each analysis will also be reported.
-v
  Prints the version of the software.
-x,--overwrite
  By default stringMLST appends the results to the output_filename if same name is used.
  This argument overwrites the previously specified output file.
-z,--fuzzy = <fuzzy threshold int>
    Threshold for reporting a fuzzy match (Default=300). For higher coverage reads this threshold should be set higher to avoid
    indicating fuzzy match when exact match was more likely. For lower coverage reads, threshold of <100 is recommended
-h,--help
  Prints the help manual for this application
=============================================================================================
3. stringMLST.py --getMLST
Synopsis:
stringMLST.py --getMLST --species= <species> [-k kmer length] [-P DB prefix]
Required arguments
--getMLST
    Identifier for getMLST module
--species= <species name>
    Species name from the pubMLST schemes (use "--species show" to get list of available schemes)
    "all" will download and build all
Optional arguments
-k = <kmer length>
    Kmer size for which the db has to be formed(Default k = 35). Note the tool works best with kmer length in between 35 and 66
    for read lengths of 55 to 150 bp. Kmer size can be increased accordingly. It is advised to keep lower kmer sizes
    if the quality of reads is not very good.
-P,--prefix = <prefix>
    Prefix for db and log files to be created(Default = kmer). Also you can specify folder where you want the db to be created.
    We recommend that prefix and config point to the same folder for cleanliness but this is not required
--schemes
    Display the list of available schemes
-h,--help
  Prints the help manual for this application
=============================================================================================
Example usage:
./stringMLST.py --buildDB
1) Build DB
 ./stringMLST.py --buildDB --config config.txt -k 35 -P NM
 --------------------------------------------------------------------------------------------
./stringMLST.py --predict
1) Single sample, paired end
 ./stringMLST.py --predict -1 data/Neisseria/ERR017001_1.fastq -2 data/Neisseria/ERR017001_2.fastq -p --prefix NM -k 35 -o output.txt
2) Single sample, single end, overwrite output
  ./stringMLST.py --predict -1 data/Neisseria/ERR017001_1.fastq -s --prefix NM -k 35 -o output.txt -x
3) Multiple sample batch mode, paired end
   ./stringMLST.py --predict -d data/Neisseria/ -p --prefix NM -k 35 -o output.txt -x
4) Multiple samples list mode, paired end
   ./stringMLST.py --predict -l data/listFile.txt -p --prefix NM -k 35 -o output.txt -x
5) Single, high coverage sample, paired end
 ./stringMLST.py --predict -1 data/Neisseria/ERR017001_1.fastq -2 data/Neisseria/ERR017001_2.fastq -p --prefix NM -k 35 -z 1000 -o output.txt
--------------------------------------------------------------------------------------------
./stringMLST.py --getMLST
1) List available schemes
 ./stringMLST.py --getMLST --schemes
2) Download the Neisseria spp. pubMLST scheme
  ./stringMLST.py --getMLST --species=neisseria -P datasets/nmb
```

