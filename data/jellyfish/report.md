# jellyfish CWL Generation Report

## jellyfish_count

### Tool Description
Count k-mers in fasta or fastq files

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Total Downloads**: 171.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gmarcais/Jellyfish
- **Stars**: N/A
### Original Help Text
```text
Usage: jellyfish count [options] file:path+

Count k-mers in fasta or fastq files

Options (default value in (), *required):
 -m, --mer-len=uint32                    *Length of mer
 -s, --size=uint64                       *Initial hash size
 -t, --threads=uint32                     Number of threads (1)
     --sam=PATH                           SAM/BAM/CRAM formatted input file
 -F, --Files=uint32                       Number files open simultaneously (1)
 -g, --generator=path                     File of commands generating fast[aq]
 -G, --Generators=uint32                  Number of generators run simultaneously (1)
 -S, --shell=string                       Shell used to run generator commands ($SHELL or /bin/sh)
 -o, --output=string                      Output file (mer_counts.jf)
 -c, --counter-len=Length in bits         Length bits of counting field (7)
     --out-counter-len=Length in bytes    Length in bytes of counter field in output (4)
 -C, --canonical                          Count both strand, canonical representation (false)
     --bc=peath                           Bloom counter to filter out singleton mers
     --bf-size=uint64                     Use bloom filter to count high-frequency mers
     --bf-fp=double                       False positive rate of bloom filter (0.01)
     --if=path                            Count only k-mers in this files
 -Q, --min-qual-char=string               Any base with quality below this character is changed to N
     --quality-start=int32                ASCII for quality values (64)
     --min-quality=int32                  Minimum quality. A base with lesser quality becomes an N
 -p, --reprobes=uint32                    Maximum number of reprobes (126)
     --text                               Dump in text format (false)
     --disk                               Disk operation. Do not do size doubling (false)
 -L, --lower-count=uint64                 Don't output k-mer with count < lower-count
 -U, --upper-count=uint64                 Don't output k-mer with count > upper-count
     --timing=Timing file                 Print timing information
     --usage                              Usage
 -h, --help                               This message
     --full-help                          Detailed help
 -V, --version                            Version
```


## jellyfish_bc

### Tool Description
Create a bloom filter from the input k-mers

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish bc [options] file:path+

Create a bloom filter from the input k-mers

Here, a bloom filter is a data structure than can tell if
a k-mer has been since 0 times, once, or at least twice. The data
structure is very memory efficient but has some probability of error.

After creating the bloom filter, it can be passed to the count
subcommand to avoid counting most k-mers which occur only once.

Options (default value in (), *required):
 -s, --size=uint64                       *Expected number of k-mers in input
 -m, --mer-len=uint32                    *Length of mer
 -f, --fpr=double                         False positive rate (0.001)
 -C, --canonical                          Count both strand, canonical representation (false)
 -t, --threads=uint32                     Number of threads (1)
 -o, --output=string                      Output file (mer_bloom_filter)
 -F, --Files=uint32                       Number files open simultaneously (1)
 -g, --generator=path                     File of commands generating fast[aq]
 -G, --Generators=uint32                  Number of generators run simultaneously (1)
 -S, --shell=string                       Shell used to run generator commands ($SHELL or /bin/sh)
     --timing=Timing file                 Print timing information
 -U, --usage                              Usage
 -h, --help                               This message
 -V, --version                            Version
```


## jellyfish_info

### Tool Description
Display information about a jellyfish file

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish info [options] file:path

Display information about a jellyfish file

This command shows some information about how this jellyfish output
file was created. Without any argument, it displays the command line
used, when and where it was run.

Options (default value in (), *required):
 -s, --skip                               Skip header and dump remainder of file (false)
 -j, --json                               Dump full header in JSON format (false)
 -c, --cmd                                Display only the command line (false)
 -U, --usage                              Usage
 -h, --help                               This message
 -V, --version                            Version
```


## jellyfish_stats

### Tool Description
Display some statistics about the k-mers in the hash:

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish stats [options] db:path

Statistics

Display some statistics about the k-mers in the hash:

Unique:    Number of k-mers which occur only once.
Distinct:  Number of k-mers, not counting multiplicity.
Total:     Number of k-mers, including multiplicity.
Max_count: Maximum number of occurrence of a k-mer.

Options (default value in (), *required):
 -L, --lower-count=uint64                 Don't consider k-mer with count < lower-count (0)
 -U, --upper-count=uint64                 Don't consider k-mer with count > upper-count (2^64)
 -v, --verbose                            Verbose (false)
 -o, --output=string                      Output file
     --usage                              Usage
 -h, --help                               This message
     --full-help                          Detailed help
 -V, --version                            Version
```


## jellyfish_histo

### Tool Description
Create an histogram of k-mer occurrences

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish histo [options] db:path

Create an histogram of k-mer occurrences

Create an histogram with the number of k-mers having a given
count. In bucket 'i' are tallied the k-mers which have a count 'c'
satisfying 'low+i*inc <= c < low+(i+1)*inc'. Buckets in the output are
labeled by the low end point (low+i*inc).

The last bucket in the output behaves as a catchall: it tallies all
k-mers with a count greater or equal to the low end point of this
bucket.

Options (default value in (), *required):
 -l, --low=uint64                         Low count value of histogram (1)
 -h, --high=uint64                        High count value of histogram (10000)
 -i, --increment=uint64                   Increment value for buckets (1)
 -t, --threads=uint32                     Number of threads (1)
 -f, --full                               Full histo. Don't skip count 0. (false)
 -o, --output=string                      Output file
 -v, --verbose                            Output information (false)
 -U, --usage                              Usage
     --help                               This message
     --full-help                          Detailed help
 -V, --version                            Version
```


