# nanosim CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nanosim_read_analysis_detect_ir | Not completed | no real ONT RNA reads with a transcriptome and an annotation that has introns in the test data sets |
| nanosim_read_analysis_genome | PASS |  |
| nanosim_read_analysis_metagenome | PASS |  |
| nanosim_read_analysis_quantify | PASS | Ran with -e meta on the Portiera ONT reads and a two-genome list; all reads assigned to Portiera, as expected. |
| nanosim_read_analysis_transcriptome | Not completed | no real ONT cDNA or direct RNA reads with a matching reference transcriptome in the test data sets |
| nanosim_simulator_genome | PASS |  |
| nanosim_simulator_metagenome | PASS |  |
| nanosim_simulator_transcriptome | Not completed | needs a transcriptome error model trained on real ONT cDNA or direct RNA reads, which are not available in the test data sets |

## nanosim_read_analysis_genome

### Tool Description
Read characterization step (read_analysis_genome): learn read features and write error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_analysis.py genome [-h] -i READ [-rg REF_G] [-a {minimap2,LAST}]
                               [-ga G_ALNM] [-o OUTPUT] [-c] [-hp]
                               [--min_homopolymer_len MIN_HOMOPOLYMER_LEN]
                               [--fastq] [--no_model_fit] [-t NUM_THREADS]

options:
  -h, --help            show this help message and exit
  -i READ, --read READ  Input read for training
  -rg REF_G, --ref_g REF_G
                        Reference genome, not required if genome alignment
                        file is provided
  -a {minimap2,LAST}, --aligner {minimap2,LAST}
                        The aligner to be used, minimap2 or LAST (Default =
                        minimap2)
  -ga G_ALNM, --g_alnm G_ALNM
                        Genome alignment file in SAM/BAM format (optional)
  -o OUTPUT, --output OUTPUT
                        The location and prefix of outputting profiles
                        (Default = training)
  -c, --chimeric        Detect chimeric and split reads (Default = False)
  -hp, --homopolymer    Analyze homopolymer lengths (Default = False)
  --min_homopolymer_len MIN_HOMOPOLYMER_LEN
                        Minimum length of homopolymers to analyze (Default = 5
                        bp)
  --fastq               Analyze base qualities (Default = False)
  --no_model_fit        Disable model fitting step
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for alignment and model fitting
                        (Default = 1)
```

## nanosim_read_analysis_transcriptome

### Tool Description
Read characterization step (read_analysis_transcriptome): learn read features and write error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_analysis.py transcriptome [-h] -i READ -rg REF_G -rt REF_T
                                      [-annot ANNOTATION] [-a {minimap2,LAST}]
                                      [-ga G_ALNM] [-ta T_ALNM] [-o OUTPUT]
                                      [--no_model_fit] [--no_intron_retention]
                                      [-t NUM_THREADS] [-q] [-n] [-hp]
                                      [--min_homopolymer_len MIN_HOMOPOLYMER_LEN]
                                      [--fastq]

options:
  -h, --help            show this help message and exit
  -i READ, --read READ  Input read for training
  -rg REF_G, --ref_g REF_G
                        Reference genome
  -rt REF_T, --ref_t REF_T
                        Reference Transcriptome
  -annot ANNOTATION, --annotation ANNOTATION
                        Annotation file in ensemble GTF/GFF formats, required
                        for intron retention detection
  -a {minimap2,LAST}, --aligner {minimap2,LAST}
                        The aligner to be used: minimap2 or LAST (Default =
                        minimap2)
  -ga G_ALNM, --g_alnm G_ALNM
                        Genome alignment file in SAM/BAM format (optional)
  -ta T_ALNM, --t_alnm T_ALNM
                        Transcriptome alignment file in SAM/BAM format
                        (optional)
  -o OUTPUT, --output OUTPUT
                        The location and prefix of outputting profiles
                        (Default = training)
  --no_model_fit        Disable model fitting step
  --no_intron_retention
                        Disable Intron Retention analysis
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for alignment and model fitting
                        (Default = 1)
  -q, --quantification  Perform abundance quantification (Default = False)
  -n, --normalize       Normalize by transcript length
  -hp, --homopolymer    Analyze homopolymer lengths (Default = False
  --min_homopolymer_len MIN_HOMOPOLYMER_LEN
                        Minimum length of homopolymers to analyze (Default = 5
                        bp)
  --fastq               Analyze base qualities (Default = False)
```

