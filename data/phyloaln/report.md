# phyloaln CWL Generation Report

## phyloaln_PhyloAln

### Tool Description
A program to directly generate multiple sequence alignments from FASTA/FASTQ files based on reference alignments for phylogenetic analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Total Downloads**: 663
- **Last updated**: 2025-06-08
- **GitHub**: https://github.com/huangyh45/PhyloAln
- **Stars**: N/A
### Original Help Text
```text
Error: no argument was provided!

usage: PhyloAln [options] -a reference_alignment_file -s species -i fasta_file -f fasta -o output_directory
PhyloAln [options] -d reference_alignments_directory -c config.tsv -f fastq -o output_directory

A program to directly generate multiple sequence alignments from FASTA/FASTQ files based on reference alignments for phylogenetic analyses.
Citation: Huang Y-H, Sun Y-F, Li H, Li H-S, Pang H. 2024. MBE. 41(7):msae150. https://doi.org/10.1093/molbev/msae150

options:
  -h, --help            show this help message and exit
  -a ALN, --aln ALN     the single reference FASTA alignment file
  -d ALN_DIR, --aln_dir ALN_DIR
                        the directory containing all the reference FASTA
                        alignment files
  -x ALN_SUFFIX, --aln_suffix ALN_SUFFIX
                        the suffix of the reference FASTA alignment files when
                        using "-d"(default:.fa)
  -s SPECIES, --species SPECIES
                        the studied species ID for the provided FASTA/FASTQ
                        files(-i)
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        the input FASTA/FASTQ file(s) of the single
                        species(-s), compressed files ending with ".gz" are
                        allowed
  -c CONFIG, --config CONFIG
                        the TSV file with the format of 'species
                        sequence_file(s)(absolute path, files separated by
                        commas)' per line for multiple species
  -f {guess,fastq,fasta,large_fasta}, --file_format {guess,fastq,fasta,large_fasta}
                        the file format of the provided FASTA/FASTQ files,
                        'large_fasta' is recommended for speeding up reading
                        the FASTA files with long sequences(e.g. genome
                        sequences) and cannot be guessed(default:guess)
  -o OUTPUT, --output OUTPUT
                        the output directory containing the
                        results(default:PhyloAln_out)
  -p CPU, --cpu CPU     maximum threads to be totally used in parallel
                        tasks(default:8)
  --parallel PARALLEL   number of parallel tasks for each alignments, number
                        of CPUs used for single alignment will be
                        automatically calculated by '--cpu /
                        --parallel'(default:the smaller value between number
                        of alignments and the maximum threads to be used)
  -e {dna2reads,prot2reads,codon2reads,fast_dna2reads,fast_prot2reads,fast_codon2reads,dna2trans,prot2trans,codon2trans,dna2genome,prot2genome,codon2genome,rna2rna,prot2prot,codon2codon,gene_dna2dna,gene_rna2rna,gene_codon2codon,gene_codon2dna,gene_prot2prot}, --mode {dna2reads,prot2reads,codon2reads,fast_dna2reads,fast_prot2reads,fast_codon2reads,dna2trans,prot2trans,codon2trans,dna2genome,prot2genome,codon2genome,rna2rna,prot2prot,codon2codon,gene_dna2dna,gene_rna2rna,gene_codon2codon,gene_codon2dna,gene_prot2prot}
                        the common mode to automatically set the parameters
                        for easy use(**NOTICE: if you manually set those
                        parameters, the parameters you set will be ignored and
                        covered! See https://github.com/huangyh45/PhyloAln/blo
                        b/main/README.md#example-commands-for-different-data-
                        and-common-mode-for-easy-use for detailed parameters)
  -m {dna,prot,codon,dna_codon}, --mol_type {dna,prot,codon,dna_codon}
                        the molecular type of the reference
                        alignments(default:dna, 'dna' suitable for nucleotide-
                        to-nucleotide or protein-to-protein alignment, 'prot'
                        suitable for protein-to-nucleotide alignment, 'codon'
                        and 'dna_codon' suitable for codon-to-nucleotide
                        alignment based on protein and nucleotide alignments
                        respectively)
  -g GENCODE, --gencode GENCODE
                        the genetic code used in translation(default:1 = the
                        standard code, see https://www.ncbi.nlm.nih.gov/Taxono
                        my/Utils/wprintgc.cgi)
  --ref_split_len REF_SPLIT_LEN
                        If provided, split the reference alignments longer
                        than this length into short alignments with this
                        length, ~1000 may be recommended for concatenated
                        alignments, and codon alignments should be devided by
                        3
  -l SPLIT_LEN, --split_len SPLIT_LEN
                        If provided, split the sequences longer than this
                        length into short sequences with this length, 200 may
                        be recommended for long genomic reads or sequences
  --split_slide SPLIT_SLIDE
                        the slide to split the sequences using sliding window
                        method(default:half of '--split_len')
  -n, --no_reverse      not to prepare and search the reverse strand of the
                        sequences, recommended for searching protein or CDS
                        sequences
  --low_mem             use a low-memory but slower mode to prepare the reads,
                        'large_fasta' format is not supported and gz
                        compressed files may still spend some memory
  --hmmbuild_parameters HMMBUILD_PARAMETERS [HMMBUILD_PARAMETERS ...]
                        the parameters when using HMMER hmmbuild for reference
                        preparation, with the format of ' --xxx' of each
                        parameter, in which space is required(default:[])
  --hmmsearch_parameters HMMSEARCH_PARAMETERS [HMMSEARCH_PARAMETERS ...]
                        the parameters when using HMMER hmmsearch for mapping
                        the sequences, with the format of ' --xxx' of each
                        parameter, in which space is required((default:[])
  -b, --no_assemble     not to assemble the raw sequences based on overlap
                        regions
  --overlap_len OVERLAP_LEN
                        minimum overlap length when assembling the raw
                        sequences(default:30)
  --overlap_pident OVERLAP_PIDENT
                        minimum overlap percent identity when assembling the
                        raw sequences(default:98.00)
  -t, --no_out_filter   not to filter the foreign or no-signal sequences based
                        on conservative score
  -u OUTGROUP [OUTGROUP ...], --outgroup OUTGROUP [OUTGROUP ...]
                        the outgroup species for foreign or no-signal
                        sequences detection(default:all the sequences in the
                        alignments with all sequences as ingroups)
  --ingroup INGROUP [INGROUP ...]
                        the ingroup species for score calculation in foreign
                        or no-signal sequences detection(default:all the
                        sequences when all sequences are set as outgroups; all
                        other sequences except the outgroups)
  -q SEP, --sep SEP     the separate symbol between species name and gene
                        identifier in the sequence headers of the
                        alignments(default:.)
  --outgroup_weight OUTGROUP_WEIGHT
                        the weight coefficient to adjust strictness of the
                        foreign or no-signal sequence filter, small number or
                        decimal means ralaxed criterion (default:0.90, 1 = not
                        adjust)
  -r, --no_cross_species
                        not to remove the cross contamination for multiple
                        species
  --cross_overlap_len CROSS_OVERLAP_LEN
                        minimum overlap length when cross contamination
                        detection(default:30)
  --cross_overlap_pident CROSS_OVERLAP_PIDENT
                        minimum overlap percent identity when cross
                        contamination detection(default:98.00)
  --min_exp MIN_EXP     minimum expression value when cross contamination
                        detection(default:0.20)
  --min_exp_fold MIN_EXP_FOLD
                        minimum expression fold when cross contamination
                        detection(default:5.00)
  -w UNKNOW_SYMBOL, --unknow_symbol UNKNOW_SYMBOL
                        the symbol representing unknown bases for missing
                        regions(default:unknow = 'N' in nucleotide alignments
                        and 'X' in protein alignments)
  -z {consensus,consensus_strict,all,expression,length}, --final_seq {consensus,consensus_strict,all,expression,length}
                        the mode to output the sequences(default:consensus,
                        'consensus' means selecting most common bases from all
                        sequences, 'consensus_strict' means only selecting the
                        common bases and remaining the different bases unknow,
                        'all' means remaining all sequences, 'expression'
                        means the sequence with highest read counts after
                        assembly, 'length' means sequence with longest length
  -y, --no_ref          not to output the reference sequences
  -k, --keep_seqid      keep original sequence IDs in the output alignments
                        instead of renaming them based on the species ID, not
                        recommended when the output mode is
                        'consensus'/'consensus_strict' or the assembly step is
                        on
  -v, --version         show program's version number and exit

Written by Yu-Hao Huang (2023-2025) huangyh45@mail3.sysu.edu.cn
```


