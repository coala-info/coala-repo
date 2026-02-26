# marbel CWL Generation Report

## marbel

### Tool Description
Create a metatranscriptome in silico dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/marbel:0.2.4--pyh7e72e81_0
- **Homepage**: https://github.com/jlab/marbel
- **Package**: https://anaconda.org/channels/bioconda/packages/marbel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/marbel/overview
- **Total Downloads**: 508
- **Last updated**: 2025-06-06
- **GitHub**: https://github.com/jlab/marbel
- **Stars**: N/A
### Original Help Text
```text
Usage: marbel [OPTIONS]                                                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --n-species                              INTEGER           Number of species │
│                                                            to be drawn for   │
│                                                            the               │
│                                                            metatranscriptom… │
│                                                            in silico         │
│                                                            dataset. Maximum  │
│                                                            value: 614.       │
│                                                            [default: 20]     │
│ --n-orthogroups                          INTEGER           Number of         │
│                                                            orthologous       │
│                                                            groups to be      │
│                                                            drawn for the     │
│                                                            metatranscriptom… │
│                                                            in silico         │
│                                                            dataset. Maximum  │
│                                                            value: 365813.    │
│                                                            [default: 1000]   │
│ --n-samples                              <INTEGER          Number of samples │
│                                          INTEGER>...       to be created for │
│                                                            the               │
│                                                            metatranscriptom… │
│                                                            in silico         │
│                                                            datasetthe first  │
│                                                            number is the     │
│                                                            number of samples │
│                                                            for group 1       │
│                                                            andthe second     │
│                                                            number is the     │
│                                                            number of samples │
│                                                            for group 2       │
│                                                            [default: 10, 10] │
│ --outdir                                 TEXT              Output directory  │
│                                                            for the           │
│                                                            metatranscriptom… │
│                                                            in silico dataset │
│                                                            [default:         │
│                                                            simulated_reads]  │
│ --max-phylo-dist…                        [phylum|class|or  Maximimum mean    │
│                                          der|family|genus  phylogenetic      │
│                                          ]                 distance for      │
│                                                            orthologous       │
│                                                            groups.specify    │
│                                                            stricter limit,   │
│                                                            if you want to    │
│                                                            avoid orthologous │
│                                                            groupswith a more │
│                                                            diverse           │
│                                                            phylogenetic      │
│                                                            distance.         │
│                                                            [default: None]   │
│ --min-identity                           FLOAT             Minimum mean      │
│                                                            sequence identity │
│                                                            score for an      │
│                                                            orthologous       │
│                                                            groups.Specify    │
│                                                            for more          │
│                                                            [default: None]   │
│ --dge-ratio                              FLOAT             Ratio of up and   │
│                                                            down regulated    │
│                                                            genes. Must be    │
│                                                            between 0 and     │
│                                                            1.This is a       │
│                                                            random drawing    │
│                                                            process from      │
│                                                            normal            │
│                                                            distribution, so  │
│                                                            the actual ratio  │
│                                                            might vary.       │
│                                                            [default: 0.2]    │
│ --seed                                   INTEGER           Seed for the      │
│                                                            sampling. Set for │
│                                                            reproducibility   │
│                                                            [default: None]   │
│ --error-model                            [basic|perfect|H  Sequencer model   │
│                                          iSeq|NextSeq|Nov  for the reads,    │
│                                          aSeq|Miseq-20|Mi  use basic or      │
│                                          seq-24|Miseq-28|  perfect (no       │
│                                          Miseq-32]         errors) for       │
│                                                            custom read       │
│                                                            length. Note that │
│                                                            read lenght must  │
│                                                            be set when using │
│                                                            basic or perfect. │
│                                                            [default: HiSeq]  │
│ --compressed         --no-compressed                       Compress the      │
│                                                            output fastq      │
│                                                            files             │
│                                                            [default:         │
│                                                            compressed]       │
│ --read-length                            INTEGER           Read length for   │
│                                                            the reads. Only   │
│                                                            available when    │
│                                                            using error_model │
│                                                            basic or perfect  │
│                                                            [default: None]   │
│ --library-size                           INTEGER           Library size for  │
│                                                            the reads.        │
│                                                            [default: 100000] │
│ --library-size-d…                        TEXT              Distribution for  │
│                                                            the library size. │
│                                                            Select from:      │
│                                                            ['poisson',       │
│                                                            'uniform',        │
│                                                            'negative_binomi… │
│                                                            [default:         │
│                                                            uniform]          │
│ --group-ortholog…                        [very_low|low|no  Determines the    │
│                                          rmal|high|very_h  level of          │
│                                          igh]              orthology in      │
│                                                            groups. If you    │
│                                                            use this, use it  │
│                                                            with a lot of     │
│                                                            threads. Takes a  │
│                                                            long time.        │
│                                                            [default: normal] │
│ --threads                                INTEGER           Number of threads │
│                                                            to be used. Use 0 │
│                                                            or -1 for auto    │
│                                                            detection. Uppler │
│                                                            limit: 128.       │
│                                                            [default: 10]     │
│ --deseq-dispersi…                        FLOAT             For generating    │
│                                                            sampling: General │
│                                                            dispersion        │
│                                                            estimation of     │
│                                                            DESeq2. Only set  │
│                                                            when you have     │
│                                                            knowledge of      │
│                                                            DESeq2            │
│                                                            dispersion.       │
│                                                            [default:         │
│                                                            12.9105102]       │
│ --deseq-dispersi…                        FLOAT             For generating    │
│                                                            sampling: Gene    │
│                                                            mean dependent    │
│                                                            dispersion of     │
│                                                            DESeq2. Only set  │
│                                                            when you have     │
│                                                            knowledge of      │
│                                                            DESeq2            │
│                                                            dispersion.       │
│                                                            [default:         │
│                                                            0.3325853]        │
│ --min-sparsity                           FLOAT             Will archive the  │
│                                                            minimum specified │
│                                                            sparcity by       │
│                                                            zeroing count     │
│                                                            values randomly.  │
│                                                            [default: 0]      │
│ --force-creation     --no-force-crea…                      Force the         │
│                                                            creation of the   │
│                                                            dataset, even if  │
│                                                            available         │
│                                                            orthogroups do    │
│                                                            not suffice for   │
│                                                            specified number  │
│                                                            of orthogroups.   │
│                                                            [default:         │
│                                                            no-force-creatio… │
│ --min-overlap                            INTEGER           Minimum overlap   │
│                                                            for the blocks.   │
│                                                            Use this to       │
│                                                            evaluate overlap  │
│                                                            blocks, i.e.      │
│                                                            uninterrupted     │
│                                                            parts covered     │
│                                                            with reads that   │
│                                                            overlap on the    │
│                                                            genome. Accounts  │
│                                                            for kmer size.    │
│                                                            [default: 16]     │
│ --version                                                                    │
│ --install-comple…                                          Install           │
│                                                            completion for    │
│                                                            the current       │
│                                                            shell.            │
│ --show-completion                                          Show completion   │
│                                                            for the current   │
│                                                            shell, to copy it │
│                                                            or customize the  │
│                                                            installation.     │
│ --help                                                     Show this message │
│                                                            and exit.         │
╰──────────────────────────────────────────────────────────────────────────────╯
```

