# nanocall CWL Generation Report

## nanocall

### Tool Description
Call bases in Oxford Nanopore reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanocall:v0.7.4--0
- **Homepage**: https://github.com/WGLab/NanoCaller
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanocall/overview
- **Total Downloads**: 36.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/WGLab/NanoCaller
- **Stars**: N/A
### Original Help Text
```text
USAGE: 

   nanocall  [-t <int>] [-o <file>] [--write-fast5] [--pore <r73|r9>] [-m
             <strand:file>] ...  [--model-fofn <file>] [-s <file>]
             [--pr-stay <float>] [--pr-skip <float>] [--no-basecall]
             [--basecall] [--no-train] [--train] [--no-train-scaling]
             [--no-train-transitions] [--double-strand-scaling]
             [--single-strand-scaling] [--1d] [--scaling-num-events <int>]
             [--scaling-max-rounds <int>] [--scaling-min-progress <float>]
             [--scaling-select-threshold <float>] [--fasta-line-width
             <int>] [--min-ed-events <int>] [--max-ed-events <int>]
             [--trim-ed-sq-start <int>] [--trim-ed-sq-end <int>]
             [--trim-ed-hp-start <int>] [--trim-ed-hp-end <int>]
             [--train-drift <0|1>] [--stats <file>] [--log <string>] ... 
             [--chunk-size <int>] [--ed-group <000|001|...>] [--]
             [--version] [-h] <path> ...


Where: 

   -t <int>,  --threads <int>
     Number of parallel threads. (default: 1)

   -o <file>,  --output <file>
     Output.

   --write-fast5
     Write basecalls to fast5 files.

   --pore <r73|r9>
     Pore name, used to select builtin pore model. (default: r9)

   -m <strand:file>,  --model <strand:file>  (accepted multiple times)
     Custom pore model for strand (0=template, 1=complement, 2=both).

   --model-fofn <file>
     File of pore models.

   -s <file>,  --trans <file>
     Custom initial state transitions.

   --pr-stay <float>
     Transition probability of staying in the same state. (default: 0.1)

   --pr-skip <float>
     Transition probability of skipping at least 1 state. (default: 0.3)

   --no-basecall
     Disable basecalling.

   --basecall
     Enable basecalling (default).

   --no-train
     Disable all training.

   --train
     Enable training. (default)

   --no-train-scaling
     Do not train pore model scaling.

   --no-train-transitions
     Do not train state transitions.

   --double-strand-scaling
     Train scaling parameters per read. (default)

   --single-strand-scaling
     Train scaling parameters per strand.

   --1d
     Interpret entire read as 1D template only.

   --scaling-num-events <int>
     Number of events used for model scaling. (default: 200)

   --scaling-max-rounds <int>
     Maximum scaling rounds. (default: 10)

   --scaling-min-progress <float>
     Minimum scaling fit progress. (default: 1)

   --scaling-select-threshold <float>
     Select best model per strand during scaling if log score better by
     threshold. (default: 20)

   --fasta-line-width <int>
     Maximum fasta line width. (default: 80)

   --min-ed-events <int>
     Minimum EventDetection events. (default: 10)

   --max-ed-events <int>
     Maximum EventDetection events. (default: 100000)

   --trim-ed-sq-start <int>
     Number of events to trim after sequence start. (default: 50)

   --trim-ed-sq-end <int>
     Number of events to trim before sequence end. (default: 50)

   --trim-ed-hp-start <int>
     Number of events to trim before hairpin start. (default: 50)

   --trim-ed-hp-end <int>
     Number of events to trim after hairpin end. (default: 50)

   --train-drift <0|1>
     Train drift parameter. (default: yes for R73, no for R9)

   --stats <file>
     Stats.

   --log <string>  (accepted multiple times)
     Log level. (default: info)

   --chunk-size <int>
     Thread chunk size. (default: 1)

   --ed-group <000|001|...>
     EventDetection group to use. (default: smallest available)

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <path>  (accepted multiple times)
     (required)  Inputs: directories, fast5 files, or files of fast5 file
     names (use "-" to read fofn from stdin).


   Call bases in Oxford Nanopore reads.
```

