# jaeger-bio CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jaeger-bio_run | PASS |  |

## jaeger-bio_run

### Tool Description
Run Jaeger (yet AnothEr phaGe idEntifier), a deep-learning based bacteriophage discovery tool, on a FASTA file of contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/jaeger-bio:1.1.30--pyhdfd78af_0
- **Homepage**: https://github.com/Yasas1994/Jaeger
- **Package**: https://anaconda.org/channels/bioconda/packages/jaeger-bio/overview
- **Validation**: PASS

### Original Help Text
```text
Jaeger 1.1.30 (yet AnothEr phaGe idEntifier) Deep-learning based
bacteriophage discovery https://github.com/Yasas1994/Jaeger.git

usage: jaeger run  -i INPUT -o OUTPUT

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        path to input file
  -o OUTPUT, --output OUTPUT
                        path to output directory
  --fsize [FSIZE]       length of the sliding window (value must be 2^n).
                        default:2048
  --stride [STRIDE]     stride of the sliding window. default:2048
                        (stride==fsize)
  -m {default,experimental_1,experimental_2}, --model {default,experimental_1,experimental_2}
                        select a deep-learning model to use. default:default
  -p, --prophage        extract and report prophage-like regions.
                        default:False
  -s [SENSITIVITY], --sensitivity [SENSITIVITY]
                        sensitivity of the prophage extraction algorithm
                        (between 0 - 4). default: 1.5
  --lc [LC]             minimum contig length to run prophage extraction
                        algorithm. default: 500000 bp
  --rc [RC]             minium reliability score required to accept
                        predictions. default: 0.2
  --pc [PC]             minium phage score required to accept predictions.
                        default: 3
  --batch [BATCH]       parallel batch size, set to a lower value if your gpu
                        runs out of memory. default:96
  --workers [WORKERS]   number of threads to use. default:4
  --getalllogits        writes window-wise scores to a .npy file
  --getsequences        writes the putative phage sequences to a .fasta file
  --cpu                 ignore available gpus and explicitly run jaeger on
                        cpu. default: False
  --physicalid [PHYSICALID]
                        sets the default gpu device id (for multi-gpu
                        systems). default: 0
  --getalllabels        get predicted labels for Non-Viral contigs. default:
                        False
  -v, --verbose         Verbosity level : -vvv warning, -vv info, -v debug,
                        (default info)

Misc. Options:
  -f, --overwrite       Overwrite existing files
```

