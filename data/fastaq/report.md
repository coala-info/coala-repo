# fastaq CWL Generation Report

## fastaq_acgtn_only

### Tool Description
Replaces any character that is not one of acgtACGTnN with an N

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastaq/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/sanger-pathogens/Fastaq
- **Stars**: N/A
### Original Help Text
```text
usage: fastaq acgtn_only [options] <infile> <outfile>

Replaces any character that is not one of acgtACGTnN with an N

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_add_indels

### Tool Description
Deletes or inserts bases at given position(s)

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq add_indels [options] <infile> <outfile>

Deletes or inserts bases at given position(s)

positional arguments:
  infile                Name of input file
  outfile               Name of output file

optional arguments:
  -h, --help            show this help message and exit
  -d Name:start:bases, --delete Name:start:bases
                        Delete the given bases from the given sequence. Format
                        same as samtools view: name:start-end. This option can
                        be used multiple times (once for each region to
                        delete). Overlapping coords will be merged before
                        deleting
  --delete_range P,start,step
                        Deletes bases starting at position P in each sequence
                        of the input file. Deletes start + (n-1)*step bases
                        from sequence n.
  -i Name:start:bases, --insert Name:start:bases
                        Insert a random string of bases at the given position.
                        Format is name:position:number_to_add. Bases are added
                        after the position. This option can be used multiple
                        times
  --insert_range P,start,step
                        Inserts random bases starting after position P in each
                        sequence of the input file. Inserts start + (n-1)*step
                        bases into sequence n.
```


## fastaq_caf_to_fastq

### Tool Description
Converts CAF file to FASTQ format

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq caf_to_fastq [options] <infile> <outfile>

Converts CAF file to FASTQ format

positional arguments:
  infile                Name of input CAF file.
  outfile               Name of output FASTQ file