## jellyfish_dump

### Tool Description
Dump k-mer counts

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish dump [options] db:path

Dump k-mer counts

By default, dump in a fasta format where the header is the count and
the sequence is the sequence of the k-mer. The column format is a 2
column output: k-mer count.

Options (default value in (), *required):
 -c, --column                             Column format (false)
 -t, --tab                                Tab separator (false)
 -L, --lower-count=uint64                 Don't output k-mer with count < lower-count
 -U, --upper-count=uint64                 Don't output k-mer with count > upper-count
 -o, --output=string                      Output file
     --usage                              Usage
 -h, --help                               This message
 -V, --version                            Version
```


## jellyfish_merge

### Tool Description
Merge jellyfish databases

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish merge [options] input:string+

Merge jellyfish databases

Options (default value in (), *required):
 -o, --output=string                      Output file (mer_counts_merged.jf)
 -L, --lower-count=uint64                 Don't output k-mer with count < lower-count
 -U, --upper-count=uint64                 Don't output k-mer with count > upper-count
     --usage                              Usage
 -h, --help                               This message
 -V, --version                            Version
```


## jellyfish_query

### Tool Description
Query a Jellyfish database

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish query [options] file:path mers:string+

Query a Jellyfish database

Options (default value in (), *required):
 -s, --sequence=path                      Output counts for all mers in sequence
 -o, --output=path                        Output file (stdout)
 -i, --interactive                        Interactive, queries from stdin (false)
 -l, --load                               Force pre-loading of database file into memory (false)
 -L, --no-load                            Disable pre-loading of database file into memory (false)
 -U, --usage                              Usage
 -h, --help                               This message
 -V, --version                            Version
```


## jellyfish_cite

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
This software has been published. If you use it for your research, cite:

A fast, lock-free approach for efficient parallel counting of occurrences of k-mers
Guillaume Marcais; Carl Kingsford
Bioinformatics (2011) 27(6): 764-770 first published online January 7, 2011 doi:10.1093/bioinformatics/btr011


http://www.cbcb.umd.edu/software/jellyfish
http://bioinformatics.oxfordjournals.org/content/early/2011/01/07/bioinformatics.btr011
```


## jellyfish_mem

### Tool Description
Give memory usage information

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jellyfish mem [options] file:path+

Give memory usage information

The mem subcommand gives some information about the memory usage of
Jellyfish when counting mers. If one replace 'count' by 'mem' in the
command line, it displays the amount of memory needed. All the
switches of the count subcommand are supported, although only the
meaningful one for computing the memory usage are used.

If the '--size' (-s) switch is omitted and the --mem switch is passed
with an amount of memory in bytes, then the largest size that fit in
that amount of memory is returned.

The memory usage information only takes into account the hash to store
the k-mers, not various buffers (e.g. in parsing the input files). But
typically those will be small in comparison to the hash.

Options (default value in (), *required):
 -m, --mer-len=uint32                    *Length of mer
 -s, --size=uint64                        Initial hash size
 -c, --counter-len=Length in bits         Length bits of counting field (7)
 -p, --reprobes=uint32                    Maximum number of reprobes (126)
     --mem=uint64                         Return maximum size to fit within that memory
     --bc=peath                           Ignored switch
     --usage                              Usage
 -h, --help                               This message
     --full-help                          Detailed help
 -V, --version                            Version
```


## jellyfish_jf

### Tool Description
Count k-mers in DNA, RNA or protein sequences.

### Metadata
- **Docker Image**: biocontainers/jellyfish:v2.2.10-2-deb_cv1
- **Homepage**: http://www.genome.umd.edu/jellyfish.html
- **Package**: https://anaconda.org/channels/bioconda/packages/jellyfish/overview
- **Validation**: PASS

### Original Help Text
```text
.......
          ..........      .....
       ....                   ....
      ..     /-+       +---\     ...
      .     /--|       +----\      ...
     ..                              ...
     .                                 .
     ..      +----------------+         .
      .      |. AAGATGGAGCGC .|         ..
      .      |---.        .--/           .
     ..          \--------/     .        .
     .     .            ..     ..        .
     .    ... .....   .....    ..        ..
     .   .. . .   .  ..   .   ....        .
     .  ..  . ..   . .    ..  .  .         .
     . ..   .  .   ...     . ..  ..        .
    ....    . ..   ..      ...    ..       .
   .. .     ...     .      ..      ..      .
   . ..      .      .       .       ...    ..
   ...       .      .      ..         ...   .
   .         ..     .      ..           .....
  ____  ____  ._    __   _  _  ____  ____  ___  _   _
 (_  _)( ___)(  )  (  ) ( \/ )( ___)(_  _)/ __)( )_( )
.-_)(   )__)  )(__  )(__ \  /  )__)  _)(_ \__ \ ) _ ( 
\____) (____)(____)(____)(__) (__)  (____)(___/(_) (_)
```


## Metadata
- **Skill**: not generated
