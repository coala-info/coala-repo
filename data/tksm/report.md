# tksm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tksm_abundance | PASS | real MCF7 nanopore cDNA reads mapped to chr22 transcripts; TPM values sum to 1e6 |
| tksm_filter | PASS | synthetic data by design: 204 molecules split into 123 and 81 by size |
| tksm_flip | PASS | synthetic data by design: strands flipped for about half of the molecules |
| tksm_head | PASS | synthetic data by design: first 3 molecules printed |
| tksm_model-errors | Failed | image problem: the module only prints its description; Badread is not installed in the image |
| tksm_model-qscores | Failed | image problem: the module only prints its description; Badread is not installed in the image |
| tksm_model-truncation | PASS | real MCF7 nanopore cDNA reads mapped to chr22 transcripts (minimap2 helper image); KDE model written |
| tksm_polyA | PASS | synthetic data by design: polyA tails added to all 204 molecules |
| tksm_sequence | PASS | synthetic data by design: 204 simulated reads, mean identity 84 percent as set by the default model |
| tksm_transcribe | PASS | synthetic data by design: 204 molecules from the real abundance table and chr22 GTF |
| tksm_truncate | PASS | synthetic data by design: molecules truncated with the model trained on real reads |

## tksm_model-errors

### Tool Description
Model sequencing errors using Badread

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1' locally
0.6.1--py310ha025fb0_1: Pulling from biocontainers/tksm
66a7cd3f1734: Pulling fs layer
66a7cd3f1734: Download complete
66a7cd3f1734: Pull complete
Digest: sha256:3765f48561d6a4a48fe6173aa7d7cf677436bb3903b5911daad1ba19a93b1259
Status: Downloaded newer image for quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
Model errors using Badread
```

## tksm_model-qscores

### Tool Description
Model sequencing quality scores using Badread

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Model qscores using Badread
```

## tksm_model-truncation

### Tool Description
Kernel density estimate of read truncation from the cDNA mapping of long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: model-truncation [-h] -i INPUT -o OUTPUT [-b BANDWIDTH]
                        [--grid-start GRID_START] [--grid-end GRID_END]
                        [--grid-step GRID_STEP] [-t THREADS] [--model-lengths]
                        [--list] [--end-ratio END_RATIO]

KDE computation module of truncation of transcriptomic long-reads using their
cDNA mapping.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        PAF file of the mapping of the long-reads to the
                        reference transcriptome. (default: None)
  -o OUTPUT, --output OUTPUT
                        Path prefix for the output JSON model (e.g.
                        sample.json). (default: None)
  -b BANDWIDTH, --bandwidth BANDWIDTH
                        Bandwidth value for the KDE. If set to -1, script will
                        use cross validation to compute it. (default: 100.0)
  --grid-start GRID_START
                        Read/transcript length start of the KDE grid.
                        (default: 0)
  --grid-end GRID_END   Read/transcript length end of the KDE grid. (default:
                        10000)
  --grid-step GRID_STEP
                        Read/transcript length step of the KDE grid. (default:
                        100)
  -t THREADS, --threads THREADS
                        Number of threads to run KDE and GridSearchCV.
                        (default: 1)
  --model-lengths       Model read lengths instead of truncation lengths
                        (default: False)
  --list
  --end-ratio END_RATIO
                        Ratio of truncation from the end of the molecule. If
                        set to -1, TKSM will build a distribution of the end
                        ratios from the PAF file.If set between 0 and 1, TKSM
                        will use this value as the end ratio for all
                        molecules. (default: -1)
```

## tksm_abundance

### Tool Description
Output a TSV file of the long-read transcript expression

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: abundance [-h] -p PAF [-m LR_BR] [--cb-count CB_COUNT]
                 [--cb-lognorm-params CB_LOGNORM_PARAMS]
                 [--cb-pattern CB_PATTERN] [--cb-dropout CB_DROPOUT]
                 [--cb-txt CB_TXT] -o OUTPUT [-em EM_ITERATIONS]
                 [--random-seed RANDOM_SEED] [-v VERBOSE] [--list]

Output a TSV file of the long-read trasncript expresion.

options:
  -h, --help            show this help message and exit
  -p PAF, --paf PAF     PAF file of the mapping of the long-reads to the
                        reference transcriptome. (default: None)
  -m LR_BR, --lr-br LR_BR
                        TSV output of the long-reads barcode matching from
                        scTager (e.g. S1.lr_matches.tsv.gz) (default: )
  --cb-count CB_COUNT   Number of cell barcodes to simulate. If >0, then the
                        abundance will be split by cell barcodes according to
                        a normal distribution. Cannot be used with --lr-br
                        parameter. (default: 0)
  --cb-lognorm-params CB_LOGNORM_PARAMS
                        Parameters for the lognormal distribution of cell
                        barcodes abundance. Takes two comma-separated values:
                        mean and standard deviation. (default: 10,1)
  --cb-pattern CB_PATTERN
                        FASTA pattern for the cell barcode. If used, --cb-
                        count parameter must also be used. (default:
                        NNNNNNNNNNNN)
  --cb-dropout CB_DROPOUT
                        Fraction of reads without cell barcodes. If used,
                        --cb-count parameter must also be used. (default: 0.2)
  --cb-txt CB_TXT       Path to a text file of cell barcodes whitelist, one
                        per line.If used, --cb-count parameter must also be
                        used.Do not use with --cb-pattern parameter. (default:
                        )
  -o OUTPUT, --output OUTPUT
                        Path for the output file (e.g
                        cDNA.abundance.tsv.tsv.gz or cDNA.abundance.tsv).Will
                        be gzipped if it ends with .gz extenstion. (default:
                        None)
  -em EM_ITERATIONS, --em-iterations EM_ITERATIONS
  --random-seed RANDOM_SEED
  -v VERBOSE, --verbose VERBOSE
  --list
```