## phyloaln_connect.pl

### Tool Description
Concatenate multiple alignments into a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

### Original Help Text
```text
perl /usr/local/bin/connect.pl
Concatenate multiple alignments into a matrix.

Usage: 
-i   directory containing input FASTA alignment files
-o   output concatenated FASTA alignment file
-t   type of input format(phyloaln/orthograph/blastsearch, default='phyloaln', also suitable for the format with same species name in all alignments, but the name shuold not contain separate symbol)
-f   the symbol to fill the sites of absent species in the alignments(default='-')
-s   the symbol to separate the sequences name and the first space is the species name in the 'phyloaln' format(default='.')
-x   the suffix of the input FASTA alignment files(default='.fa')
-b   the block file of the positions of each alignments(default=not to output)
-n   output the block file with NEXUS format, suitable for IQ-TREE(default=no)
-c   the codon positions to be written in the block file(default=no codon position, '123' represents outputing all the three codon positions, '12' represents outputing first and second positions)
-l   the list file with all the involved species you want to be included in the output alignments, one species per line(default=automatically generated, with all species found at least once in all the alignments)
-h   this help message

Example:
connect.pl -i inputdir -o outputfile -t inputtype -f fillsymbol -s separate -x suffix -b block1file -n -c codonpos -l listfile

Written by Yu-Hao Huang (2018-2024) huangyh45@mail3.sysu.edu.cn
```


