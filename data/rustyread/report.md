# rustyread CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rustyread_simulate | PASS | about 5x of reads simulated with real badread nanopore2020 model files; model names (default) need Python badread, so model files are passed as inputs |

## rustyread_simulate

### Tool Description
Generate fake long read

### Metadata
- **Docker Image**: quay.io/biocontainers/rustyread:0.4.1--heebf65f_4
- **Homepage**: https://github.com/natir/rustyread
- **Package**: https://anaconda.org/channels/bioconda/packages/rustyread/overview
- **Validation**: PASS

### Original Help Text
```text
rustyread-simulate 
Generate fake long read

USAGE:
    rustyread simulate [OPTIONS] --reference <REFERENCE_PATH> --quantity <QUANTITY>

OPTIONS:
        --chimera <CHIMERA>
            Percentage at which separate fragments join together [default: 1]

        --end_adapter <END_ADAPTER>
            Adapter parameters for read ends (rate and amount) [default: 50,20]

        --end_adapter_seq <END_ADAPTER_SEQ>
            Adapter parameters for read ends [default: GCAATACGTAACTGAACGAAGT]

        --error_model <ERROR_MODEL>
            Path to an error model file [default: nanopore2020]

        --glitches <GLITCHES>
            Read glitch parameters (rate, size and skip) [default: 10000,25,25]

    -h, --help
            Print help information

        --identity <IDENTITY>
            Sequencing identity distribution (mean, max and stdev) [default: 85,95,5]

        --junk_reads <JUNK>
            This percentage of reads wil be low complexity junk [default: 1]

        --length <LENGTH>
            Fragment length distribution (mean and stdev) [default: 15000,13000]

        --number_base_store <NB_BASE_STORE>
            Number of base, rustyread can store in ram before write in output in absolute value
            (e.g. 250M) or a relative depth (e.g. 25x)

        --output <OUTPUT_PATH>
            Path where read is write

        --qscore_model <QSCORE_MODEL>
            Path to an quality score model file [default: nanopore2020]

        --quantity <QUANTITY>
            Either an absolute value (e.g. 250M) or a relative depth (e.g. 25x)

        --random_reads <RANDOM>
            This percentage of reads wil be random sequence [default: 1]

        --reference <REFERENCE_PATH>
            Path to reference fasta (can be gzipped, bzip2ped, xzped)

        --seed <SEED>
            Random number generator seed for deterministic output (default: different output each
            time)

        --small_plasmid_bias
            If set, then small circular plasmids are lost when the fragment length is too high
            (default: small plasmids are included regardless of fragment length)

        --start_adapter <START_ADAPTER>
            Adapter parameters for read starts (rate and amount) [default: 90,60]

        --start_adapter_seq <START_ADAPTER_SEQ>
            Adapter parameters for read starts [default: AATGTACTTCGTTCAGTTACGTATTGCT]
```


## Metadata
- **Skill**: generated