## nanosim_read_analysis_metagenome

### Tool Description
Read characterization step (read_analysis_metagenome): learn read features and write error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_analysis.py metagenome [-h] -i READ -gl GENOME_LIST [-ga G_ALNM]
                                   [-o OUTPUT] [-c] [-q] [--fastq]
                                   [--no_model_fit] [-t NUM_THREADS]

options:
  -h, --help            show this help message and exit
  -i READ, --read READ  Input read for training
  -gl GENOME_LIST, --genome_list GENOME_LIST
                        Reference metagenome list, tsv file, the first column
                        is species/strain name, the second column is the
                        reference genome fasta/fastq file directory, the third
                        column is optional, if provided, it contains the
                        expected abundance (sum up to 100)
  -ga G_ALNM, --g_alnm G_ALNM
                        Genome alignment file in sam format, the header of
                        each species should match the metagenome list provided
                        above (optional)
  -o OUTPUT, --output OUTPUT
                        The location and prefix of outputting profiles
                        (Default = training)
  -c, --chimeric        Detect chimeric and split reads (Default = False)
  -q, --quantification  Perform abundance quantification and compute the
                        deviation between calculated abundance and expected
                        values (Default = False)
  --fastq               Analyze base qualities (Default = False)
  --no_model_fit        Disable model fitting step
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for alignment and model fitting
                        (Default = 1)
```

## nanosim_read_analysis_quantify

### Tool Description
Read characterization step (read_analysis_quantify): learn read features and write error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_analysis.py quantify [-h] -e E -i READ [-rt REF_T]
                                 [-gl GENOME_LIST] [-ga G_ALNM] [-ta T_ALNM]
                                 [-o OUTPUT] [-t NUM_THREADS] [-n]

options:
  -h, --help            show this help message and exit
  -e E                  Select from (trans, meta)
  -i READ, --read READ  Input reads for quantification
  -rt REF_T, --ref_t REF_T
                        Reference Transcriptome
  -gl GENOME_LIST, --genome_list GENOME_LIST
                        Reference metagenome list, tsv file, the first column
                        is species/strain name, the second column is the
                        reference genome fasta/fastq file directory, the third
                        column is optional, if provided, it contains the
                        expected abundance (sum up to 100)
  -ga G_ALNM, --g_alnm G_ALNM
                        Genome alignment file in sam format, the header of
                        each species should match the metagenome list provided
                        above (optional)
  -ta T_ALNM, --t_alnm T_ALNM
                        Transcriptome alignment file in sam format(optional)
  -o OUTPUT, --output OUTPUT
                        The location and prefix of outputting profile (Default
                        = expression)
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for alignment (Default = 1)
  -n, --normalize       Normalize by transcript length
```

## nanosim_read_analysis_detect_ir

### Tool Description
Read characterization step (read_analysis_detect_ir): learn read features and write error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_analysis.py detect_ir [-h] -annot ANNOTATION [-i READ] [-rg REF_G]
                                  [-rt REF_T] [-a {minimap2,LAST}] [-o OUTPUT]
                                  [-ga G_ALNM] [-ta T_ALNM] [-t NUM_THREADS]

