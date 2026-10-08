# polap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| polap_annotate | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_assemble | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_assemble1 | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_assemble2 | Failed | image problem: assemble2 calls the same missing 'polap' conda environment check (source line 442), and its seed-contig inputs from assemble1/seeds cannot be made in this image. |
| polap_disassemble | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_polish | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_prepare-polishing | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_readassemble | Failed | image problem: polap needs a conda environment named 'polap' (conda.sh) that the biocontainer lacks, so it exits 1 at start on the repo's test reads. |
| polap_seeds | Not completed | Needs the Flye graph and gene annotation table made by assemble1 and annotate in the same output folder, which fail in this image (no conda environment). |

## polap_assemble

### Tool Description
Assemble plant organelle-genome sequences from ONT long reads: miniasm seed contigs, Flye assembly, Oatk pathfinder extraction and polishing with Racon, fmlrc2 and polypolish.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-12-21
- **GitHub**: https://github.com/goshng/polap
- **Stars**: N/A
### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap assemble - assemble plant organelle-genome sequences using ONT long-read data

Synopsis:
  polap assemble [options]

Description:
  polap assemble subcommand uses minimap2 and miniasm to generate seed contigs,
which are fed into Flye to finalize the assembly. It also uses Oatk's pathfinder
to extract organelle genome sequences, which are polished using Racon, fmlrc2, and
polypolish.

Options:
  -l FASTQ
    reads data file
	
  -a FASTQ
    short-read data file 1

  -b FASTQ
    short-read data file 2

  -o OUTDIR
    output folder

  -o, --outdir: output folder name (default: ${_arg_outdir})
    The option '-o' or '--outdir' specifies the output folder name, 
    with a default value of 'o'. The output folder typically contains input 
    files that are long-read and short-read data files. Input data files can 
    be specified using the options provided by -l, -a, and -b.

  -l, --long-reads: long-reads data file in fastq format (default: ${_arg_long_reads})
    The option '-l' or '--long-reads' specifies the location of a long-reads 
    data file in fastq format, with a default filename of 'l.fq'.

  -a, --short-read1: short-read fastq file 1 (default: ${_arg_short_read1})
    The option '-a' or '--short-read1' specifies the first short-read fastq 
    file to be used, with a default value of "s1.fq".

  -b, --short-read2: short-read fastq file 2 (default: ${_arg_short_read2})
    The option '-b' or '--short-read2' specifies a short-read fastq file 2, 
    with a default value of 's2.fq'. The second short-read data file, 
    if provided, is considered optional.
    (Note: not tested yet; -a & -b are required.)

Outputs:
  ${_polap_var_ga_contigger_edges_stats}

Examples:
  Get organelle genome sequences:
    polap assemble -l l.fq -a s1.fq -b s2.fq -o outdir --prefix t1
    Check t1.pt.gfa, t1.mt.gfa, t1.pt.fa, and t1.mt.fa

See also:
  version

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)

Author:
  Sang Chul Choi
```


## polap_assemble1

### Tool Description
Assemble whole-genome sequences with Flye (first step of the polap organelle assembly).

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap assemble1 - assemble whole-genome sequences

Synopsis:
  polap assemble1 [options]

Description:
  polap assemble1 runs the whole-genome assembly using Flye. 

Options:
  -l FASTQ
    reads data file [default: ${_arg_long_reads}]
  
  -a FASTQ
    short-read data file 1 [default: ${_arg_short_read1}]

  -b FASTQ
    short-read data file 2 [default: ${_arg_short_read2}]

  -o OUTDIR
    output folder [default: ${_arg_outdir}]

  -m INT
    minimum read length [default: ${_arg_min_read_length}]

  -t INT
    the number of CPU cores [default: ${_arg_threads}]

  -c INT
    the coverage option [default: ${_arg_coverage}]

  -g <arg>
    computed by find-genome-size polap command or given by users

  --reduction-reads [default: ${_arg_reduction_reads}]
    data reduction in a whole-genome assembly

  --redo [default: ${_arg_redo}]
    do not use previously generated intermediate results

  --stopafter {data,flye1} [default: ${_arg_stopafter}]
    stop after data or flye1 step

Outputs:
  ${_polap_var_outdir_s1_fq_stats}

  ${_polap_var_outdir_s2_fq_stats}

  ${_polap_var_outdir_long_total_length}

  ${_polap_var_outdir_genome_size}

  ${_polap_var_outdir_nk_fq_gz}

  ${_polap_var_outdir_lk_fq_gz}

  ${_polap_var_wga_contigger_edges_gfa}

  ${_polap_var_ga_contigger_edges_stats}

Examples:
  Get organelle genome sequences:
    polap assemble -l l.fq -a s1.fq -b s2.fq -o outdir

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)

Author:
  Sang Chul Choi
```


