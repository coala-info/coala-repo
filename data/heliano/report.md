# heliano CWL Generation Report

## heliano

### Tool Description
heliano can detect and classify different variants of Helitron-like elements: HLE1 and HLE2.

### Metadata
- **Docker Image**: quay.io/biocontainers/heliano:1.3.1--hdfd78af_0
- **Homepage**: https://github.com/Zhenlisme/heliano
- **Package**: https://anaconda.org/channels/bioconda/packages/heliano/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/heliano/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-06-11
- **GitHub**: https://github.com/Zhenlisme/heliano
- **Stars**: N/A
### Original Help Text
```text
usage: heliano [-h] -g GENOME [-w WINDOW] [-dm DISTANCE_DOMAIN]
               [-dn DISTANCE_TS] [-pt {0,1}] [-is1 {0,1}] [-is2 {0,1}]
               [-sim_tir {100,90,80}] [-flank_sim {0.4,0.5,0.6,0.7}]
               [-p PVALUE] [-s SCORE] [--nearest] [-ts TERMINAL_SEQUENCE]
               [--dis_denovo] [--multi_ts] [-tb {0,1,2,3}] -o OPDIR
               [-n PROCESS] [-v]

heliano can detect and classify different variants of Helitron-like elements:
HLE1 and HLE2. Please visit https://github.com/Zhenlisme/heliano/ for more
information. Email us: zhen.li3@universite-paris-saclay.fr

options:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        The genome file in fasta format.
  -w WINDOW, --window WINDOW
                        To check terminal signals within a given window bp
                        upstream and downstream of ORF ends. default is 10 kb.
  -dm DISTANCE_DOMAIN, --distance_domain DISTANCE_DOMAIN
                        The distance between HUH and Helicase domain, default
                        is 2500.
  -dn DISTANCE_TS, --distance_ts DISTANCE_TS
                        The maximum distance between LTS and RTS. If not
                        specified, HELIANO will set it as two times window
                        size plus the maximum ORF length.
  -pt {0,1}, --pair_helitron {0,1}
                        For HLE1, its 5' and 3' terminal signal pairs should
                        come from the same autonomous helitorn or not. 0: no,
                        1: yes (default).
  -is1 {0,1}, --IS1 {0,1}
                        Set the insertion site of autonomous HLE1 as A and T.
                        0: no, 1: yes (default).
  -is2 {0,1}, --IS2 {0,1}
                        Set the insertion site of autonomous HLE2 as T and T.
                        0: no, 1: yes (default).
  -sim_tir {100,90,80}, --simtir {100,90,80}
                        Set the simarity between short inverted repeats(TIRs)
                        of HLE2. Default 100.
  -flank_sim {0.4,0.5,0.6,0.7}, --flank_sim {0.4,0.5,0.6,0.7}
                        The cut-off to define false positive LTS/RTS. The
                        lower the value, the more strigent. Default 0.5.
  -p PVALUE, --pvalue PVALUE
                        The p-value for fisher's exact test. default is 1e-5.
  -s SCORE, --score SCORE
                        The minimum bitscore of blastn for searching for
                        homologous sequences of terminal signals. From 30 to
                        55, default is 32.
  --nearest             If you use this parameter, you will use the
                        reciprocal-nearest LTS-RTS pairs as final candidates.
                        By default, HELIANO will try to use the reciprocal-
                        farthest pairs.
  -ts TERMINAL_SEQUENCE, --terminal_sequence TERMINAL_SEQUENCE
                        The terminal sequence file. You can find it in the
                        output of previous run (named as pairlist.tbl).
  --dis_denovo          If you use this parameter, you refuse to search for
                        LTS/RTS de novo, instead you will only use the LTS/RTS
                        information described in the terminal sequence file.
  --multi_ts            To allow an auto HLE to have multiple terminal
                        sequences. If you enable this, you might find nonauto
                        HLEs coming from the same auto HLE have different
                        terminal sequences.
  -tb {0,1,2,3}, --table {0,1,2,3}
                        Code to use for the open reading fram prediction. 0:
                        Standard (default); 1: Ciliate Macronuclear and
                        Dasycladacean; 2: Blepharisma Macronuclear; 3:
                        Scenedesmus obliquus
  -o OPDIR, --opdir OPDIR
                        The output directory.
  -n PROCESS, --process PROCESS
                        Maximum number of threads to be used.
  -v, --version         show program's version number and exit
```

