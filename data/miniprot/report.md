# miniprot CWL Generation Report

## miniprot

### Tool Description
Align protein sequences to a reference database.

### Metadata
- **Docker Image**: quay.io/biocontainers/miniprot:0.18--h577a1d6_0
- **Homepage**: https://github.com/lh3/miniprot
- **Package**: https://anaconda.org/channels/bioconda/packages/miniprot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/miniprot/overview
- **Total Downloads**: 78.6K
- **Last updated**: 2025-07-13
- **GitHub**: https://github.com/lh3/miniprot
- **Stars**: N/A
### Original Help Text
```text
Usage: miniprot [options] <ref.fa> <query.faa> [...]
Options:
  Indexing:
    -k INT       k-mer size [6]
    -M INT       modimisers bit (sample rate = 1/2**M) [1]
    -L INT       min ORF length to index [30]
    -T INT       NCBI translation table (1 through 33) [1]
    -b INT       bits per block [8]
    -d FILE      save index to FILE []
  Mapping:
    -S           no splicing (applying -G1k -J1k -e1k)
    -c NUM       max k-mer occurrence [20000]
    -G NUM       max intron size; override -I [200k]
    -I           set max intron size to 3.6*sqrt(refLen)
    -w FLOAT     weight of log gap penalty [0.75]
    -n NUM       minimum number of syncmers in a chain [3]
    -m NUM       min chaining score [0]
    -l INT       k-mer size for the second round of chaining [5]
    -e NUM       max extension for 2nd round of chaining and alignment [10000]
    -p FLOAT     min secondary-to-primary score ratio [0.7]
    -N NUM       consider at most INT secondary alignments [30]
  Alignment:
    -O INT       gap open penalty [11]
    -E INT       gap extension (a k-long gap costs O+k*E) [1]
    -J INT       intron open penalty [29]
    -F INT       penalty for frameshifts or in-frame stop codons [23]
    -C FLOAT     weight of splice penalty; 0 to ignore splice signals [1]
    -B INT       bonus score for alignment reaching query ends [5]
    -j INT       splice model: 2=vertebrate/insect, 1=general, 0=none (see manual) [1]
    --spsc=FILE  splice score file in format "ctg offset +|- D|A score" []
    --spsc0=INT  splice score for sites not in --spsc [-7]
  Input/output:
    -t INT       number of threads [4]
    --gff        output in the GFF3 format
    --gtf        basic GTF output without detailed alignment
    --aln        output residue alignment
    --trans      output translated protein sequences (skipping frameshift)
    -P STR       prefix for IDs in GFF3 [MP]
    -u           print unmapped query proteins in PAF
    --outn=NUM   output up to min{NUM,-N} alignments per query [1000]
    --outs=FLOAT output if score at least FLOAT*bestScore [0.99]
    --outc=FLOAT output if at least FLOAT fraction of query is aligned [0.1]
    -K NUM       query batch size [2M]
```

