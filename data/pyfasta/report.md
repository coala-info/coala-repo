# pyfasta CWL Generation Report

## pyfasta_extract

### Tool Description
Extract some sequences from a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
- **Homepage**: https://github.com/brentp/pyfasta
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyfasta/overview
- **Total Downloads**: 21.3K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/brentp/pyfasta
- **Stars**: N/A
### Original Help Text
```text
Usage: extract some sequences from a fasta file. e.g.:
               pyfasta extract --fasta some.fasta --header at2g26540 at3g45640

Options:
  -h, --help     show this help message and exit
  --fasta=FASTA  path to the fasta file
  --header       include headers
  --exclude      extract all sequences EXCEPT those listed
  --file         if this flag is used, the sequences to extract are read from
                 the file specified in args
  --space        use the fasta identifier only up to the space as the key
```


## pyfasta_info

### Tool Description
Print headers and lengths of the given fasta file in order of length.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
- **Homepage**: https://github.com/brentp/pyfasta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:    print headers and lengths of the given fasta file in order of length. e.g.:
        pyfasta info --gc some.fasta

Options:
  -h, --help           show this help message and exit
  -n NSEQS, --n=NSEQS  max number of records to print. use -1 for all
  --gc                 show gc content
```


## pyfasta_split

### Tool Description
split a fasta file into separated files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
- **Homepage**: https://github.com/brentp/pyfasta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:    split a fasta file into separated files.
        pyfasta split -n 6 [-k 5000 ] some.fasta
    the output will be some.0.fasta, some.1.fasta ... some.6.fasta
    the sizes will be as even as reasonable.
   

Options:
  -h, --help            show this help message and exit
  --header=FILENAME_FMT
                        this overrides all other options. if specified, it
                        will                split the file into a separate
                        file for each header. it                will be a
                        template specifying the file name for each new file.
                        e.g.:    "%(fasta)s.%(seqid)s.fasta"
                        where 'fasta' is the basename of the input fasta file
                        and seqid                is the header of each entry
                        in the fasta file.
  -n NSPLITS, --n=NSPLITS
                        number of new files to create
  -o OVERLAP, --overlap=OVERLAP
                        overlap in basepairs
  -k KMERS, --kmers=KMERS
                            split big files into pieces of this size in
                        basepairs. default     default of -1 means do not
                        split the sequence up into k-mers, just     split
                        based on the headers. a reasonable value would be
                        10Kbp
```


## pyfasta_flatten

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
- **Homepage**: https://github.com/brentp/pyfasta
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: flatten a fasta file *inplace* so all later access by pyfasta will use that flattend (but still viable) fasta file

Options:
  -h, --help  show this help message and exit
```