## polap_assemble2

### Tool Description
Assemble an organelle genome with Flye from seed contigs selected in a previous whole-genome assembly (output folder of assemble1 and seeds).

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap assemble2 - assemble organelle genome sequences

Synopsis:
  polap assemble2 [options]

Description:
  polap assemble2 runs the organelle-genome assembly using Flye. 

Options:
  -i INT
    index of the source of an organelle-genome assembly [default: ${_arg_inum}]
  
  -j INT
    index of the target organelle-genome assembly [default: ${_arg_jnum}]
  
  -w INT
    minimum mapping length for read selection [default: ${_arg_single_min}]

  -c INT
    the coverage option [default: ${_arg_coverage}]

  -t INT
    the number of CPU cores [default: ${_arg_threads}]

  --polap-reads [default: ${_arg_polap_reads}]
    uses the POLAP read selection not ptGAUL's

  --coverage-check [default: ${_arg_coverage_check}]

  --no-coverage-check: no data reduction in an organelle-genome assembly

  -l FASTQ
    reads data file [default: ${_arg_long_reads}]
  
  -o OUTDIR
    output folder [default: ${_arg_outdir}]

  -m INT
    minimum read length [default: ${_arg_min_read_length}]

Inputs:
  ${_polap_var_mtcontigname}

  ${_polap_var_ga_contigger_edges_fasta}

  ${_polap_var_ga_contigger_edges_gfa} 

  if no such file: ${_polap_var_ga_contigger_edges_fasta}

Outputs:
  ${_polap_var_oga_assembly_graph_gfa}

Examples:
  Get organelle genome sequences using minimum mapping length 6000:
    polap assemble2 -l l.fq -o outdir -w 6000

  Get organelle genome sequences using seed contig index 0 and target organelle-genome assembly index 1:
    polap assemble2 -i 0 -j 1 -l l.fq -o outdir

  Get organelle genome sequences using polap read selection:
    polap assemble2 --polap-reads -l l.fq -o outdir

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)

Author:
  Sang Chul Choi