options:
  -h, --help            show this help message and exit
  -annot ANNOTATION, --annotation ANNOTATION
                        Annotation file in ensemble GTF/GFF formats
  -i READ, --read READ  Input read for training, not required if alignment
                        files are provided
  -rg REF_G, --ref_g REF_G
                        Reference genome, not required if genome alignment
                        file is provided
  -rt REF_T, --ref_t REF_T
                        Reference Transcriptome, not required if transcriptome
                        alignment file is provided
  -a {minimap2,LAST}, --aligner {minimap2,LAST}
                        The aligner to be used: minimap2 or LAST (Default =
                        minimap2)
  -o OUTPUT, --output OUTPUT
                        The output name and location
  -ga G_ALNM, --g_alnm G_ALNM
                        Genome alignment file in SAM/BAM format (optional)
  -ta T_ALNM, --t_alnm T_ALNM
                        Transcriptome alignment file in SAM/BAM format
                        (optional)
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for alignment (Default = 1)
```

## nanosim_simulator_genome

### Tool Description
Simulation step (simulator_genome): simulate ONT reads from error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulator.py genome [-h] -rg REF_G [-c MODEL_PREFIX] [-o OUTPUT]
                           [-n NUMBER] [-x COVERAGE] [-max MAX_LEN]
                           [-min MIN_LEN] [-med MEDIAN_LEN] [-sd SD_LEN]
                           [--seed SEED] [-hp] [-k KMERBIAS] [-s STRANDNESS]
                           [-dna_type {linear,circular}] [--perfect] [--fastq]
                           [--chimeric] [-t NUM_THREADS]

options:
  -h, --help            show this help message and exit
  -rg REF_G, --ref_g REF_G
                        Input reference genome
  -c MODEL_PREFIX, --model_prefix MODEL_PREFIX
                        Location and prefix of error profiles generated from
                        characterization step (Default = training)
  -o OUTPUT, --output OUTPUT
                        Output location and prefix for simulated reads
                        (Default = simulated)
  -n NUMBER, --number NUMBER
                        Number of reads to be simulated (Default = 20000)
  -x COVERAGE, --coverage COVERAGE
                        Coverage of the simulated reads, Note: Coverage will
                        override the number of reads
  -max MAX_LEN, --max_len MAX_LEN
                        The maximum length for simulated reads (Default =
                        Infinity)
  -min MIN_LEN, --min_len MIN_LEN
                        The minimum length for simulated reads (Default = 50)
  -med MEDIAN_LEN, --median_len MEDIAN_LEN
                        The median read length (Default = None), Note: this
                        simulation is not compatible with chimeric reads
                        simulation
  -sd SD_LEN, --sd_len SD_LEN
                        The standard deviation of read length in log scale
                        (Default = None), Note: this simulation is not
                        compatible with chimeric reads simulation
  --seed SEED           Manually seeds the pseudo-random number generator
  -hp, --homopolymer    Simulate homopolymer lengths (Default = False)
  -k KMERBIAS, --KmerBias KMERBIAS
                        Minimum homopolymer length to simulate homopolymer
                        contraction and expansion events in, a typical k is 5
  -s STRANDNESS, --strandness STRANDNESS
                        Proportion of sense sequences. Overrides the value
                        profiled in characterization stage. Should be between
                        0 and 1
  -dna_type {linear,circular}
                        Specify the dna type: circular OR linear (Default =
                        linear)
  --perfect             Ignore error profiles and simulate perfect reads
  --fastq               Output fastq files instead of fasta files
  --chimeric            Simulate chimeric reads
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for simulation (Default = 1)
```

## nanosim_simulator_transcriptome

### Tool Description
Simulation step (simulator_transcriptome): simulate ONT reads from error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulator.py transcriptome [-h] -rt REF_T [-rg REF_G] -e EXP
                                  [-c MODEL_PREFIX] [-o OUTPUT] [-n NUMBER]
                                  [-x COVERAGE] [-max MAX_LEN] [-min MIN_LEN]
                                  [--seed SEED] [-hp] [-k KMERBIAS]
                                  [-b {albacore,guppy}] [-s STRANDNESS]
                                  [--no_model_ir] [--perfect] [--polya POLYA]
                                  [--fastq] [-t NUM_THREADS] [--uracil]