## tksm_transcribe

### Tool Description
Build RNA transcript molecules given abundances and a GTF annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
RNA Splicing module
Usage:
  Splicer [OPTION...]

 utility options:
  -h, --help           Print help
      --version        Print version
  -s, --seed arg       random seed (default: 42)
      --list           list available options
      --verbosity arg  Verbosity level to choosen from [DEBUG, ERROR, INFO, 
                       OFF, WARN] (default: INFO)
      --log-file arg   Log file to write the logs (or stderr/stdout) 
                       (default: stderr)

 submodule:fusion options:
      --fusion-gtf arg          Path to output GTF annotation file
      --fusion-file arg         Path to tab separated fusion file
      --fusion-output arg       Description of generated fusions
      --fusion-count arg        Number of random fusions to generate 
                                (default: 0)
      --disable-deletions       Disables deletions (from fusions) that 
                                removes expression on the overlapping genes
      --translocation-ratio arg
                                Ratio of translocated fusions (default: 0)
      --expression-fallback arg
                                Fallback expression distribution for 
                                transcripts that are not expressed. If not 
                                provided only expressed transcripts will be 
                                fused. Comma separated list of distribution 
                                type and parameters. Available 
                                distributions: uniform,s,e; normal,μ,σ. 

 main options:
  -g, --gtf arg              Path to gtf annotation files
  -a, --abundance arg        Path to tab separated abundances tables 
                             (formatted as transcript_id\tpm\cell-barcode)
      --use-whole-id         Do not trim the transcript version
      --molecule-count arg   Number of molecules to simulate
  -o, --output arg           Output path
      --non-coding           Process non-coding genes/transcripts as well
      --default-depth arg    Default depth for transcripts that are not in 
                             expression table (default: 0)
      --molecule-prefix arg  Prefix for molecule names (default: M)
  -w, --weights arg          Comma separated weights of each provided 
                             abundance file (default: 1)
```

## tksm_truncate

### Tool Description
Simulate read truncation of molecules

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Truncate module
Usage:
  truncate [OPTION...]

 utility options:
  -h, --help           Print help
      --version        Print version
  -s, --seed arg       random seed (default: 42)
      --list           list available options
      --verbosity arg  Verbosity level to choosen from [DEBUG, ERROR, INFO, 
                       OFF, WARN] (default: INFO)
      --log-file arg   Log file to write the logs (or stderr/stdout) 
                       (default: stderr)

 main options:
  -i, --input arg          input mdf file
  -o, --output arg         output mdf file
      --kde-model arg      [model].json generated by the truncation 
                           modelling
      --always-end         Ignore sider.tsv and always 3' end truncate
      --kde-models-length  KDE models read length instead of truncation 
                           length
      --normal arg         Use Normal distribution [μ,σ]
      --lognormal arg      Use Log-Normal distribution [μ,σ]
```

## tksm_polyA

### Tool Description
Add polyA tails to molecules with a given size distribution

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Adds polyA tails to molecules with given size distribution
Usage:
  polyA module [OPTION...]

 utility options:
  -h, --help           Print help
      --version        Print version
  -s, --seed arg       random seed (default: 42)
      --list           list available options
      --verbosity arg  Verbosity level to choosen from [DEBUG, ERROR, INFO, 
                       OFF, WARN] (default: INFO)
      --log-file arg   Log file to write the logs (or stderr/stdout) 
                       (default: stderr)

  -i, --input arg       Input file
  -o, --output arg      Output file
      --gamma arg       Use Gamma distribution [α,β]
      --poisson arg     Use Poisson distribution [λ]
      --weibull arg     Use Weibull distribution [α,β]
      --normal arg      Use Normal distribution [μ,σ]
      --min-length arg  Minimum length of polyA (default: 0)
      --max-length arg  Maximum length of polyA (default: 5000)