```


## polap_readassemble

### Tool Description
Annotate long reads with organelle genes and assemble the plastid or mitochondrial genome from the selected reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap readassemble - annotate reads before organelle genome assembly
Synopsis:
  polap readassemble [options]
Description:
  polap readassemble uses organelle genes to annotate reads before organelle genome assembly.
We have four-case workflows;
1) ptDNA from ONT: select plastid‑origin reads using protein‑to‑genome alignment (e.g., NCBI BLAST) and assemble with Flye v2.9.6. This leverages ONT read length to bridge repeats.
2) mtDNA from ONT: aggressively filter ptDNA/nuclear reads (e.g., protein markers; BUSCO to identify nuclear reads), bootstrap seed contigs with miniasm, then complete with Flye.
3) ptDNA from HiFi: either use the protein‑guided selection + Flye route (method 1) or a wrapper of Oatk with organelle gene–aware pathfinding.
4) mtDNA from HiFi: a wrapper of Oatk is generally preferred although (method 2).
We assemble ptDNA first before mtDNA assembly.

Options:
  -l FASTQ
    long reads data file
  --plastid
    assembly mtDNA instead of mtDNA
  --animal
    assemble animal mtDNA
  --nano-raw [default]
  --pacbio-hifi
  --use-oatk
Examples:
  Assemble plant mitochondrial sequences from ONT l.fq to produce l.mt.gfa:
    polap readassemble -l l.fq

  Assemble plant mitochondrial sequences from HiFi l.fq to produce l.mt.gfa:
    polap readassemble -l l.fq --pacbio-hifi

  Assemble plastid sequences from ONT l.fq to produce l.pt.fa and l.pt.gfa:
    polap readassemble -l l.fq --plastid

  Assemble plastid sequences from HiFi l.fq to produce l.pt.fa and l.pt.gfa:
    polap readassemble -l l.fq --plastid

  Oatk assembles plastid sequences from HiFi l.fq to produce l.pt.fa and l.pt.gfa:
    polap readassemble -l l.fq --plastid --use-oatk

  Oatk assembles mitochondrial sequences from HiFi l.fq to produce l.pt.fa and l.pt.gfa:
    polap readassemble -l l.fq --use-oatk

  (not tested) Oatk assembles animal mitochondrial sequences from HiFi l.fq to produce l.pt.fa and l.pt.gfa:
    polap readassemble -l l.fq --animal --use-oatk

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)
Author:
  Sang Chul Choi
```


## polap_disassemble

### Tool Description
Assemble a plastid genome by subsampling long-read data without references (stages of subsampled Flye assemblies and short-read polishing).

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Plastid genome assembly by subsampling long-read data without references

Inputs
------

- long-read data: ${_arg_long_reads} (default: l.fq)
- short-read data 1: ${_arg_short_read1} (default: s1.fa)
- short-read data 2: ${_arg_short_read2} (default: s2.fa)

Main arguments
--------------

-l ${_arg_long_reads}: long-read fastq file
-a ${_arg_short_read1}: short-read fastq file 1
-b ${_arg_short_read2}: short-read fastq file 2

--downsample ${_arg_downsample}: maximum genome coverage to downsample
--disassemble-n ${_arg_disassemble_n}: the number of steps in stage 1
--disassemble-p ${_arg_disassemble_p}: the maximum percent of long-read data
--disassemble-r ${_arg_disassemble_r}: the number of replicates in stages 2/3

Two use cases:
1. case inference: default
2. case check: compare one selected from stage 2 (no alignment in stages 1 and 2)
  --disassemble-c and --disassemble-align-reference

For the cases inference or check we use use either short-read 
subsampling-based polishing or short-read no-subsampling (simple) polishing
  --simple-polishing on or off

Outputs
-------

- plastid genome assembly: ${_arg_outdir}/ptdna.${_arg_inum}.fa

Arguments
---------

-o ${_arg_outdir}: output folder
-l ${_arg_long_reads}: a long-read fastq data file
-a ${_arg_short_read1}: a short-read fastq data file 1
-b ${_arg_short_read2}: a short-read fastq data file 2
-i ${_arg_inum}: output number creating folder: ${_arg_outdir}/${_arg_inum}
-t ${_arg_threads}: the number of CPU cores
--disassemble-i ${_arg_disassemble_i}: the index in disassemble any string
--downsample ${_arg_downsample}: maximum genome coverage to downsample
--disassemble-a ${_arg_disassemble_a}: int for base pairs or .float for rate the smallest base pairs for a subsampling range
--disassemble-b ${_arg_disassemble_b}: int for base pairs or .float for rate the largest base pairs for a subsampling range
--disassemble-p ${_arg_disassemble_p}: the percentile of the largest long read, -a/-b or -p
--disassemble-n ${_arg_disassemble_n}: the number of steps
--disassemble-m ${_arg_disassemble_m}: the upper bound for a Flye assembly
--disassemble-memory ${_arg_disassemble_memory}: the maximum memory in Gb
--disassemble-alpha ${_arg_disassemble_alpha}: the starting Flye's disjointig coverage
--disassemble-delta ${_arg_disassemble_delta}: the move size of alpha (0.1 - 1.0)
--disassemble-c <FASTA>: a single reference sequence in FASTA
--random-seed <arg>: 5-digit number or 0 for random seed
--disassemble-r ${_arg_disassemble_r}: the number of replicates

