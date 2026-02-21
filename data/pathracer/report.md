# pathracer CWL Generation Report

## pathracer

### Tool Description
PathRacer is a tool for aligning HMMs or sequences against assembly graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathracer:3.16.0.dev--h95f258a_0
- **Homepage**: http://cab.spbu.ru/software/pathracer/
- **Package**: https://anaconda.org/channels/bioconda/packages/pathracer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pathracer/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
        /usr/local/bin/pathracer <input file (HMM or sequence)> <load from> --output <output directory> [--global|--local] [--length <value>] [--indel-rate <value>] [--top <N>] [--threads <NTHREADS>] [--memory <MEMORY>] [--max-size <SIZE>] [--quiet] [--ignore-names] [--hmm|--nt|--aa] [--queries <queries>...] [--edges <edges>...] [--seed-edges|--seed-scaffolds|--seed-edges-scaffolds|--seed-exhaustive|--seed-edges-1-by-1|--seed-scaffolds-1-by-1] [--debug] [--draw] [--rescore] [--annotate-graph] [--acc] [--noali] [-E <value>] [-T <value>] [--domE <value>] [--domT <value>] [-incE <value>] [-incT <value>] [-incdomE <value>] [-incdomT <value>] [--cut_ga] [--cut_nc] [--cut_tc] [--max] [--F1 <value>] [--F2 <value>] [--F3 <value>] [--parallel-components] [--max-insertion-length <x>] [--expand-coef <value>] [--expand-const <value>] [--no-top-score-filter] [--no-fast-forward] [--known-sequences <filename>] [--export-event-graph]

OPTIONS
        <output directory>
                    output directory

        --global    perform global-local (aka glocal) HMM matching [default]
        --local     perform local-local HMM matching

        --length, -l <value>
                    minimal length of resultant matched sequence; if <=1 then to be multiplied on the length of the pHMM [default: 0.9]

        --indel-rate, -r <value>
                    expected rate of nucleotides indels in graph edges [default: 0]. Used for AA pHMM alignment with frame shifts

        --top <N>   extract top N paths [default: 10000]

        --threads, -t <NTHREADS>
                    the number of parallel threads [default: 16]

        --memory, -m <MEMORY>
                    RAM limit for PathRacer in GB (terminates if exceeded) [default: 100]

        --max-size <SIZE>
                    maximal component size to consider [default: INF]

        --quiet, -q be quiet, do not output anything to the console

        --ignore-names
                    ignore HMM/sequence names (in case of dups, etc)

        Query type:
            --hmm   match against HMM(s) [default]
            --nt    match against nucleotide string(s)
            --aa    match agains amino acid string(s)

        --queries <queries>
                    queries names to lookup [default: all queries from input query file]

        --edges <edges>
                    match around particular edges [default: all graph edges]

        Seeding options:
            --seed-edges
                    use graph edges as seeds

            --seed-scaffolds
                    use scaffolds paths as seeds

            --seed-edges-scaffolds
                    use edges AND scaffolds paths as seeds [default]

            --seed-exhaustive
                    exhaustive mode, use ALL edges

            --seed-edges-1-by-1
                    use edges as seeds (1 by 1)

            --seed-scaffolds-1-by-1
                    use scaffolds paths as seeds (1 by 1)

        Control of the output:
            --debug enable extensive debug output
            --draw  draw pictures around the interesting edges

            --rescore
                    rescore paths via HMMer

            --annotate-graph
                    emit paths in GFA graph

        HMMER options (used for seeding and rescoring):
            --acc   prefer accessions over names in output
            --noali don't output alignments, so output is smaller

            -E <value>
                    report sequences <= this E-value threshold in output

            -T <value>
                    report sequences >= this score threshold in output

            --domE <value>
                    report domains <= this E-value threshold in output

            --domT <value>
                    report domains >= this score cutoff in output

            -incE <value>
                    consider sequences <= this E-value threshold as significant

            -incT <value>
                    consider sequences >= this score threshold as significant

            -incdomE <value>
                    consider domains <= this E-value threshold as significant

            -incdomT <value>
                    consider domains >= this score threshold as significant

            --cut_ga
                    use profile's GA gathering cutoffs to set all thresholding

            --cut_nc
                    use profile's NC noise cutoffs to set all thresholding

            --cut_tc
                    use profile's TC trusted cutoffs to set all thresholding

            --max   Turn all heuristic filters off (less speed, more power)

            --F1 <value>
                    Stage 1 (MSV) threshold: promote hits w/ P <= F1

            --F2 <value>
                    Stage 2 (Vit) threshold: promote hits w/ P <= F2

            --F3 <value>
                    Stage 3 (Fwd) threshold: promote hits w/ P <= F3

        Developer options:
            --parallel-components
                    process connected components of neighborhood subgraph in parallel [default: false]

            --max-insertion-length <x>
                    maximal allowed number of successive I-emissions [default: 30]

            --expand-coef <value>
                    overhang expansion coefficient for neighborhood search [default: 2]

            --expand-const <value>
                    const addition to overhang values for neighborhood search [default: 20]

            --no-top-score-filter
                    disable top score Event Graph vertices filter [default: false]

            --no-fast-forward
                    disable fast forward in I-loops processing [default: false]

            --known-sequences <filename>
                    FASTA file with known sequnces that should be definitely found

            --export-event-graph
                    export event graph in cereal format
```


## Metadata
- **Skill**: generated
