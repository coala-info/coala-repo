# segalign-galaxy CWL Generation Report

## segalign-galaxy_run_segalign

### Tool Description
Run segalign with specified target and query files.

### Metadata
- **Docker Image**: quay.io/biocontainers/segalign-galaxy:0.1.2.7--hdfd78af_2
- **Homepage**: https://github.com/gsneha26/SegAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/segalign-galaxy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segalign-galaxy/overview
- **Total Downloads**: 639
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gsneha26/SegAlign
- **Stars**: N/A
### Original Help Text
```text
You must specify a target file and a query file

Usage: run_segalign target query [options]
Version: v0.1.2.7

Sequence Options:
  --strand arg (=both)  strand to search - plus/minus/both

Scoring Options:
  --scoring arg         Scoring file in LASTZ format
  --ambiguous arg       ambiguous nucleotides - n/iupac

Seeding Options:
  --seed arg (=12of19)  seed pattern-12of19(1110100110010101111)/14of22(1110101
                        100110010101111)/an arbitrary pattern of 1s, 0s, and Ts
                         
  --step arg (=1)       Offset between the starting positions of successive 
                        target words considered for generating seed table
  --notransition        don't allow one transition in a seed hit

Ungapped Extension Options:
  --xdrop arg (=910)      x-drop value for gap-free extension
  --hspthresh arg (=3000) segment score threshold for high scoring pairs
  --noentropy             don't adjust low score segment pair scores using 
                          entropy factor after filtering stage

Gapped Extension Options:
  --nogapped            don't perform gapped extension stage
  --ydrop arg (=9430)   y-drop value for gapped extension
  --gappedthresh arg    score threshold for gapped alignments
  --notrivial           Don't output a trivial self-alignment block if the 
                        target and query sequences are identical

Output Options:
  --format arg (=maf-)  format of output file (same formats as provided by 
                        LASTZ) - lav, lav+text, axt, axt+, maf, maf+, maf-, 
                        sam, softsam, sam-, softsam-, cigar, BLASTN, 
                        differences, rdotplot, text
  --output arg          output filename
  --markend             write a marker line just before completion

System Options:
  --wga_chunk_size arg (=250000)        chunk sizes for GPU calls for Xdrop - 
                                        change only if you are a developer
  --lastz_interval_size arg (=10000000) LASTZ interval for ydrop - change only 
                                        if you are a developer
  --seq_block_size arg (=500000000)     LASTZ interval for ydrop - change only 
                                        if you are a developer
  --num_gpu arg (=-1)                   Specify number of GPUs to use - -1 if 
                                        all the GPUs should be used
  --num_threads arg (=-1)               Specify number of CPU threads to use - 
                                        -1 if all the CPU threads should be 
                                        used
  --debug                               print debug messages
  --version                             print version
  --help                                Print help messages
```


## segalign-galaxy_run_segalign_repeat_masker

### Tool Description
You must specify a sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/segalign-galaxy:0.1.2.7--hdfd78af_2
- **Homepage**: https://github.com/gsneha26/SegAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/segalign-galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
You must specify a sequence file 

Usage: segalign_repeat_masker seq_file [options]
Version: v0.1.2.7

Sequence Options:
  --strand arg (=both)                  strand to search - plus/minus/both
  --neighbor_proportion arg (=0.200000003)
                                        proportion of neighbouring intervals to
                                        align the query interval to

Scoring Options:
  --scoring arg         Scoring file in LASTZ format
  --ambiguous arg       ambiguous nucleotides - n/iupac

Seeding Options:
  --seed arg (=12of19)  seed pattern-12of19(1110100110010101111)/14of22(1110101
                        100110010101111)/an arbitrary pattern of 1s, 0s, and Ts
                         
  --step arg (=1)       Offset between the starting positions of successive 
                        target words considered for generating seed table
  --notransition        don't allow one transition in a seed hit

Ungapped Extension Options:
  --xdrop arg (=910)      x-drop value for gap-free extension
  --hspthresh arg (=3000) segment score threshold for high scoring pairs
  --noentropy             don't adjust low score segment pair scores using 
                          entropy factor after filtering stage

Output Options:
  --M arg (=1)          report any position that is covered by at least this 
                        many alignments; the maximum allowed depth is 255
  --markend             write a marker line just before completion

System Options:
  --wga_chunk_size arg (=250000)        chunk sizes for GPU calls for Xdrop - 
                                        change only if you are a developer
  --lastz_interval_size arg (=10000000) LASTZ interval for ydrop - change only 
                                        if you are a developer
  --seq_block_size arg (=1000000000)    LASTZ interval for ydrop - change only 
                                        if you are a developer
  --num_gpu arg (=-1)                   Specify number of GPUs to use - -1 if 
                                        all the GPUs should be used
  --debug                               print debug messages
  --version                             print version
  --help                                Print help messages
```