Menus
-----

- help: display this help message
- view: show some results
- downsample: delete output files 
- archive: archive output files leaving out too large files
- ptgaul: extract ptDNA from ${_arg_outdir}/ptgaul

Usages
------
$(basename "$0") ${_arg_menu[0]} -l ${_arg_long_reads}
$(basename "$0") ${_arg_menu[0]} -l ${_arg_long_reads} -a ${_arg_short_read1}
$(basename "$0") ${_arg_menu[0]} -l ${_arg_long_reads} -a ${_arg_short_read1} -b ${_arg_short_read2}

Examples
--------
$(basename "$0") ${_arg_menu[0]} example <NUMBER>

NUMBER=1
--------
$(basename "$0") x-ncbi-fetch-sra --sra SRR7153095
$(basename "$0") x-ncbi-fetch-sra --sra SRR7161123

NUMBER=2
--------
cp -s SRR7153095.fastq l.fq
cp -s SRR7161123_1.fastq s1.fq
cp -s SRR7161123_2.fastq s2.fq
$(basename "$0") disassemble

NUMBER=3
--------
$(basename "$0") get-mtdna --plastid --species "Eucalyptus pauciflora"
cp o/00-bioproject/2-mtdna.fasta o/ptdna-reference.fa

NUMBER=4
--------
$(basename "$0") disassemble --disassemble-i 1 --stages-include 3 \
  -l SRR7153095.fastq -a SRR7161123_1.fastq -b SRR7161123_2.fastq \
  --disassemble-align-reference --disassemble-c o/ptdna-reference.fa

NUMBER=5
--------
mkdir -p o/0/mafft
$(basename "$0") mafft-mtdna -a o/ptdna-reference.fa \
  -b o/0/disassemble/2/pt.subsample-polishing.reference.aligned.1.fa \
  -o o/0/mafft >o/0/mafft/log.txt
cat o/0/mafft/pident.txt

NUMBER=6
--------
$(basename "$0") disassemble --disassemble-i 2 \
  -l SRR7153095.fastq -a SRR7161123_1.fastq -b SRR7161123_2.fastq \
  --disassemble-align-reference --disassemble-c o/ptdna-reference.fa

NUMBER=7
--------
$(basename "$0") disassemble --disassemble-i 3 \
  -l SRR7153095.fastq -a SRR7161123_1.fastq -b SRR7161123_2.fastq \
  --disassemble-c o/ptdna-reference.fa
```


## polap_annotate

### Tool Description
Annotate a Flye genome assembly (contigger edges) in a polap output folder with mitochondrial and plastid genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Annotate a Flye genome assembly with organelle genes.

Arguments:
  -i ${_arg_inum}: a Flye genome assembly number
  --contigger (default: on)
  --no-contigger (not implemented yet!)

Inputs:
  ${_arg_inum}

Outputs:
  ${_polap_var_ga_annotation_all}
  ${_polap_var_ga_annotation}
  ${_polap_var_ga_annotation_depth_table}
  ${_polap_var_ga_annotation_table}
  ${_polap_var_ga_pt_annotation_depth_table}

View:
  all      -> ${_polap_var_ga_annotation_all}
  mt       -> ${_polap_var_ga_annotation}
  table    -> ${_polap_var_ga_annotation_depth_table}
  no-depth -> ${_polap_var_ga_annotation_table}
  seed     -> ${_polap_var_ga_annotation_depth_table_seed_target}
  pt-table -> ${_polap_var_ga_pt_annotation_depth_table}
  pt       -> ${_polap_var_ga_pt_annotation_depth_table}

Seed:
	create seed: ${_polap_var_mtcontigname}
  table or mt [default]
  pt or pt-table
  all

Example:
$(basename "$0") ${_arg_menu[0]} -i ${_arg_inum}
$(basename "$0") ${_arg_menu[0]} view table
$(basename "$0") ${_arg_menu[0]} view seed
$(basename "$0") ${_arg_menu[0]} view seed -o Spirodela_polyrhiza/o2 --table-format docx --outfile sp.docx
$(basename "$0") ${_arg_menu[0]} seed
```


