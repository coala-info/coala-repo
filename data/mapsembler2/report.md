# mapsembler2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mapsembler2_extend | PASS |  |
| mapsembler2_extremities | PASS |  |
| mapsembler2_pipeline | PASS |  |

## mapsembler2_extremities

### Tool Description
Selects start and end k-mers of starters present in the reads and writes them as substarters.

### Metadata
- **Docker Image**: quay.io/biocontainers/mapsembler2:2.2.4--2
- **Homepage**: https://colibread.inria.fr/software/mapsembler2/
- **Package**: https://anaconda.org/channels/bioconda/packages/mapsembler2/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mapsembler2_extremities: ok via mapsembler2_extremities --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
Error : Option '--k' is mandatory
Error : Option '--starters' is mandatory
Error : Option '--reads' is mandatory
Error : Option '--output' is mandatory
USAGE for 'mapsembler2_extremities'
    --k                 (1 arg) :    kmer size that will be used for mapsembler2  [default '']
    --starters          (1 arg) :    starters fasta file  [default '']
    --reads             (1 arg) :    reads dataset file name. Several reads sets can be provided, surrounded by "'s and separated by a space (e.g. --reads "reads1.fa reads2.fa")  [default '']
    --output            (1 arg) :    output substarters file name  [default '']
    --min-solid-subkmer (1 arg) :    minimim abundance to keep a subkmer  [default '3']
    -debug              (0 arg) :    debugging
    -nb-cores           (1 arg) :    number of cores  [default '0']
    -verbose            (1 arg) :    verbosity level  [default '1']
    -help               (0 arg) :    display help about possible options
```

## mapsembler2_extend

### Tool Description
Extends starter sequences using the reads, as a linear sequence or a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mapsembler2:2.2.4--2
- **Homepage**: https://colibread.inria.fr/software/mapsembler2/
- **Package**: https://anaconda.org/channels/bioconda/packages/mapsembler2/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
mapsembler_extend, version 1.0.0 - Copyright INRIA - CeCILL License

SYNOPSIS
mapsembler2_extend <extrem_kmers.fasta> <readsC1.fasta> [<readsC2.fasta> [<readsC3.fasta] ...] [-t extension_type] [-k value] [-c value] [-g value] [-i index_name] [-o name] [-h]

DESCRIPTION
	 TODO

OPTIONS
	 -t extension_type. Default: 1
	    1: a strict sequence: any branching stops the extension
	    2: a consensus sequence: contiging approach
	    3: a strict graph: any branching is conserved in the graph
	    4: a consensus graph: "small" polymorphism is merged, but "large" structures are represented
	 -k size_kmers: Size of the k-mers used duriung the extension phase Default: 31. Accepted range, depends on the compilation (make k=42 for instance) 
	 -c min_coverage: a sequence is covered by at least min_coverage coherent reads. Default: 2
	 -g estimated_genome_size: estimation of the size of the genome whose reads come from. 
 	    It is in bp, does not need to be accurate, only controls memory usage. Default: 3 billion
	 -x node_len: limit max of nodes length. Default: 40
	 -y graph_max_depth: limit max of graph depth.Default: 10000
	 -i index_name: stores the index files in files starting with this prefix name. Can be re-used latter. Default: "index"
	    IF THE FILE "index_name.bloom" EXISTS: the index is not re-created 
	 -o file_name_prefix: where to write outputs. Default: "res_mapsembler" 
	 -p search_mod: kind of prosses Breadth or Depth. Default: Breadth 
	 -h prints this message and exit
```

## mapsembler2_pipeline

### Tool Description
Runs mapsembler2_extremities, mapsembler2_extend and kissreads on starters and reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/mapsembler2:2.2.4--2
- **Homepage**: https://colibread.inria.fr/software/mapsembler2/
- **Package**: https://anaconda.org/channels/bioconda/packages/mapsembler2/overview
- **Validation**: PASS

### Original Help Text
```text
[help] run_mapsembler2_pipeline.sh: ok via run_mapsembler2_pipeline.sh -h (--help=no_options, -h=ok, -help=ok, (no args)=ok)
run_mapsembler_pipeline.sh, a pipelining mapsembler2_extremities, mapsembler2_extend and kissread_g
Usage: ./run_mapsembler_and_phaser.sh -s <starter.fasta> -r <reads.faste> -t [1/2/3/4]<options>
	 	 -s: file containing starters (fasta)
	 	 -r list of reads separated by space, surrounded by the '"' character. Note that reads may be in fasta or fastq format, gzipped or not. Example: -r "data_sample/reads_sequence1.fasta   data_sample/reads_sequence2.fasta.gz".
	 	 -t: kind of assembly: 1=unitig (fasta), 2=contig (fasta), 3=unitig (graph), 4=contig(graph)
<options>:
		 -p prefix. All out files will start with this prefix. Example: -p my_prefix
		 -k value. Set the length of used kmers. Must fit the compiled value. Default=31. Example -k 31
		 -c value. Set the minimal coverage. Default=5. Example -c 5
		 -d value. Set the number of authorized substitutions used while mapping reads on found SNPs. Default=1. Example: -d 1
		 -g value. Estimated genome size. Used only to control memory usage. e.g. 3 billion (3000000000) uses 4Gb of RAM. Default=10 million. Example: -d 10000000
		 -f value. Set the process of search in the graph (1=Breadth  and 2=Depth). Default=1. Example: -f 1
		 -x value. Set the maximal nodes length . Default=40. Example: -x 40
		 -y value. Set the maximal graph depth . Default=10000. Example: -y 10000
		 -h Prints this message and exist
Any further question: read the readme file or contact us: pierre.peterlongo@inria.fr
```

## Metadata
- **Skill**: generated
