# pantax CWL Generation Report

## pantax

### Tool Description
Strain-level metagenomic profiling using pangenome graphs with PanTax

### Metadata
- **Docker Image**: quay.io/biocontainers/pantax:2.0.1--py310h3e1df6f_1
- **Homepage**: https://github.com/LuoGroup2023/PanTax
- **Package**: https://anaconda.org/channels/bioconda/packages/pantax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pantax/overview
- **Total Downloads**: 753
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/LuoGroup2023/PanTax
- **Stars**: N/A
### Original Help Text
```text
2026-02-26 16:54:34 - /usr/local/bin/pantax --help
Usage: /usr/local/bin/pantax -f genomes_info -s/-l -r read.fq [option]
       paired-end: /usr/local/bin/pantax -f genomes_info -s -p -r read.fq --species-level --strain-level

Strain-level metagenomic profiling using pangenome graphs with PanTax

Author: Wenhai Zhang
Date:   May 2024

    General options:
        -f, --genomesInformation file:    A list of reference genomes in specified format. (Mandatory)
        -db dir                           Name for pantax DB (default: pantax_db).
        -T dir                            Temporary directory (default: pantax_db_tmp).
        -n, --next                        Keep the temporary folder for later use at the strain level (resume).
        -t, --threads int                 Number of processes to run in parallel. (default: all available)
        -v, --verbose                     Detailed database build log.
        --vg file                         Path to vg executable file.
        --debug                           Keep the temporary folder for any situation.
        --help, -h                        Print this help message.
        --version                         Print the version info.
    Database creation:
        --create                          Create the database only.
        --fast                            Create the database using genomes filtered by sylph query instead of all genomes.
        -g, --save                        Save species graph information.
            --lz                          Serialized zip graph file saved with lz4 format (for save option).
            --zstd                        Serialized zip graph file saved with zstd format (for save option).
        --force                           Force to rebuild pangenome.
        -e file                           Path to pangenome building tool executable file. (default: pggb)
        -A, --ani float                   ANI threshold for sylph query result filter. (default: 99)
    Index construction(for vg giraffe):
        --index                           Create the index only.
        --best                            Best autoindex, which corresponds to vg autoindex. (only used with -s)
        --fast-aln                        Long read fast alignment with vg instead of Graphaligner. (only used with -l)
    Read alignment:
        -r, --fastq-in file               Read and align FASTQ-format reads from FILE (two are allowed with -p).
        -s, --short-read                  Short read alignment.
        -p, --paired                      For paired-end alignment.
        -l, --long-read                   Long read alignment.
        -lt, --long-read-type str         Long read type (hifi, clr, ontr9, ontr10). Set precise-clipping based on read type.
        --precise-clipping float          clip the alignment ends with arg as the identity cutoff between correct / wrong alignments. (default: 0.66)
    Abundacnce calculation:
        --species-level | --species       Species abundance calulation.
        --strain-level | --strain         Strain abundance calulation.
        --solver str                      MLP solver. (options: gurobi, cbc, glpk, highs. default: gurobi)
        -a float                          Species with relative abundance above the threshold are used for strain abundance estimation. (default: 0.0001)
        -fr float                         fstrain. The fraction of strain-specific triplet nodes covered by reads for one strain. The larger, the stricter.
                                          (default: short 0.3/ long 0.5)
        -fc float                         dstrain. The divergence between first rough and second refined strain abundance estimates. The smaller, the stricter.
                                          (default: 0.46)
        -sh, --shift bool                 Shifting fraction of strain-specific triplet nodes. (multi-species: off, single-species: on)
        -sd float                         Coverage depth difference between the strain and its species, with only one strain. (default: 0.2)
        -sr float                         Rescued strain retention score. (default: 0.85)
        --min_cov int                     Minimum coverage depth required per strain. (default: 0)
        --min_depth int                   Graph nodes with sequence coverage depth more than <min_depth>. (default: 0)
        -gt int                           Gurobi threads. (default: 1)
        -S, --classified-out str          File for alignment output(prefix).
        -R, --report str                  File for read classification(binning) output(prefix).
        -o, --ouput str                   File for abundance output(prefix).
```