## polap_seeds

### Tool Description
Select seed contigs for organelle-genome assembly from an annotated Flye genome assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap ${polap_cmd} - Select seed contigs for organelle-genome assembly

Synopsis:
  polap ${polap_cmd} [options]

Description:
  polap ${polap_cmd} selects seed contigs for organelle-genome assembly.

Options:
  -i INT
    index of the source of an organelle-genome assembly [default: ${_arg_inum}]
  
  -j INT
    index of the target organelle-genome assembly [default: ${_arg_jnum}]
	
  --plastid
		use plastid genes instead of mitochondrial genes [default: ${_arg_plastid}]
  
  -l FASTQ
    reads data file

Inputs:
  ${_polap_var_ga_contigger_edges_gfa}

  ${_polap_var_ga_annotation_all}

Outputs:
  ${_polap_var_mtcontigname} or more such files

Menus:
  bandage

  annotation

View:
  <number> for the mt.contig.name-<number>

Examples:
  Get organelle genome sequences:
    polap ${polap_cmd} -l l.fq

  Select contigs using seeds-graph:
    $(basename "$0") ${_arg_menu[0]} -i 0 -j 1

  Select contigs using seeds-graph:
    $(basename "$0") ${_arg_menu[0]} -i 0 -j 1 [--max-seeds ${_arg_max_seeds}]

  Select contigs using seeds-graph:
    $(basename "$0") ${_arg_menu[0]} view -i 0 -j 2

  Select contigs using seeds-graph:
    $(basename "$0") ${_arg_menu[0]} annotation

  Select contigs using seeds-graph:
    $(basename "$0") ${_arg_menu[0]} bandage

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)

Author:
  Sang Chul Choi
```


## polap_prepare-polishing

### Tool Description
Prepare short-read polishing with FMLRC (builds the short-read index used by polish).

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap prepare-polishing - prepares the polishing using FMLRC.

Synopsis:
  polap prepare-polishing [options]

Description:
  polap prepare-polishing uses FMLRC to prepare the polishing of sequences in FASTQ format using short-read data.

Options:
  -a FASTQ
    short-read data file 1 [default: ${_arg_short_read1}]

  -b FASTQ
    short-read data file 2 [default: ${_arg_short_read2}]

Examples:
  Prepare for short-read polishing:
    polap prepare-polishing -a s1.fq -b s2.fq -o outdir

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)

Author:
  Sang Chul Choi
```


## polap_polish

### Tool Description
Polish a draft organelle genome sequence in FASTA format with short-read (FMLRC) or long-read data.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
Help text taken from the polap source (polaplib/polap-cmd-*.sh): 'polap <command> help' fails in this image (mktemp: Invalid argument).

Name:
  polap ${polap_cmd} - polish a draft sequence

Synopsis:
  polap ${polap_cmd} [options]

Description:
  polap ${polap_cmd} uses either short-read data or long-read data to polish a draft genome assembly sequence in FASTA format.

Options:
  -p FASTA [default: ${_arg_unpolished_fasta}]
    draft genome assembly sequence file

  -f FASTA [default: ${_arg_final_assembly}]
    final genome assembly sequence file

  -l FASTQ
    reads data file

Examples:
  Get organelle genome sequences:
    polap ${polap_cmd} -a s1.fq -b s2.fq -p mt.0.fasta -f mt.1.fa

See Also:
  polap prepare-polishing - prepares the polishing using FMLRC.

Copyright:
  Copyright © 2025 Sang Chul Choi
  Free Software Foundation (2024-2025)

Author:
  Sang Chul Choi
```


## Metadata
- **Skill**: generated
