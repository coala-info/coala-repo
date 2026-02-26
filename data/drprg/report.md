# drprg CWL Generation Report

## drprg_build

### Tool Description
Build an index to predict resistance from

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mbhall88/drprg
- **Stars**: N/A
### Original Help Text
```text
Build an index to predict resistance from

Usage: drprg build [OPTIONS] --gff <FILE> --panel <FILE> --fasta <FILE>

Options:
  -p, --pandora <FILE>
          Path to pandora executable. Will try in src/ext or $PATH if not given

  -v, --verbose
          Use verbose output

  -m, --makeprg <FILE>
          Path to make_prg executable. Will try in src/ext or $PATH if not given

  -t, --threads <INT>
          Maximum number of threads to use
          
          Use 0 to select the number automatically
          
          [default: 1]

  -M, --mafft <FILE>
          Path to MAFFT executable. Will try in src/ext or $PATH if not given

  -B, --bcftools <FILE>
          Path to bcftools executable. Will try in src/ext or $PATH if not given

  -P, --padding <INT>
          Number of bases of padding to add to start and end of each gene
          
          [default: 100]

  -l, --match-len <INT>
          Minimum number of consecutive characters which must be identical for a match in make_prg
          
          [default: 5]

  -N, --max-nesting <INT>
          Maximum nesting level when constructing the reference graph with make_prg
          
          [default: 5]

  -k, --pandora-k <INT>
          Kmer size to use for pandora
          
          [default: 15]

  -w, --pandora-w <INT>
          Window size to use for pandora
          
          [default: 11]

  -I, --no-fai
          Don't index --fasta if an index doesn't exist

  -C, --no-csi
          Don't index --vcf if an index doesn't exist

      --version <VERSION>
          Version to use for the index
          
          [default: 20260225]

  -h, --help
          Print help (see a summary with '-h')

Input/Output:
  -a, --gff <FILE>
          Annotation file that will be used to gather information about genes in catalogue

  -i, --panel <FILE>
          Panel/catalogue to build index for

  -f, --fasta <FILE>
          Reference genome in FASTA format (must be indexed with samtools faidx)

  -b, --vcf <FILE>
          An indexed VCF to build the index PRG from. If not provided, then a prebuilt PRG must be given. See `--prebuilt-prg`

  -o, --outdir <DIR>
          Directory to place output
          
          [default: .]

  -d, --prebuilt-prg <DIR>
          A prebuilt PRG to use.
          
          Only build the panel VCF and reference sequences - not the PRG. This directory MUST contain a PRG file named `dr.prg`, along, with a directory called `msas/` that contains an MSA fasta file for each gene `<gene>.fa`. There can optionally also be a pandora index file, but if not, the indexing will be performed by drprg. Note: the PRG is expected to contain the reference sequence for each gene according to the annotation and reference genome given (along with padding) and must be in the forward strand orientation.

  -r, --rules <FILE>
          "Expert rules" to be applied in addition to the catalogue.
          
          CSV file with blanket rules that describe resistance (or susceptibility). The columns are <variant type>,<gene>,<start>,<end>,<drug(s)>. See the docs for a detailed explanation.
```


## drprg_Build

### Tool Description
Build a DRaWoR program

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Build'

  tip: a similar subcommand exists: 'build'
  tip: to pass 'Build' as a value, use 'drprg -- Build'

Usage: drprg [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## drprg_predict

### Tool Description
Predict drug resistance

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
Predict drug resistance

Usage: drprg predict [OPTIONS] --index <DIR> --input <FILE>

Options:
  -p, --pandora <FILE>
          Path to pandora executable. Will try in src/ext or $PATH if not given

  -v, --verbose
          Use verbose output

  -m, --makeprg <FILE>
          Path to make_prg executable. Will try in src/ext or $PATH if not given

  -t, --threads <INT>
          Maximum number of threads to use
          
          Use 0 to select the number automatically
          
          [default: 1]

  -M, --mafft <FILE>
          Path to MAFFT executable. Will try in src/ext or $PATH if not given

  -h, --help
          Print help (see a summary with '-h')

Input/Output:
  -x, --index <DIR>
          Name of a downloaded index or path to an index

  -i, --input <FILE>
          Reads to predict resistance from
          
          Both fasta and fastq are accepted, along with compressed or uncompressed.

  -o, --outdir <DIR>
          Directory to place output
          
          [default: .]

  -s, --sample <SAMPLE>
          Identifier to use for the sample
          
          If not provided, this will be set to the input reads file path prefix

  -I, --illumina
          Sample reads are from Illumina sequencing

Filter:
  -S, --ignore-synonymous
          Ignore unknown (off-catalogue) variants that cause a synonymous substitution

  -f, --maf <FLOAT[0.0-1.0]>
          Minimum allele frequency to call variants
          
          If an alternate allele has at least this fraction of the depth, a minor resistance ("r") prediction is made. Set to 1 to disable. If --illumina is passed, the default is 0.1
          
          [default: 1]

      --debug
          Output debugging files. Mostly for development purposes

  -d, --min-covg <INT>
          Minimum depth of coverage allowed on variants
          
          [default: 3]

  -D, --max-covg <INT>
          Maximum depth of coverage allowed on variants
          
          [default: 2147483647]

  -b, --min-strand-bias <FLOAT>
          Minimum strand bias ratio allowed on variants
          
          For example, setting to 0.25 requires >=25% of total (allele) coverage on both strands for an allele.
          
          [default: 0.01]

  -g, --min-gt-conf <FLOAT>
          Minimum genotype confidence (GT_CONF) score allow on variants
          
          [default: 0]

  -L, --max-indel <INT>
          Maximum (absolute) length of insertions/deletions allowed

  -K, --min-frs <FLOAT>
          Minimum fraction of read support
          
          For example, setting to 0.9 requires >=90% of coverage for the variant to be on the called allele
          
          [default: 0]
```


## drprg_Predict

### Tool Description
Command-line tool for running various prediction tasks.

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Predict'

  tip: a similar subcommand exists: 'predict'
  tip: to pass 'Predict' as a value, use 'drprg -- Predict'

Usage: drprg [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## drprg_index

### Tool Description
Download and interact with indices

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
Download and interact with indices

Usage: drprg index [OPTIONS] [NAME]

Arguments:
  [NAME]
          The name/path of the index to download
          
          [default: all]

Options:
  -d, --download
          Download a prebuilt index

  -v, --verbose
          Use verbose output

  -l, --list
          List all available (and downloaded) indices

  -t, --threads <INT>
          Maximum number of threads to use
          
          Use 0 to select the number automatically
          
          [default: 1]

  -o, --outdir <DIR>
          Index directory
          
          Use this if your indices are not in a default location, or you want to download them to a non-default location
          
          [default: /root/.drprg/]

  -F, --force
          Overwrite any existing indices

  -h, --help
          Print help (see a summary with '-h')
```


## drprg_Download

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Download'

Usage: drprg [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## drprg_Print

### Tool Description
A command-line tool for managing and processing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Print'

Usage: drprg [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## drprg_Use

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Use'

Usage: drprg [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## drprg_Maximum

### Tool Description
A command-line tool for managing and processing data. This specific invocation seems to be for a subcommand that is not recognized.

### Metadata
- **Docker Image**: quay.io/biocontainers/drprg:0.1.1--h5076881_1
- **Homepage**: https://github.com/mbhall88/drprg
- **Package**: https://anaconda.org/channels/bioconda/packages/drprg/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Maximum'

Usage: drprg [OPTIONS] <COMMAND>

For more information, try '--help'.
```