options:
  -h, --help            show this help message and exit
  -rt REF_T, --ref_t REF_T
                        Input reference transcriptome
  -rg REF_G, --ref_g REF_G
                        Input reference genome, required if intron retention
                        simulation is on
  -e EXP, --exp EXP     Expression profile in the specified format as
                        described in README
  -c MODEL_PREFIX, --model_prefix MODEL_PREFIX
                        Location and prefix of error profiles generated from
                        characterization step (Default = training)
  -o OUTPUT, --output OUTPUT
                        Output location and prefix for simulated reads
                        (Default = simulated)
  -n NUMBER, --number NUMBER
                        Number of reads to be simulated (Default = 20000)
  -x COVERAGE, --coverage COVERAGE
                        Coverage of the simulated reads, Note: Coverage will
                        override the number of reads
  -max MAX_LEN, --max_len MAX_LEN
                        The maximum length for simulated unaligned reads. Note
                        that this is not used for simulating aligned reads.
                        (Default = Infinity)
  -min MIN_LEN, --min_len MIN_LEN
                        The minimum length for simulated unaligned reads. Note
                        that this is not used for simulating aligned reads.
                        (Default = 50)
  --seed SEED           Manually seeds the pseudo-random number generator
  -hp, --homopolymer    Simulate homopolymer lengths (Default = False)
  -k KMERBIAS, --KmerBias KMERBIAS
                        Minimum homopolymer length to simulate homopolymer
                        contraction and expansion events in, a typical k is 6
  -b {albacore,guppy}, --basecaller {albacore,guppy}
                        Simulate polyA tails with respect to chosen
                        basecaller: albacore or guppy
  -s STRANDNESS, --strandness STRANDNESS
                        Proportion of sense sequences. Overrides the value
                        profiled in characterization stage. Should be between
                        0 and 1
  --no_model_ir         Ignore simulating intron retention events
  --perfect             Ignore profiles and simulate perfect reads
  --polya POLYA         Simulate polyA tails for given list of transcripts
  --fastq               Output fastq files instead of fasta files
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for simulation (Default = 1)
  --uracil              Converts the thymine (T) bases to uracil (U) in the
                        output fasta format
```

## nanosim_simulator_metagenome

### Tool Description
Simulation step (simulator_metagenome): simulate ONT reads from error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulator.py metagenome [-h] -gl GENOME_LIST -a ABUN
                               [-dl DNA_TYPE_LIST] [-c MODEL_PREFIX]
                               [-o OUTPUT] [-max MAX_LEN] [-min MIN_LEN]
                               [-med MEDIAN_LEN] [-sd SD_LEN] [--seed SEED]
                               [-s STRANDNESS] [--perfect]
                               [--abun_var ABUN_VAR [ABUN_VAR ...]] [--fastq]
                               [--chimeric] [-t NUM_THREADS]

options:
  -h, --help            show this help message and exit
  -gl GENOME_LIST, --genome_list GENOME_LIST
                        Reference metagenome list, tsv file, the first column
                        is species/strain name, the second column is the
                        reference genome fasta/fastq file directory
  -a ABUN, --abun ABUN  Abundance list, tsv file with header, the abundance of
                        all species in each sample need to sum up to 100. See
                        example in README and provided config files
  -dl DNA_TYPE_LIST, --dna_type_list DNA_TYPE_LIST
                        DNA type list, tsv file, the first column is
                        species/strain, the second column is the chromosome
                        name, the third column is the DNA type: circular OR
                        linear
  -c MODEL_PREFIX, --model_prefix MODEL_PREFIX
                        Location and prefix of error profiles generated from
                        characterization step (Default = training)
  -o OUTPUT, --output OUTPUT
                        Output location and prefix for simulated reads
                        (Default = simulated)
  -max MAX_LEN, --max_len MAX_LEN
                        The maximum length for simulated reads (Default =
                        Infinity)
  -min MIN_LEN, --min_len MIN_LEN
                        The minimum length for simulated reads (Default = 50)
  -med MEDIAN_LEN, --median_len MEDIAN_LEN
                        The median read length (Default = None), Note: this
                        simulation is not compatible with chimeric reads
                        simulation
  -sd SD_LEN, --sd_len SD_LEN
                        The standard deviation of read length in log scale
                        (Default = None), Note: this simulation is not
                        compatible with chimeric reads simulation
  --seed SEED           Manually seeds the pseudo-random number generator
  -s STRANDNESS, --strandness STRANDNESS
                        Percentage of antisense sequences. Overrides the value
                        profiled in characterization stage. Should be between
                        0 and 1
  --perfect             Ignore error profiles and simulate perfect reads
  --abun_var ABUN_VAR [ABUN_VAR ...]
                        Simulate random variation in abundance values, takes
                        in two values, format: relative_var_low,
                        relative_var_high, Example: -0.5 0.5)
  --fastq               Output fastq files instead of fasta files
  --chimeric            Simulate chimeric reads
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads for simulation (Default = 1)
```

## Metadata
- **Skill**: generated
