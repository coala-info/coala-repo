# dicey CWL Generation Report

## dicey_index

### Tool Description
Index a genome FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Total Downloads**: 24.0K
- **Last updated**: 2025-06-15
- **GitHub**: https://github.com/gear-genomics/dicey
- **Stars**: N/A
### Original Help Text
```text
Usage: dicey index [OPTIONS] genome.fa.gz

Generic options:
  -? [ --help ]                        show help message
  -o [ --output ] arg (="genome.fm9")  output file
```


## dicey_hunt

### Tool Description
Finds matches of a given sequence in a genome file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dicey hunt [OPTIONS] -g Danio_rerio.fa.gz CATTACTAACATCAGT

Generic options:
  -? [ --help ]                         show help message
  -g [ --genome ] arg                   genome file
  -o [ --outfile ] arg                  gzipped output file
  -m [ --maxmatches ] arg (=1000)       max. number of matches
  -x [ --maxNeighborhood ] arg (=10000) max. neighborhood size
  -d [ --distance ] arg (=1)            neighborhood distance
  -n [ --hamming ]                      use hamming neighborhood instead of 
                                        edit distance
  -f [ --forward ]                      only forward matches
```


## dicey_search

### Tool Description
Generic options:

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dicey search [OPTIONS] -g <ref.fa.gz> sequences.fasta

Generic options:
  -? [ --help ]                         show help message
  -g [ --genome ] arg                   genome file
  -i [ --config ] arg (="./src/primer3_config/")
                                        primer3 config directory
  -o [ --outfile ] arg                  output file

Approximate Search Options:
  -k [ --kmer ] arg (=15)               k-mer size
  -m [ --maxmatches ] arg (=10000)      max. number of matches per k-mer
  -x [ --maxNeighborhood ] arg (=10000) max. neighborhood size
  -d [ --distance ] arg (=1)            neighborhood distance
  -q [ --pruneprimer ] arg              prune primer threshold
  -n [ --hamming ]                      use hamming neighborhood instead of 
                                        edit distance

Parameters for Scoring and Penalty Calculation:
  -c [ --cutTemp ] arg (=45)            min. primer melting temperature
  -l [ --maxProdSize ] arg (=15000)     max. PCR Product size
  --cutoffPenalty arg (=-1)             max. penalty for products (-1 = keep 
                                        all)
  --penaltyTmDiff arg (=0.59999999999999998)
                                        multiplication factor for deviation of 
                                        primer Tm penalty
  --penaltyTmMismatch arg (=0.40000000000000002)
                                        multiplication factor for Tm pair 
                                        difference penalty
  --penaltyLength arg (=0.001)          multiplication factor for amplicon 
                                        length penalty

Parameters for Tm Calculation:
  --enttemp arg (=37)                   temperature for entropie and entalpie 
                                        calculation in Celsius
  --monovalent arg (=50)                concentration of monovalent ions in 
                                        mMol
  --divalent arg (=1.5)                 concentration of divalent ions in mMol
  --dna arg (=50)                       concentration of annealing(!) Oligos in
                                        nMol
  --dntp arg (=0.59999999999999998)     the sum  of all dNTPs in mMol
```


## dicey_padlock

### Tool Description
Probes for one gene, one transcript, a set of genes, or custom FASTA input.

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
Probes for one gene: dicey padlock [OPTIONS] -g <ref.fa.gz> -t <ref.gtf.gz> -b <barcodes.fa.gz> ENSG00000171862
Probes for one transcript: dicey padlock [OPTIONS] -u transcript_id -g <ref.fa.gz> -t <ref.gtf.gz> -b <barcodes.fa.gz> ENST00000406757
Probes for a set of genes: dicey padlock [OPTIONS] -g <ref.fa.gz> -t <ref.gtf.gz> -b <barcodes.fa.gz> <gene.list.file>
Probes for custom FASTA input: dicey padlock [OPTIONS] -g <ref.fa.gz> -t <ref.gtf.gz> -b <barcodes.fa.gz> <sequences.fa>

Generic options:
  -? [ --help ]                         show help message
  -g [ --genome ] arg                   genome file
  -t [ --gtf ] arg                      gtf/gff3 file
  -i [ --config ] arg (="./src/primer3_config/")
                                        primer3 config directory
  -o [ --outfile ] arg (="out.tsv")     output file
  -j [ --json ] arg                     gzipped JSON file [optional]
  -e [ --absent ]                       source sequence is absent in reference 
                                        genome [only relevant for FASTA input]
  -n [ --hamming ]                      use hamming neighborhood instead of 
                                        edit distance

Padlock options:
  -a [ --anchor ] arg (=TGCGTCTATTTAGTGGAGCC)
                                        anchor sequence
  -l [ --spacerleft ] arg (=TCCTC)      spacer left
  -r [ --spacerright ] arg (=TCTTT)     spacer right
  -b [ --barcodes ] arg                 FASTA barcode file
  -d [ --distance ] arg (=1)            neighborhood distance
  -m [ --armlen ] arg (=20)             probe arm length
  -z [ --tmdiff ] arg (=2)              Tm difference between arms
  --gcmin arg (=0.40000000000000002)    minimum arm GC fraction
  --gcmax arg (=0.59999999999999998)    maximum arm GC fraction
  -u [ --attribute ] arg (=gene_id)     gtf/gff3 attribute
  -f [ --feature ] arg (=exon)          gtf/gff3 feature
  -p [ --probe ]                        apply distance to entire probe, i.e., 
                                        only one arm needs to be unique
  -v [ --overlapping ]                  allow overlapping probes

Parameters for Tm Calculation:
  --enttemp arg (=37)                   temperature for entropie and entalpie 
                                        calculation in Celsius
  --monovalent arg (=50)                concentration of monovalent ions in 
                                        mMol
  --divalent arg (=1.5)                 concentration of divalent ions in mMol
  --dna arg (=50)                       concentration of annealing(!) Oligos in
                                        nMol
  --dntp arg (=0.59999999999999998)     the sum  of all dNTPs in mMol
```


## dicey_chop

### Tool Description
Generic options:

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dicey chop [OPTIONS] Danio_rerio.fa.gz

Generic options:
  -? [ --help ]                   show help message
  -f [ --fq1 ] arg (=read1)       read1 output prefix
  -g [ --fq2 ] arg (=read2)       read2 output prefix
  -l [ --length ] arg (=101)      read length
  -i [ --insertsize ] arg (=501)  insert size
  -j [ --jump ] arg (=1)          chop offset
  -s [ --se ]                     generate single-end data
  -c [ --chromosome ]             generate reads by chromosome
  -r [ --revcomp ]                reverse complement all reads
```


## dicey_mappability2

### Tool Description
Calculate mappability of a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dicey mappability2 [OPTIONS] chopped.bam

Generic options:
  -? [ --help ]                        show help message
  -q [ --quality ] arg (=10)           min. mapping quality
  -c [ --chromosome ] arg              chromosome name to process
  -o [ --outfile ] arg (="map.fa.gz")  gzipped output file
  -s [ --insertsize ] arg (=501)       insert size
```


## dicey_blacklist

### Tool Description
Generates a blacklist file for a given genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/dicey
- **Package**: https://anaconda.org/channels/bioconda/packages/dicey/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dicey blacklist [OPTIONS] -b blacklist.bed Danio_rerio.fa.gz

Generic options:
  -? [ --help ]                         show help message
  -b [ --blacklist ] arg (="blacklist.bed")
                                        blacklist in BED format
  -o [ --outfile ] arg (="map.fa.gz")   gzipped output file
```


## Metadata
- **Skill**: generated
