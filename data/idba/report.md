# idba CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| idba_fq2fa | PASS | fixed image (bioconda idba), baseCommand fq2fa, output name; --merge of two methylated mate files gave 20000 FASTA records |
| idba_idba_ud | PASS | assembled 20000 merged bisulfite SARS-CoV-2 reads (maxk 60) into 7 contigs; image is bioconda idba, where the original deb image has no fq2fa |

## Metadata
- **Skill**: generated

## idba_fq2fa

### Tool Description
Convert FASTQ files to FASTA files, with options for handling paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/idba:1.1.3--1
- **Homepage**: https://github.com/loneknightpy/idba
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://biocontainers/idba:v1.1.3-3-deb_cv1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2028138357: no space left on device
```

## idba_idba_ud

### Tool Description
IDBA-UD - Iterative de Bruijn Graph Assembler for sequencing data with highly uneven depth.

### Metadata
- **Docker Image**: quay.io/biocontainers/idba:1.1.3--1
- **Homepage**: https://github.com/loneknightpy/idba
- **Package**: https://anaconda.org/channels/bioconda/packages/idba/overview
- **Validation**: PASS

### Original Help Text
```text
not enough parameters
IDBA-UD - Iterative de Bruijn Graph Assembler for sequencing data with highly uneven depth.
Usage: idba_ud -r read.fa -o output_dir
Allowed Options: 
  -o, --out arg (=out)                   output directory
  -r, --read arg                         fasta read file (<=600)
      --read_level_2 arg                 paired-end reads fasta for second level scaffolds
      --read_level_3 arg                 paired-end reads fasta for third level scaffolds
      --read_level_4 arg                 paired-end reads fasta for fourth level scaffolds
      --read_level_5 arg                 paired-end reads fasta for fifth level scaffolds
  -l, --long_read arg                    fasta long read file (>600)
      --mink arg (=20)                   minimum k value (<=312)
      --maxk arg (=100)                  maximum k value (<=312)
      --step arg (=20)                   increment of k-mer of each iteration
      --inner_mink arg (=10)             inner minimum k value
      --inner_step arg (=5)              inner increment of k-mer
      --prefix arg (=3)                  prefix length used to build sub k-mer table
      --min_count arg (=2)               minimum multiplicity for filtering k-mer when building the graph
      --min_support arg (=1)             minimum supoort in each iteration
      --num_threads arg (=0)             number of threads
      --seed_kmer arg (=30)              seed kmer size for alignment
      --min_contig arg (=200)            minimum size of contig
      --similar arg (=0.95)              similarity for alignment
      --max_mismatch arg (=3)            max mismatch of error correction
      --min_pairs arg (=3)               minimum number of pairs
      --no_bubble                        do not merge bubble
      --no_local                         do not use local assembly
      --no_coverage                      do not iterate on coverage
      --no_correct                       do not do correction
      --pre_correction                   perform pre-correction before assembly
```

