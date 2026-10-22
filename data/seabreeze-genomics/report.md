# seabreeze-genomics CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seabreeze-genomics_batch | Failed | image problem: seabreeze always runs snakemake --use-conda but the image has no conda command (conda: command not found) |
| seabreeze-genomics_run | Failed | image problem: seabreeze always runs snakemake --use-conda but the image has no conda command (conda: command not found) |

## seabreeze-genomics_run

### Tool Description
Execute given workflow for single sample

### Metadata
- **Docker Image**: quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/seabreeze
- **Package**: https://anaconda.org/channels/bioconda/packages/seabreeze-genomics/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seabreeze run [OPTIONS] {analyse_genome_sizes|predict_IS_elements|predi
                     ct_structural_variants|predict_replichore_balance|predict
                     _SV_mechanism|annotate_SV_regions|run_all}
                     [SNAKEMAKE_ARGS]...

  Execute given workflow for single sample

Options:
  -d, --dir PATH     Set working directory. Default is current working
                     directory
  --ancestor PATH    Path to FASTA file of the ancestor or reference sequence
  --assembly PATH    Path to FASTA file of the assembly or query sequence
  --threads INTEGER  Resources to be used.  [default: 4]
  --ori TEXT         Sequence of the origin. Must use IUPAC bases, and be
                     unique in both the ancestor and assembly. Required for
                     predict_replichore_balance or run_all workflows
  --dif TEXT         Sequence of the terminus. Must use standard IUPAC bases,
                     and be unique in both the ancestor and assembly.
                     Required for predict_replichore_balance or run_all
                     workflows
  --masked           Mask insertion sequences
  -h, --help         Show this message and exit.
```

## seabreeze-genomics_batch

### Tool Description
Execute given workflow for batch processing

### Metadata
- **Docker Image**: quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/barricklab/seabreeze
- **Package**: https://anaconda.org/channels/bioconda/packages/seabreeze-genomics/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seabreeze batch [OPTIONS] {analyse_genome_sizes|predict_IS_elements|pre
                       dict_structural_variants|predict_replichore_balance|pre
                       dict_SV_mechanism|annotate_SV_regions|run_all}
                       [SNAKEMAKE_ARGS]...

  Execute given workflow for batch processing

Options:
  -d, --dir PATH     Set working directory where output will be created.
                     Default is current working directory
  -b, --data PATH    Path to data.csv file. Default is data.csv in current
                     working dir
  --oridif PATH      Path to csv file with sequences for the origin and
                     terminus. Default is ori_dif_coords.csv in the current
                     working dir. Required for predict_replichore_balance or
                     run_all workflows
  --threads INTEGER  Resources to be used.  [default: 4]
  --masked           Mask insertion sequences
  -h, --help         Show this message and exit.
```

