# lordec CWL Generation Report

## lordec_lordec-correct

### Tool Description
Corrects long reads using short reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/lordec:0.9--h77376b9_3
- **Homepage**: http://www.atgc-montpellier.fr/lordec/
- **Package**: https://anaconda.org/channels/bioconda/packages/lordec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lordec/overview
- **Total Downloads**: 16.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
LoRDEC v0.9
using GATB v1.4.1
website : http://www.atgc-montpellier.fr/lordec/
FAQ : https://www.lirmm.fr/~rivals/lordec/FAQ/

Usage :

lordec-correct

-i|--long_reads <long read FASTA/Q file>
-2|--short_reads <short read FASTA/Q file(s)>
-k|--kmer_len <k-mer size>
-o|--corrected_read_file <output reads file>
-s|solid_threshold <solid k-mer abundance threshold>
[-t|--trials <number of paths to try from a k-mer>]
[-b|--branch <maximum number of branches to explore>]
[-e|--errorrate <maximum error rate>]
[-T|--threads <number of threads>]
[-S|--stat_file <out statistics file>]
[-c|--complete_search]
[-a|--abundance-max <abundance max threshold for k-mers>]
[-O|--out-tmp <GATB graph creation temporary files directory>]
[-p|--progress]
[-g|--graph_named_like_output]
```


## lordec_lordec-trim

### Tool Description
LoRDEC v0.9

### Metadata
- **Docker Image**: quay.io/biocontainers/lordec:0.9--h77376b9_3
- **Homepage**: http://www.atgc-montpellier.fr/lordec/
- **Package**: https://anaconda.org/channels/bioconda/packages/lordec/overview
- **Validation**: PASS

### Original Help Text
```text
LoRDEC v0.9
using GATB v1.4.1
website : http://www.atgc-montpellier.fr/lordec/
FAQ : https://www.lirmm.fr/~rivals/lordec/FAQ/

Usage :

lordec-trim -i <FASTA-file> -o <output-file>
```


## lordec_lordec-trim-split

### Tool Description
Scan a set of corrected long reads (in FASTA format) and output as sequence their regions that have indeed been corrected (which are in uppercase).

### Metadata
- **Docker Image**: quay.io/biocontainers/lordec:0.9--h77376b9_3
- **Homepage**: http://www.atgc-montpellier.fr/lordec/
- **Package**: https://anaconda.org/channels/bioconda/packages/lordec/overview
- **Validation**: PASS

### Original Help Text
```text
LoRDEC v0.9
using GATB v1.4.1
website : http://www.atgc-montpellier.fr/lordec/
FAQ : https://www.lirmm.fr/~rivals/lordec/FAQ/

Usage :

lordec-trim-split -i <FASTA-file> -o <output-file>
       scan a set of corrected long reads (in FASTA format) and output as sequence their regions that have indeed been corrected (which are in uppercase).
```


## lordec_lordec-build-SR-graph

### Tool Description
reads the <FASTA/Q file(s)> of short reads, then builds and save their de Bruijn graph for k-mers of length <k-mer size> and occurring at least <abundance threshold> time; the graph is saved in an external file named <out graph file>

### Metadata
- **Docker Image**: quay.io/biocontainers/lordec:0.9--h77376b9_3
- **Homepage**: http://www.atgc-montpellier.fr/lordec/
- **Package**: https://anaconda.org/channels/bioconda/packages/lordec/overview
- **Validation**: PASS

### Original Help Text
```text
LoRDEC v0.9
using GATB v1.4.1
website : http://www.atgc-montpellier.fr/lordec/
FAQ : https://www.lirmm.fr/~rivals/lordec/FAQ/

Usage :

lordec-build-SR-graph [-T <number of threads>] [-O <GATB graph creation temporary files directory>] [-a <abundance max threshold for k-mers>] -2 <short read FASTA/Q file(s)> -k <k-mer size> -s <solid k-mer abundance threshold> -g <out graph file> 
         reads the <FASTA/Q file(s)> of short reads, then builds and save their de Bruijn graph for k-mers of length <k-mer size> and occurring at least <abundance threshold> time; the graph is saved in an external file named <out graph file>
```

