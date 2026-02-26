# pyfastaq CWL Generation Report

## pyfastaq_fastaq

### Tool Description
A command-line tool for manipulating FASTA and FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Total Downloads**: 44.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/Fastaq
- **Stars**: N/A
### Original Help Text
```text
Task "--h" not recognised. Cannot continue.

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


## pyfastaq_fastaq acgtn_only

### Tool Description
Filter FASTA/FASTQ sequences to only include ACGTN characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq trim_Ns_at_end

### Tool Description
Remove Ns from the ends of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq strip_illumina_suffix

### Tool Description
Remove Illumina suffix from FASTA/FASTQ IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq filter

### Tool Description
Filter FASTA/FASTQ files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq sort_by_size

### Tool Description
Sort FASTA/FASTQ files by sequence length.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq sort_by_name

### Tool Description
Sort FASTA/FASTQ records by name.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq to_unique_by_id

### Tool Description
Remove duplicate sequences from a FASTA or FASTQ file, keeping only the first occurrence of each sequence ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq interleave

### Tool Description
Interleave two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq deinterleave

### Tool Description
Deinterleaves a FASTAQ file into two separate FASTAQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq to_fasta

### Tool Description
Convert FASTA to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq fasta_to_fastq

### Tool Description
Convert FASTA to FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq scaffolds_to_contigs

### Tool Description
Convert scaffolds to contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq count_sequences

### Tool Description
Count the number of sequences in a FASTA or FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq to_random_subset

### Tool Description
Select a random subset of sequences from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq search_for_seq

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq to_fake_qual

### Tool Description
Convert FASTA to FASTQ with fake quality scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq reverse_complement

### Tool Description
Reverse complement a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```


## pyfastaq_fastaq translate

### Tool Description
Translate DNA sequences to protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fastaq", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/pyfastaq/app_fastaq.py", line 70, in main
    exec('pyfastaq.runners.' + task + '.run("' + tasks[task] + '")')
    ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 1, in <module>
NameError: name 'pyfastaq' is not defined
```

