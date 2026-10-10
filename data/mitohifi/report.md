# mitohifi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mitohifi_findMitoReference.py | PASS | downloaded the closest complete mitogenome from NCBI (needs network access) |
| mitohifi_mitohifi.py | PASS | contigs mode (-c) found a circular 15320 bp mitogenome with 36 genes on a real moth data set; reads mode (-r) was not run (too slow here) |

## mitohifi_mitohifi.py

### Tool Description
Assembles and annotates animal or plant mitochondrial genomes from PacBio HiFi reads or contigs with a related mitogenome as reference.

### Metadata
- **Docker Image**: biocontainers/mitohifi:2.2_cv1
- **Homepage**: https://github.com/marcelauliano/MitoHiFi
- **Package**: https://anaconda.org/channels/bioconda/packages/mitohifi/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitohifi.py: ok via mitohifi.py --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: MitoHiFi [-h] (-r <reads>.fasta | -c <contigs>.fasta) -f
                <relatedMito>.fasta -g <relatedMito>.gbk -t <THREADS> [-d]
                [-a {animal,plant}] [-p <PERC>] [-m <BLOOM FILTER>]
                [--circular-size CIRCULAR_SIZE]
                [--circular-offset CIRCULAR_OFFSET] [-v] [-o <GENETIC CODE>]

required arguments:
  -r <reads>.fasta      -r: Pacbio Hifi Reads from your species
  -c <contigs>.fasta    -c: Assembled fasta contigs/scaffolds to be searched
                        to find mitogenome
  -f <relatedMito>.fasta
                        -f: Close-related Mitogenome is fasta format
  -g <relatedMito>.gbk  -k: Close-related species Mitogenome in genebank
                        format
  -t <THREADS>          -t: Number of threads for (i) hifiasm and (ii) the
                        blast search

optional arguments:
  -d                    -d: debug mode to output additional info on log
  -a {animal,plant}     -a: Choose between animal (default) or plant
  -p <PERC>             -p: Percentage of query in the blast match with close-
                        related mito
  -m <BLOOM FILTER>     -m: Number of bits for HiFiasm bloom filter [it maps
                        to -f in HiFiasm] (default = 0)
  --circular-size CIRCULAR_SIZE
                        Size to consider when checking for circularization
  --circular-offset CIRCULAR_OFFSET
                        Offset from start and finish to consider when looking
                        for circularization
  -v, --version         show program's version number and exit
  -o <GENETIC CODE>     -o: Organism genetic code following NCBI table (for
                        mitogenome annotation): 1. The Standard Code 2. The
                        Vertebrate MitochondrialCode 3. The Yeast
                        Mitochondrial Code 4. The Mold,Protozoan, and
                        Coelenterate Mitochondrial Code and the
                        Mycoplasma/Spiroplasma Code 5. The Invertebrate
                        Mitochondrial Code 6. The Ciliate, Dasycladacean and
                        Hexamita Nuclear Code 9. The Echinoderm and Flatworm
                        Mitochondrial Code 10. The Euplotid Nuclear Code 11.
                        The Bacterial, Archaeal and Plant Plastid Code 12. The
                        Alternative Yeast Nuclear Code 13. The Ascidian
                        Mitochondrial Code 14. The Alternative Flatworm
                        Mitochondrial Code 16. Chlorophycean Mitochondrial
                        Code 21. Trematode Mitochondrial Code 22. Scenedesmus
                        obliquus Mitochondrial Code 23. Thraustochytrium
                        Mitochondrial Code 24. Pterobranchia Mitochondrial
                        Code 25. Candidate Division SR1 and Gracilibacteria
                        Code
```

## mitohifi_findMitoReference.py

### Tool Description
Finds and downloads the closest complete mitochondrial or chloroplast genome from NCBI for a species.

### Metadata
- **Docker Image**: biocontainers/mitohifi:2.2_cv1
- **Homepage**: https://github.com/marcelauliano/MitoHiFi
- **Package**: https://anaconda.org/channels/bioconda/packages/mitohifi/overview
- **Validation**: PASS

### Original Help Text
```text
[help] findMitoReference.py: ok via findMitoReference.py --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: findMitoReference.py [-h] --species SPECIES [--email [EMAIL]]
                            [--outfolder [OUTFOLDER]]
                            [-t {mitochondrion,chloroplast}]
                            [--min_length [MIN_LENGTH]]

optional arguments:
  -h, --help            show this help message and exit
  --species SPECIES     latin name
  --email [EMAIL]
  --outfolder [OUTFOLDER]
  -t {mitochondrion,chloroplast}
                        specify the type of organelle
  --min_length [MIN_LENGTH]
                        minimal appropriate length
```