```

## tksm_flip

### Tool Description
Flip the strand of molecules with a given probability

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
<MODULE> description
Usage:
  <MODULE> [OPTION...]

 utility options:
  -h, --help           Print help
      --version        Print version
  -s, --seed arg       random seed (default: 42)
      --list           list available options
      --verbosity arg  Verbosity level to choosen from [DEBUG, ERROR, INFO, 
                       OFF, WARN] (default: INFO)
      --log-file arg   Log file to write the logs (or stderr/stdout) 
                       (default: stderr)

 main options:
  -i, --input arg             input mdf file
  -o, --output arg            output mdf file
  -p, --flip-probability arg  probability of flipping the strand of a 
                              molecule
```

## tksm_sequence

### Tool Description
Simulate reads from molecules and reference FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Loading models from /usr/local/bin/tksm_models
usage: sequence [-h] -i INPUT [-r REFERENCES [REFERENCES ...]] [-o BADREAD]
                [--perfect PERFECT] [--skip-qual-compute] [-O {fastq,fasta}]
                [-t THREADS] [--badread-identity BADREAD_IDENTITY]
                [--badread-error-model BADREAD_ERROR_MODEL]
                [--badread-qscore-model BADREAD_QSCORE_MODEL]
                [--badread-tail-model BADREAD_TAIL_MODEL] [--list]

Sequencer module of tksm. Generates FASTQ/A file from MDF (molecule
description file) and reference FASTA files. Note: tksm looks for sequencing
model names in colon sperated paths in $TKSM_MODELS environment variable.
Current $TKSM_MODELS value: /usr/local/bin/tksm_models

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        MDF file. (default: None)
  -r REFERENCES [REFERENCES ...], --references REFERENCES [REFERENCES ...]
                        Reference FASTA files, space separated. (default:
                        None)
  -o BADREAD, --badread BADREAD
                        Badread reads output file. Default: no output.
                        (default: None)
  --perfect PERFECT     Perfect reads output file. Default: no output.
                        (default: None)
  --skip-qual-compute   Use all 'K' for q-scores. Default: compute quality
                        score using Edlib alignment to input sequences.
                        (default: False)
  -O {fastq,fasta}, --output-format {fastq,fasta}
                        Output format. Default: infer from output file
                        extension and fallback to FASTA. Accepts .gz files
                        too. (default: None)
  -t THREADS, --threads THREADS
                        Number of threads. (default: 1)
  --badread-identity BADREAD_IDENTITY
                        Sequencing identity distribution (mean, max and stdev)
                        (default: 84.0,99.0,5.5)
  --badread-error-model BADREAD_ERROR_MODEL
                        Badread tail model name or file path. Available model
                        names: [random, nanopore2020, pacbio2016,
                        nanopore2018] (default: nanopore2020)
  --badread-qscore-model BADREAD_QSCORE_MODEL
                        Badread qscore model name or file path. Available
                        model names: [random, ideal, nanopore2020,
                        nanopore2018, pacbio2016] (default: nanopore2020)
  --badread-tail-model BADREAD_TAIL_MODEL
                        Badread tail model name or file path. Available model
                        names: [no_noise] (default: no_noise)
  --list
```

## tksm_head

### Tool Description
Print the first n molecules of an MDF file

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Head module
Usage:
  head [OPTION...]

 utility options:
  -h, --help           Print help
      --version        Print version
  -s, --seed arg       random seed (default: 42)
      --list           list available options
      --verbosity arg  Verbosity level to choosen from [DEBUG, ERROR, INFO, 
                       OFF, WARN] (default: INFO)
      --log-file arg   Log file to write the logs (or stderr/stdout) 
                       (default: stderr)

 main options:
  -n, --count arg  Number of items to be printed (default: 10)
```

## tksm_filter

### Tool Description
Split the input MDF into two files with respect to a condition

### Metadata
- **Docker Image**: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
- **Homepage**: https://github.com/vpc-ccg/tksm
- **Package**: https://anaconda.org/channels/bioconda/packages/tksm/overview
- **Validation**: PASS

### Original Help Text
```text
Splits the input to 2 files w.r.t. condition
Usage:
  Filter [OPTION...]

 utility options:
  -h, --help           Print help
      --version        Print version
  -s, --seed arg       random seed (default: 42)
      --list           list available options
      --verbosity arg  Verbosity level to choosen from [DEBUG, ERROR, INFO, 
                       OFF, WARN] (default: INFO)
      --log-file arg   Log file to write the logs (or stderr/stdout) 
                       (default: stderr)

 main options:
  -i, --input arg         input mdf file
  -t, --true-output arg   output mdf file
  -f, --false-output arg  output mdf file
  -c, --condition arg     Comma separated conditions to filter (and)
      --negate            Negate the conjuction of the condition(s)
```

## Metadata
- **Skill**: generated