## phyloaln_trim_matrix.py

### Tool Description
Trims a multiple sequence alignment matrix based on specified criteria for columns and rows.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/trim_matrix.py input_dir output_dir unknown_symbol(default='X') known_number(>=1)_or_percent(<1)_for_columns(default=0.5) known_number(>=1)_or_percent(<1)_for_rows(default=0) fasta_suffix(default='.fa')
```


## phyloaln_transseq.pl

### Tool Description
Converts sequences between different formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/transseq.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: transseq.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -i -o -g -t -c -a -n -l
	Boolean (without arguments): -h

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]

Error: no input file or output file was set!

You can use '-h' to watch detailed help.
```


## phyloaln_revertransseq.pl

### Tool Description
Used the aligned translated sequences in a file as blueprint to aligned nucleotide sequences, which means reverse-translation.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

### Original Help Text
```text
perl /usr/local/bin/revertransseq.pl
Used the aligned translated sequences in a file as blueprint to aligned nucleotide sequences, which means reverse-translation.

Usage: 
-i   input nucleotide sequences file or files(separated by ',')
-b   aligned amino acid sequences file translated by input file as blueprint
-o   output aligned nucleotide sequences file
-g   genetic code(default=1, invertebrate mitochondrion=5)
-t   symbol of termination in blueprint(default='*')
-n   num threads(default=1)
-l   log file(default='revertransseq.log')
-h   this help message

Example:
revertransseq.pl -i ntfile1,ntfile2,ntfile3 -b aafile -o alignedfile -g gencode -t termination -n numthreads -l logfile

Written by Yu-Hao Huang (2017-2024) huangyh45@mail3.sysu.edu.cn
```


## phyloaln_root_tree.py

### Tool Description
Roots a phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

### Original Help Text
```text
Error: options < 2!
Usage: /usr/local/bin/root_tree.py input.nwk output.nwk outgroup/outgroups(default=the midpoint outgroup, separated by comma)
```


## phyloaln_prune_tree.py

### Tool Description
Prunes a phylogenetic tree by removing specified sequences from clades.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/huangyh45/PhyloAln
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloaln/overview
- **Validation**: PASS

### Original Help Text
```text
Error: options < 3!
Usage: /usr/local/bin/prune_tree.py input.nwk output.nwk seq/seqs(separated by comma)_in_clade1_for_deletion( seq/seqs_in_clade2_for_deletion ...)
```

