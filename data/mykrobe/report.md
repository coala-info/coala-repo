# mykrobe CWL Generation Report

## mykrobe_predict

### Tool Description
Predicts antimicrobial resistance from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
- **Homepage**: https://github.com/iqbal-lab/Mykrobe-predictor
- **Package**: https://anaconda.org/channels/bioconda/packages/mykrobe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mykrobe/overview
- **Total Downloads**: 81.0K
- **Last updated**: 2025-06-10
- **GitHub**: https://github.com/iqbal-lab/Mykrobe-predictor
- **Stars**: N/A
### Original Help Text
```text
usage: mykrobe predict [-h] -s SAMPLE [-k kmer] [--tmp TMP] [--keep_tmp]
                       [--skeleton_dir SKELETON_DIR] [-t THREADS] [-m MEMORY]
                       [--expected_depth EXPECTED_DEPTH] [-1 seq [seq ...]]
                       [-c ctx] [-f] [--ont] [--guess_sequence_method]
                       [--ignore_minor_calls]
                       [--ignore_filtered IGNORE_FILTERED] [--model model]
                       [--ploidy ploidy] [--filters FILTERS [FILTERS ...]]
                       [-A] [--dump_species_covgs FILENAME]
                       [-e EXPECTED_ERROR_RATE]
                       [--min_variant_conf MIN_VARIANT_CONF]
                       [--min_gene_conf MIN_GENE_CONF]
                       [-D MIN_PROPORTION_EXPECTED_DEPTH]
                       [--min_gene_percent_covg_threshold MIN_GENE_PERCENT_COVG_THRESHOLD]
                       [-o OUTPUT] [--ncbi_names] [--panels_dir DIRNAME] [-q]
                       [-d] -S species [--panel panel] [-P FILENAME]
                       [-R FILENAME] [-L FILENAME] [--min_depth min_depth]
                       [--conf_percent_cutoff conf_percent_cutoff]
                       [-O {json,csv,json_and_csv}]

optional arguments:
  -h, --help            show this help message and exit
  -s SAMPLE, --sample SAMPLE
                        Sample identifier [REQUIRED]
  -k kmer, --kmer kmer  K-mer length (default: 21)
  --tmp TMP             Directory to write temporary files to
  --keep_tmp            Don't remove temporary files
  --skeleton_dir SKELETON_DIR
                        Directory for skeleton binaries
  -t THREADS, --threads THREADS
                        Number of threads to use
  -m MEMORY, --memory MEMORY
                        Memory to allocate for graph constuction (default:
                        1GB)
  --expected_depth EXPECTED_DEPTH
                        Expected depth
  -1 seq [seq ...], -i seq [seq ...], --seq seq [seq ...]
                        Sequence files (fasta,fastq,bam)
  -c ctx, --ctx ctx     Cortex graph binary
  -f, --force           Force override any skeleton files
  --ont                 Set defaults for ONT data. Sets `-e 0.08 --ploidy
                        haploid`
  --guess_sequence_method
                        Guess if ONT or Illumia based on error rate. If error
                        rate is > 10%, ploidy is set to haploid and a
                        confidence threshold is used
  --ignore_minor_calls  Ignore minor calls when running resistance prediction
  --ignore_filtered IGNORE_FILTERED
                        Don't include filtered genotypes
  --model model         Genotype model used. Options kmer_count, median_depth
                        (default: kmer_count)
  --ploidy ploidy       Use a diploid (includes 0/1 calls) or haploid
                        genotyping model (default: diploid)
  --filters FILTERS [FILTERS ...]
                        Don't include specific filtered genotypes (default:
                        ['MISSING_WT', 'LOW_PERCENT_COVERAGE', 'LOW_GT_CONF',
                        'LOW_TOTAL_DEPTH'])
  -A, --report_all_calls
                        Report all calls
  --dump_species_covgs FILENAME
                        Dump species probes coverage information to a JSON
                        file
  -e EXPECTED_ERROR_RATE, --expected_error_rate EXPECTED_ERROR_RATE
                        Expected sequencing error rate (default: 0.050)
  --min_variant_conf MIN_VARIANT_CONF
                        Minimum genotype confidence for variant genotyping
                        (default: 150)
  --min_gene_conf MIN_GENE_CONF
                        Minimum genotype confidence for gene genotyping
                        (default: 1)
  -D MIN_PROPORTION_EXPECTED_DEPTH, --min_proportion_expected_depth MIN_PROPORTION_EXPECTED_DEPTH
                        Minimum depth required on the sum of both alleles
                        (default: 0.30)
  --min_gene_percent_covg_threshold MIN_GENE_PERCENT_COVG_THRESHOLD
                        All genes alleles found above this percent coverage
                        will be reported (default: 100 (only best alleles
                        reported))
  -o OUTPUT, --output OUTPUT
                        File path to save output file as. Default is to stdout
  --ncbi_names          Report NCBI species names in addiition to the usual
                        species names in the JSON output. Only applies when
                        the species is tb
  --panels_dir DIRNAME  Name of directory that contains panel data (default:
                        /usr/local/lib/python3.8/site-packages/mykrobe/data)
  -q, --quiet           Only output warnings/errors to stderr
  -d, --debug           Output debugging information to stderr
  -S species, --species species
                        Species name, or 'custom' to use custom data, in which
                        case --custom_probe_set_path is required. Run `mykrobe
                        panels describe` to see list of options [REQUIRED]
  --panel panel         Name of panel to use. Ignored if species is 'custom'.
                        Run `mykrobe panels describe` to see list of options
  -P FILENAME, --custom_probe_set_path FILENAME
                        Required if species is 'custom'. Ignored otherwise.
                        File path to fasta file from `mykrobe make-probes`.
  -R FILENAME, --custom_variant_to_resistance_json FILENAME
                        For use with `--panel custom`. Ignored otherwise. File
                        path to JSON with key,value pairs of variant names and
                        induced drug resistance.
  -L FILENAME, --custom_lineage_json FILENAME
                        For use with `--panel custom`. Ignored otherwise. File
                        path to JSON made by --lineage option of make-probes
  --min_depth min_depth
                        Minimum depth (default: 1)
  --conf_percent_cutoff conf_percent_cutoff
                        Number between 0 and 100. Determines
                        --min_variant_conf, by simulating variants and
                        choosing the cutoff that would keep x% of the variants
                        (default: 100)
  -O {json,csv,json_and_csv}, --format {json,csv,json_and_csv}
                        Choose output format (default: csv)
```