optional arguments:
  -h, --help            show this help message and exit
  -c, --clip            Use clipping info to clip reads, if present in the
                        input CAF file (as lines of the form "Clipping QUAL
                        start end"). Default is to not clip
  -l INT, --min_length INT
                        Minimum length of sequence to output [1]
```


## fastaq_capillary_to_pairs

### Tool Description
Given a file of capillary reads, makes an interleaved file of read pairs (where more than read from same ligation, takes the longest read) and a file of unpaired reads. Replaces the .p1k/.q1k part of read names to denote fwd/rev reads with /1 and /2

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq capillary_to_pairs <infile> <outfiles prefix>

Given a file of capillary reads, makes an interleaved file of read pairs
(where more than read from same ligation, takes the longest read) and a file
of unpaired reads. Replaces the .p1k/.q1k part of read names to denote fwd/rev
reads with /1 and /2

positional arguments:
  infile           Name of input fasta/q file
  outfiles prefix  Prefix of output files

optional arguments:
  -h, --help       show this help message and exit
```


## fastaq_chunker

### Tool Description
Splits a multi sequence file into separate files. Splits sequences into chunks of a fixed size. Aims for chunk_size chunks in each file, but allows a little extra, so chunk can be up to (chunk_size + tolerance), to prevent tiny chunks made from the ends of sequences

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq chunker [options] <infile> <out> <chunk size> <tolerance>

Splits a multi sequence file into separate files. Splits sequences into chunks
of a fixed size. Aims for chunk_size chunks in each file, but allows a little
extra, so chunk can be up to (chunk_size + tolerance), to prevent tiny chunks
made from the ends of sequences

positional arguments:
  infile         Name of input file to be split
  out            Prefix of output file. If --onefile used, then name of single
                 output file
  chunk_size     Size of each chunk
  tolerance      Tolerance allowed in chunk size

optional arguments:
  -h, --help     show this help message and exit
  --onefile      Output all the sequences in one file
  --skip_all_Ns  Do not output any sequence that consists of all Ns
```


## fastaq_count_sequences

### Tool Description
Prints the number of sequences in input file to stdout

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq count_sequences <infile>

Prints the number of sequences in input file to stdout

positional arguments:
  infile      Name of input file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_deinterleave

### Tool Description
Deinterleaves sequence file, so that reads are written alternately between two
output files

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq deinterleave [options] <infile> <out_fwd> <out_rev>

Deinterleaves sequence file, so that reads are written alternately between two
output files

positional arguments:
  infile       Name of fasta/q file to be deinterleaved
  out_fwd      Name of output fasta/q file of forwards reads
  out_rev      Name of output fasta/q file of reverse reads

optional arguments:
  -h, --help   show this help message and exit
  --fasta_out  Use this to write output as fasta (default is same as input)
```


## fastaq_enumerate_names

### Tool Description
Renames sequences in a file, calling them 1,2,3... etc

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq enumerate_names [options] <infile> <outfile>

Renames sequences in a file, calling them 1,2,3... etc

positional arguments:
  infile                Name of fasta/q file to be read
  outfile               Name of output fasta/q file

optional arguments:
  -h, --help            show this help message and exit
  --start_index START_INDEX
                        Starting number [1]
  --rename_file RENAME_FILE
                        If used, will write a file of old name to new name
  --keep_suffix         Use this to keep a /1 or /2 suffix at the end of each
                        name
  --suffix SUFFIX       Add the given string to the end of every name
```


## fastaq_expand_nucleotides

### Tool Description
Makes all combinations of sequences in input file by using all possibilities of redundant bases. e.g. ART could be AAT or AGT. Assumes input is nucleotides, not amino acids

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq expand_nucleotides <infile> <outfile>

Makes all combinations of sequences in input file by using all possibilities
of redundant bases. e.g. ART could be AAT or AGT. Assumes input is
nucleotides, not amino acids

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_fasta_to_fastq

### Tool Description
Convert FASTA and .qual to FASTQ

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq fasta_to_fastq <fasta in> <qual in> <fastq out>

Convert FASTA and .qual to FASTQ

positional arguments:
  fasta in    Name of input FASTA file
  qual in     Name of input quality scores file
  fastq out   Name of output FASTQ file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_filter

### Tool Description
Filters a sequence file by sequence length and/or by name matching a regular expression

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq filter [options] <infile> <outfile>

Filters a sequence file by sequence length and/or by name matching a regular
expression

positional arguments:
  infile               Name of input file to be filtered
  outfile              Name of output file

optional arguments:
  -h, --help           show this help message and exit
  --min_length INT     Minimum length of sequence to keep [0]
  --max_length INT     Maximum length of sequence to keep [inf]
  --regex REGEX        If given, only reads with a name matching the regular
                       expression will be kept
  --ids_file FILENAME  If given, only reads whose ID is in th given file will
                       be used. One ID per line of file.
  -v, --invert         Only keep sequences that do not match the filters

Mate file for read pairs options:
  --mate_in FILENAME   Name of mates input file. If used, must also provide
                       --mate_out
  --mate_out FILENAME  Name of mates output file
  --both_mates_pass    By default, if either mate passes filter, then both
                       reads output. Use this flag to require that both reads
                       of a pair pass the filter
```


## fastaq_get_ids

### Tool Description
Gets IDs from each sequence in input file

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq get_ids <infile> <outfile>

Gets IDs from each sequence in input file

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_get_seq_flanking_gaps

### Tool Description
Gets the sequences flanking gaps

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq get_seq_flanking_gaps [options] <infile> <outfile>

Gets the sequences flanking gaps

positional arguments:
  infile       Name of input file
  outfile      Name of output file

optional arguments:
  -h, --help   show this help message and exit
  --left INT   Number of bases to get to left of gap [25]
  --right INT  Number of bases to get to right of gap [25]
```


## fastaq_interleave

### Tool Description
Interleaves two files, output is alternating between fwd/rev reads

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq interleave <infile_1> <infile_2> <outfile>

Interleaves two files, output is alternating between fwd/rev reads

positional arguments:
  infile_1           Name of first input file
  infile_2           Name of second input file
  outfile            Name of output file of interleaved reads

optional arguments:
  -h, --help         show this help message and exit
  --suffix1 SUFFIX1  Suffix to add to all names from infile_1 (if suffix not
                     already present)
  --suffix2 SUFFIX2  Suffix to add to all names from infile_2 (if suffix not
                     already present)
```


## fastaq_make_random_contigs

### Tool Description
Makes a multi-FASTA file of random sequences, all of the same length. Each base has equal chance of being A,C,G or T

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq make_random_contigs [options] <contigs> <length> <outfile>

Makes a multi-FASTA file of random sequences, all of the same length. Each
base has equal chance of being A,C,G or T

positional arguments:
  contigs               Number of contigs to make
  length                Length of each contig
  outfile               Name of output file

optional arguments:
  -h, --help            show this help message and exit
  --first_number FIRST_NUMBER
                        If numbering the sequences, the first sequence gets
                        this number [1]
  --name_by_letters     Name the contigs A,B,C,... will start at A again if
                        you get to Z
  --prefix PREFIX       Prefix to add to start of every sequence name
  --seed SEED           Seed for random number generator. Default is to use
                        python's default
```


## fastaq_merge

### Tool Description
Converts multi sequence file to a single sequence

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq merge [options] <infile> <outfile>

Converts multi sequence file to a single sequence

positional arguments:
  infile                Name of input file
  outfile               Name of output file

optional arguments:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  Name of sequence in output file [union]
```


## fastaq_replace_bases

### Tool Description
Replaces all occurrences of one letter with another

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq replace_bases <infile> <outfile> <old> <new>

Replaces all occurrences of one letter with another

positional arguments:
  infile      Name of input file
  outfile     Name of output file
  old         Base to be replaced
  new         Replace with this letter

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_reverse_complement

### Tool Description
Reverse complement all sequences

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq reverse_complement <infile> <outfile>

Reverse complement all sequences

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_scaffolds_to_contigs

### Tool Description
Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap
in the input

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq scaffolds_to_contigs [options] <infile> <outfile>

Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap
in the input

positional arguments:
  infile            Name of input file
  outfile           Name of output contigs file

optional arguments:
  -h, --help        show this help message and exit
  --number_contigs  Use this to enumerate contig names 1,2,3,... within each
                    scaffold
```


## fastaq_search_for_seq

### Tool Description
Searches for an exact match on a given string and its reverse complement, in every sequence of input sequence file. Case insensitive. Guaranteed to find all hits

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq search_for_seq [options] <infile> <outfile> <search_string>

Searches for an exact match on a given string and its reverse complement, in
every sequence of input sequence file. Case insensitive. Guaranteed to find
all hits

positional arguments:
  infile         Name of input file
  outfile        Name of outputfile. Tab-delimited output: sequence name,
                 position, strand
  search_string  String to search for in the sequences

optional arguments:
  -h, --help     show this help message and exit
```


## fastaq_sequence_trim

### Tool Description
Trims sequences off the start of all sequences in a pair of sequence files, whenever there is a perfect match. Only keeps a read pair if both reads of the pair are at least a minimum length after any trimming

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq sequence_trim [options] <infile_1> <infile_2> <outfile_1> <outfile_2> <trim_seqs>

Trims sequences off the start of all sequences in a pair of sequence files,
whenever there is a perfect match. Only keeps a read pair if both reads of the
pair are at least a minimum length after any trimming

positional arguments:
  infile_1          Name of forward fasta/q file to be trimmed
  infile_2          Name of reverse fasta/q file to be trimmed
  outfile_1         Name of output forward fasta/q file
  outfile_2         Name of output reverse fasta/q file
  trim_seqs         Name of file of sequences to search for at the start of
                    each input sequence

optional arguments:
  -h, --help        show this help message and exit
  --min_length INT  Minimum length of output sequences [50]
  --revcomp         Trim the end of each sequence if it matches the reverse
                    complement. This option is intended for PCR primer
                    trimming
```


## fastaq_sort_by_name

### Tool Description
Sorts sequences in lexographical (name) order

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq sort_by_name <infile> <outfile>

Sorts sequences in lexographical (name) order

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_sort_by_size

### Tool Description
Sorts sequences in length order

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq sort_by_size [options] <infile> <outfile>

Sorts sequences in length order

positional arguments:
  infile         Name of input file
  outfile        Name of output file

optional arguments:
  -h, --help     show this help message and exit
  -r, --reverse  Sort by shortest first instead of the default of longest
                 first
```


## fastaq_split_by_base_count

### Tool Description
Splits a multi sequence file into separate files. Does not split sequences.
Puts up to max_bases into each split file. The exception is that any sequence
longer than max_bases is put into its own file.

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq split_by_base_count [options] <infile> <outprefix> <max_bases>

Splits a multi sequence file into separate files. Does not split sequences.
Puts up to max_bases into each split file. The exception is that any sequence
longer than max_bases is put into its own file.

positional arguments:
  infile          Name of input file to be split
  outprefix       Name of output file
  max_bases       Max bases in each output split file

optional arguments:
  -h, --help      show this help message and exit
  --max_seqs INT  Max number of sequences in each output split file [no limit]
```


## fastaq_strip_illumina_suffix

### Tool Description
Strips /1 or /2 off the end of every read name

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq strip_illumina_suffix <infile> <outfile>

Strips /1 or /2 off the end of every read name

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_to_boulderio

### Tool Description
Converts input sequence file into "Boulder-IO" format, which is used by primer3

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_boulderio <infile> <outfile>

Converts input sequence file into "Boulder-IO" format, which is used by
primer3

positional arguments:
  infile      Name of input file
  outfile     Name of output files

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_to_fake_qual

### Tool Description
Make fake quality scores file

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_fake_qual [options] <infile> <outfile>

Make fake quality scores file

positional arguments:
  infile                Name of input file
  outfile               Name of output file

optional arguments:
  -h, --help            show this help message and exit
  -q QUAL, --qual QUAL  Quality score to assign to all bases [40]
```


## fastaq_to_fasta

### Tool Description
Converts a variety of input formats to nicely formatted FASTA format

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_fasta [options] <infile> <outfile>

Converts a variety of input formats to nicely formatted FASTA format

positional arguments:
  infile                Name of input file. Can be any of FASTA, FASTQ, GFF3,
                        EMBL, GBK, Phylip
  outfile               Name of output file

optional arguments:
  -h, --help            show this help message and exit
  -l LINE_LENGTH, --line_length LINE_LENGTH
                        Number of bases on each sequence line of output file.
                        Set to zero for no linebreaks in sequences [60]
  -s, --strip_after_whitespace
                        Remove everything after first whitespace in every
                        sequence name
  -u, --check_unique    Die if any of the output sequence names are not unique
```


## fastaq_to_mira_xml

### Tool Description
Create an xml file from a file of reads, for use with Mira assembler

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_mira_xml <infile> <xml_out>

Create an xml file from a file of reads, for use with Mira assembler

positional arguments:
  infile      Name of input fasta/q file
  xml_out     Name of output xml file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_to_orfs_gff

### Tool Description
Writes a GFF file of open reading frames from a sequence file

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_orfs_gff [options] <infile> <outfile>

Writes a GFF file of open reading frames from a sequence file

positional arguments:
  infile            Name of input file
  outfile           Name of output GFF file

optional arguments:
  -h, --help        show this help message and exit
  --min_length INT  Minimum length of ORF, in nucleotides [300]
```


## fastaq_to_perfect_reads

### Tool Description
Makes perfect paired end fastq reads from a sequence file, with insert sizes sampled from a normal distribution. Read orientation is innies. Output is an interleaved FASTQ file.

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_perfect_reads [options] <infile> <outfile> <mean insert size> <insert std deviation> <mean coverage> <read length>

Makes perfect paired end fastq reads from a sequence file, with insert sizes
sampled from a normal distribution. Read orientation is innies. Output is an
interleaved FASTQ file.

positional arguments:
  infile                Name of input file
  outfile               Name of output file
  mean insert size      Mean insert size of read pairs
  insert std deviation  Standard devation of insert size
  mean coverage         Mean coverage of the reads
  read length           Length of each read

optional arguments:
  -h, --help            show this help message and exit
  --fragments FILENAME  Write FASTA sequences of fragments (i.e. read pairs
                        plus sequences in between them) to the given filename
  --no_n                Don't allow any N or n characters in the reads
  --seed INT            Seed for random number generator. Default is to use
                        python's default
```


## fastaq_to_random_subset

### Tool Description
Takes a random subset of reads from a sequence file and optionally the corresponding read from a mates file. Output is interleaved if mates file given

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_random_subset [options] <infile> <outfile> <percent>

Takes a random subset of reads from a sequence file and optionally the
corresponding read from a mates file. Output is interleaved if mates file
given

positional arguments:
  infile                Name of input file
  outfile               Name of output file
  FLOAT                 Per cent probability of keeping any given read (pair)
                        in [0,100]

optional arguments:
  -h, --help            show this help message and exit
  --mate_file MATE_FILE
                        Name of mates file
  --seed INT            Seed for random number generator. If not given,
                        python's default is used
```


## fastaq_to_tiling_bam

### Tool Description
Takes a sequence file. Makes a BAM file containing perfect (unpaired) reads tiling the whole genome

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_tiling_bam [options] <infile> <read_length> <read_step> <read_prefix> <outfile>

Takes a sequence file. Makes a BAM file containing perfect (unpaired) reads
tiling the whole genome

positional arguments:
  infile                Name of input fasta/q file
  read_length           Length of reads
  read_step             Distance between start of each read
  read_prefix           Prefix of read names
  outfile               Name of output BAM file

optional arguments:
  -h, --help            show this help message and exit
  --qual_char QUAL_CHAR
                        Character to use for quality score [I]
  --read_group READ_GROUP
                        Add the given read group ID to all reads [42]

Important: assumes that samtools is in your path
```


## fastaq_to_unique_by_id

### Tool Description
Removes duplicate sequences from input file, based on their names. If the same
name is found more than once, then the longest sequence is kept. Order of
sequences is preserved in output

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_unique_by_id <infile> <outfile>

Removes duplicate sequences from input file, based on their names. If the same
name is found more than once, then the longest sequence is kept. Order of
sequences is preserved in output

positional arguments:
  infile      Name of input file
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```


## fastaq_translate

### Tool Description
Translates all sequences in input file. Output is always FASTA format

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq translate [options] <infile> <outfile>

Translates all sequences in input file. Output is always FASTA format

positional arguments:
  infile           Name of file to be translated
  outfile          Name of output FASTA file

optional arguments:
  -h, --help       show this help message and exit
  --frame {0,1,2}  Frame to translate [0]
```


## fastaq_trim_ns_at_end

### Tool Description
A collection of commands for manipulating DNA/RNA sequences.

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Task "trim_ns_at_end" not recognised. Cannot continue.

Usage: fastaq <command> [options]

To get minimal usage for a command use:
fastaq command

To get full help for a command use one of:
fastaq command -h
fastaq command --help


Available commands:

acgtn_only             Replace every non acgtnACGTN with an N
add_indels             Deletes or inserts bases at given position(s)
caf_to_fastq           Converts a CAF file to FASTQ format
capillary_to_pairs     Converts file of capillary reads to paired and unpaired files
chunker                Splits sequences into equal sized chunks
count_sequences        Counts the sequences in input file
deinterleave           Splits interleaved paired file into two separate files
enumerate_names        Renames sequences in a file, calling them 1,2,3... etc
expand_nucleotides     Makes every combination of degenerate nucleotides
fasta_to_fastq         Convert FASTA and .qual to FASTQ
filter                 Filter sequences to get a subset of them
get_ids                Get the ID of each sequence
get_seq_flanking_gaps  Gets the sequences flanking gaps
interleave             Interleaves two files, output is alternating between fwd/rev reads
make_random_contigs    Make contigs of random sequence
merge                  Converts multi sequence file to a single sequence
replace_bases          Replaces all occurrences of one letter with another
reverse_complement     Reverse complement all sequences
scaffolds_to_contigs   Creates a file of contigs from a file of scaffolds
search_for_seq         Find all exact matches to a string (and its reverse complement)
sequence_trim          Trim exact matches to a given string off the start of every sequence
sort_by_name           Sorts sequences in lexographical (name) order
sort_by_size           Sorts sequences in length order
split_by_base_count    Split multi sequence file into separate files
strip_illumina_suffix  Strips /1 or /2 off the end of every read name
to_boulderio           Converts to Boulder-IO format, used by primer3
to_fake_qual           Make fake quality scores file
to_fasta               Converts a variety of input formats to nicely formatted FASTA format
to_mira_xml            Create an xml file from a file of reads, for use with Mira assembler
to_orfs_gff            Writes a GFF file of open reading frames
to_perfect_reads       Make perfect paired reads from reference
to_random_subset       Make a random sample of sequences (and optionally mates as well)
to_tiling_bam          Make a BAM file of reads uniformly spread across the input reference
to_unique_by_id        Remove duplicate sequences, based on their names. Keep longest seqs
translate              Translate all sequences in input nucleotide sequences
trim_Ns_at_end         Trims all Ns at the start/end of all sequences
trim_contigs           Trims a set number of bases off the end of every contig
trim_ends              Trim fixed number of bases of start and/or end of every sequence
version                Print version number and exit
```


## fastaq_trim_contigs

### Tool Description
Trims a set number of bases off the end of every contig, so gaps get bigger and contig ends are removed. Bases are replaced with Ns. Any sequence that ends up as all Ns is lost

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq trim_contigs [options] <infile> <outfile>

Trims a set number of bases off the end of every contig, so gaps get bigger
and contig ends are removed. Bases are replaced with Ns. Any sequence that
ends up as all Ns is lost

positional arguments:
  infile                Name of input file
  outfile               Name of output file

optional arguments:
  -h, --help            show this help message and exit
  --trim_number TRIM_NUMBER
                        Number of bases to trim around each gap, and off ends
                        of each sequence [100]
```


## fastaq_trim_ends

### Tool Description
Trim fixed number of bases of start and/or end of every sequence

### Metadata
- **Docker Image**: biocontainers/fastaq:v3.17.0-2-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq trim_ends <infile> <bases off start> <bases off end> <outfile>

Trim fixed number of bases of start and/or end of every sequence

positional arguments:
  infile      Name of input file
  start_trim  Number of bases to trim off start
  end_trim    Number of bases to trim off end
  outfile     Name of output file

optional arguments:
  -h, --help  show this help message and exit
```

