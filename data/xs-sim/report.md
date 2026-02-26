# xs-sim CWL Generation Report

## xs-sim_XS

### Tool Description
XS is a simulator for sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/xs-sim:2--hec16e2b_0
- **Homepage**: https://github.com/pratas/xs
- **Package**: https://anaconda.org/channels/bioconda/packages/xs-sim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xs-sim/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pratas/xs
- **Stars**: N/A
### Original Help Text
```text
Usage: XS   [OPTION]... [FILE] 

System options:
 -h                       give this help
 -v                       verbose mode

Main FASTQ options:
 -t  <sequencingType>     type: 1=Roche-454, 2=Illumina, 3=ABI SOLiD, 4=Ion Torrent
 -hf <headerFormat>       header format: 1=Length appendix, 2=Pair End
 -i  n=<instrumentName>   the unique instrument name (use n= before name)
 -o                       use the same header in third line of the read
 -ls <lineSize>           static line (bases/quality scores) size
 -ld <minSize>:<maxSize>  dynamic line (bases/quality scores) size
 -n  <numberOfReads>      number of reads per file

DNA options:
 -f  <A>,<C>,<G>,<T>,<N>  symbols frequency
 -rn <numberOfRepeats>    repeats: number (default: 0)
 -ri <repeatsMinSize>     repeats: minimum size
 -ra <repeatsMaxSize>     repeats: maximum size
 -rm <mutationRate>       repeats: mutation frequency
 -rr                      repeats: use reverse complement repeats

Quality scores options:
 -qt <assignmentType>     quality scores distribution: 1=uniform, 2=gaussian
 -qf <statsFile>          load file: mean, standard deviation (when: -qt 2)
 -qc <template>           custom template ascii alphabet

Filtering options:
 -eh                      excludes the use of headers from output
 -eo                      excludes the use of optional headers (+) from output
 -ed                      excludes the use of DNA bases from output
 -edb                     excludes '\n' when DNA bases line size is reached
 -es                      excludes the use of quality scores from output

Stochastic options:
 -s  <seed>               generation seed

<genFile>                 simulated output file

Common usage:
 ./XS -v -t 1 -i n=MySeq -ld 30:80 -n 20000 -qt=1 -qc 33,36,39:43 File
 ./XS -v -ls 100 -n 10000 -eh -eo -es -edb -f 0.3,0.2,0.2,0.3,0.0 -rn 50 -ri 300 -ra 3000 -rm 0.1 File

Report bugs to {pratas,ap,jmr}@ua.pt
```