## mykrobe_panels

### Tool Description
Manage mykrobe panels

### Metadata
- **Docker Image**: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
- **Homepage**: https://github.com/iqbal-lab/Mykrobe-predictor
- **Package**: https://anaconda.org/channels/bioconda/packages/mykrobe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mykrobe panels [-h] [-q] [-d]
                      {describe,update_metadata,update_species} ...

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Only output warnings/errors to stderr
  -d, --debug           Output debugging information to stderr

[sub-commands]:
  {describe,update_metadata,update_species}
                        help
    describe            Describe all known panels
    update_metadata     Update metadata about available species and their
                        panels
    update_species      Update species panel(s)
```


## mykrobe_variants

### Tool Description
mykrobe variants

### Metadata
- **Docker Image**: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
- **Homepage**: https://github.com/iqbal-lab/Mykrobe-predictor
- **Package**: https://anaconda.org/channels/bioconda/packages/mykrobe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mykrobe variants [-h] [-q] [-d] {add,dump-probes,make-probes} ...

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Only output warnings/errors to stderr
  -d, --debug           Output debugging information to stderr

[sub-commands]:
  {add,dump-probes,make-probes}
                        help
    add                 adds a set of variants to the database
    dump-probes         dump a probe set of variant alleles from VCFs stored
                        in database
    make-probes         make probes from a list of variants
```


## mykrobe_vars

### Tool Description
Manage variant databases

### Metadata
- **Docker Image**: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
- **Homepage**: https://github.com/iqbal-lab/Mykrobe-predictor
- **Package**: https://anaconda.org/channels/bioconda/packages/mykrobe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mykrobe variants [-h] [-q] [-d] {add,dump-probes,make-probes} ...

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Only output warnings/errors to stderr
  -d, --debug           Output debugging information to stderr

[sub-commands]:
  {add,dump-probes,make-probes}
                        help
    add                 adds a set of variants to the database
    dump-probes         dump a probe set of variant alleles from VCFs stored
                        in database
    make-probes         make probes from a list of variants
```


## Metadata
- **Skill**: generated
