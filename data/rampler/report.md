# rampler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rampler_split | PASS | 8 chunks of about 450 kB for a 500000 byte chunk size |
| rampler_subsample | PASS | 5x and 10x subsamples hold about 5.4x and 9.7x of the 48.5 kb lambda reference |


## rampler_subsample

### Tool Description
usage: rampler [options ...] <mode>

### Metadata
- **Docker Image**: biocontainers/rampler:v1.1.0-1-deb_cv1
- **Homepage**: https://github.com/rvaser/rampler
- **Package**: https://anaconda.org/channels/bioconda/packages/rampler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rampler [options ...] <mode>

    <mode>
        subsample <sequences> <reference length> <coverage> [<coverage> ...]

            <sequences>
                input file in FASTA/FASTQ format (can be compressed with gzip)
                containing sequences to be subsampled
            <reference length>
                integer denoting length of the reference genome (or
                assembly) from which the sequences originate
            <coverage>
                integer denoting desired coverage of the subsampled
                sequences

        split <sequences> <chunk size>

            <sequences>
                input file in FASTA/FASTQ format (can be compressed with gzip)
                containing sequences which will be split into smaller chunks
            <chunk size>
                integer denoting the desired chunk size in bytes

    options:
        -o, --out-directory
            default: current directory
            path in which sampled files will be created
        --version
            prints the version number
        -h, --help
            prints the usage
```

## rampler_split

### Tool Description
usage: rampler [options ...] <mode>

### Metadata
- **Docker Image**: biocontainers/rampler:v1.1.0-1-deb_cv1
- **Homepage**: https://github.com/rvaser/rampler
- **Package**: https://anaconda.org/channels/bioconda/packages/rampler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rampler [options ...] <mode>

    <mode>
        subsample <sequences> <reference length> <coverage> [<coverage> ...]

            <sequences>
                input file in FASTA/FASTQ format (can be compressed with gzip)
                containing sequences to be subsampled
            <reference length>
                integer denoting length of the reference genome (or
                assembly) from which the sequences originate
            <coverage>
                integer denoting desired coverage of the subsampled
                sequences

        split <sequences> <chunk size>

            <sequences>
                input file in FASTA/FASTQ format (can be compressed with gzip)
                containing sequences which will be split into smaller chunks
            <chunk size>
                integer denoting the desired chunk size in bytes

    options:
        -o, --out-directory
            default: current directory
            path in which sampled files will be created
        --version
            prints the version number
        -h, --help
            prints the usage
```

