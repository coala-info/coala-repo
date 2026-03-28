# localhgt CWL Generation Report

## localhgt_bkp

### Tool Description
Detect HGT breakpoints from metagenomic sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/localhgt:1.0.1--h9948957_3
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/localhgt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/localhgt/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/samtools/samtools
- **Stars**: N/A
### Original Help Text
```text
usage: localhgt bkp [-r ] [--fq1 ] [--fq2 ] [-s ] [-o ] [-k ] [-t ]
                    [-e ] [-a ] [-q ] [--seed ] [--use_kmer ]
                    [--hit_ratio ] [--match_ratio ] [--max_peak ]
                    [--sample ] [--refine_fq ] [--read_info ] [-h]

Detect HGT breakpoints from metagenomic sequencing data. Example: localhgt bkp
-r reference.fa --fq1 test.1.fq --fq2 test.2.fq -s test -o outdir

required arguments:
  -r              <str> Uncompressed reference file, which contains the
                   representative genome of each concerned bacteria. (default:
                   None)
  --fq1           <str> Uncompressed fastq 1 file. (default: None)
  --fq2           <str> Uncompressed fastq 2 file. (default: None)
  -s              <str> Sample name. (default: sample)
  -o              <str> Output folder. (default: ./)

optional arguments:
  -k              <int> kmer length. (default: 32)
  -t              <int> number of threads. (default: 10)
  -e              <int> number of hash functions (1-9). (default: 3)
  -a              <0/1> 1 indicates retain reads with XA tag. (default: 1)
  -q              <int> minimum read mapping quality in BAM. (default: 20)
  --seed          <int> seed to initialize a pseudorandom number generator.
                   (default: 1)
  --use_kmer      <1/0> 1 means using kmer to extract HGT-related segment, 0
                   means using original reference. (default: 1)
  --hit_ratio     <float> minimum fuzzy kmer match ratio to extract a
                   reference fragment. (default: 0.1)
  --match_ratio   <float> minimum exact kmer match ratio to extract a
                   reference fragment. (default: 0.08)
  --max_peak      <int> maximum candidate BKP count. (default: 300000000)
  --sample        <float> down-sample in kmer counting: (0-1) means sampling
                   proportion, (>1) means sampling base count (bp). (default:
                   2000000000)
  --refine_fq     <0/1> 1 indicates refine the input fastq file using fastp
                   (recommended). (default: 0)
  --read_info     <0/1> 1 indicates including reads info, 0 indicates not
                   (just for evaluation). (default: 1)
  -h, --help
```


## localhgt_event

### Tool Description
Infer complete HGT events based on detected HGT breakpoints.

### Metadata
- **Docker Image**: quay.io/biocontainers/localhgt:1.0.1--h9948957_3
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/localhgt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: localhgt event [-r ] [-b ] [-f ] [-n ] [-m ] [-h]

Infer complete HGT events based on detected HGT breakpoints. Example: localhgt
event -r reference.fa -b outdir -f test_event.csv

required arguments:
  -r         <str> <str> Uncompressed reference file, which contains all the
              representative references of concerned bacteria. It should be
              the same as the reference file used in localhgt bkp -r.
              (default: None)
  -b         <str> the folder stores all the breakpoint results from all
              samples, i.e., a folder stores all the *acc.csv files generated
              by 'localhgt bkp' (default: None)
  -f         <str> Output file to save all inferred HGT events. (default:
              complete_HGT_event.csv)

optional arguments:
  -n         <int> minimum supporting split read number (default: 2)
  -m         <int> minimum transfer sequence length (default: 500)
  -h, --help
```


## Metadata
- **Skill**: not generated
