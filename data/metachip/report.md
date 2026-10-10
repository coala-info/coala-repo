# metachip CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metachip_BP | Not completed | needs the PI working folder and PI fails in this image (Biopython 1.77) |
| metachip_PI | Failed | image problem: Biopython 1.77 in the image is too old; gene prediction crashes with 'Need a Nucleotide or Protein alphabet' |
| metachip_filter_HGT | PASS | synthetic data: hand-made multi-level HGT table; two of three rows kept at n=2 with matching recipient sequences |
| metachip_get_SCG_tree | PASS |  |
| metachip_rename_seqs | PASS |  |
| metachip_update_hmms | Not completed | needs the full Pfam-A and TIGRFAMs databases (several GB) |

## metachip_PI

### Tool Description
Prepare input files

### Metadata
- **Docker Image**: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
- **Homepage**: https://github.com/songweizhi/MetaCHIP
- **Package**: https://anaconda.org/channels/bioconda/packages/metachip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MetaCHIP PI [-h] -i I [-taxon TAXON] [-o O] -p P [-r R] [-g G] [-x X]
                   [-nonmeta] [-t T] [-quiet] [-force] [-noblast]

Prepare input files

optional arguments:
  -h, --help    show this help message and exit
  -i I          input genome folder
  -taxon TAXON  taxonomic classification of input genomes
  -o O          output folder (default: current working directory)
  -p P          output prefix
  -r R          grouping rank, choose from p, c, o, f and g or any combination
                of them
  -g G          grouping file
  -x X          file extension
  -nonmeta      provide if input genomes are NOT metagenome-assembled genomes
  -t T          number of threads, default: 1
  -quiet        not report progress
  -force        force overwrite existing results
  -noblast      skip running all-vs-all blastn, provide if you have other ways
                (e.g. with job scripts) to speed up the blastn step

Example: MetaCHIP PI -h
```

## metachip_BP

### Tool Description
BM and PG approach

### Metadata
- **Docker Image**: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
- **Homepage**: https://github.com/songweizhi/MetaCHIP
- **Package**: https://anaconda.org/channels/bioconda/packages/metachip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MetaCHIP BP [-h] [-o O] -p P [-r R] [-g G] [-cov COV] [-al AL]
                   [-flk FLK] [-pfr] [-ip IP] [-ei EI] [-t T] [-NoEbCheck]
                   [-force] [-quiet] [-tmp]

BM and PG approach

optional arguments:
  -h, --help  show this help message and exit
  -o O        output folder (default: current working directory)
  -p P        output prefix
  -r R        grouping rank
  -g G        grouping file
  -cov COV    coverage cutoff, default: 75
  -al AL      alignment length cutoff, default: 200
  -flk FLK    the length of flanking sequences to plot (Kbp), default: 10
  -pfr        plot flanking_regions of identified HGTs
  -ip IP      identity percentile cutoff, default: 90
  -ei EI      end match identity cutoff, default: 80
  -t T        number of threads, default: 1
  -NoEbCheck  disable end break and contig match check for fast processing,
              not recommend for metagenome-assembled genomes (MAGs)
  -force      overwrite previous results
  -quiet      Do not report progress
  -tmp        keep temporary files

Example: MetaCHIP BP -h
```

## metachip_filter_HGT

### Tool Description
Get HGTs detected at least n levels

### Metadata
- **Docker Image**: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
- **Homepage**: https://github.com/songweizhi/MetaCHIP
- **Package**: https://anaconda.org/channels/bioconda/packages/metachip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
====================================== filter_HGT example commands ======================================

# get HGTs detected at at least TWO levels
MetaCHIP filter_HGT -i NorthSea_pcofg_detected_HGTs.txt -n 2

# get HGTs detected at at least THREE levels and copy their flanking region plots into a new folder
MetaCHIP filter_HGT -i NorthSea_pcofg_detected_HGTs.txt -n 3 -plot NorthSea_pcofg_Flanking_region_plots

=========================================================================================================

get HGTs detected at least n levels

optional arguments:
  -h, --help  show this help message and exit
  -i I        txt file containing detected HGTs, e.g.
              [prefix]_[ranks]_detected_HGTs.txt
  -n N        HGTs detected at least n levels, 2 <= n <= 5
  -plot PLOT  flanking plots folder
  -ffn FFN    get nucleotide sequences for qualified HGTs
  -faa FAA    get amino acid sequences for qualified HGTs
```

## metachip_update_hmms

### Tool Description
Update hmm profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
- **Homepage**: https://github.com/songweizhi/MetaCHIP
- **Package**: https://anaconda.org/channels/bioconda/packages/metachip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
====================================== update_hmms example commands ====================================

# Download Pfam DB file (e.g. v32.0)
wget ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam32.0/Pfam-A.hmm.gz
gunzip Pfam-A.hmm.gz

# Download TIGRFAM DB folder (e.g. v14.0)
wget ftp://ftp.jcvi.org/pub/data/TIGRFAMs/14.0_Release/TIGRFAMs_14.0_HMM.tar.gz
tar -xzvf TIGRFAMs_14.0_HMM.tar.gz

MetaCHIP update_hmms -hmm MetaCHIP_phylo.hmm -p_db Pfam-A.hmm -t_db TIGRFAMs_14.0_HMM

========================================================================================================

update hmm profiles

optional arguments:
  -h, --help  show this help message and exit
  -hmm HMM    MetaCHIP_phylo.hmm file
  -p_db P_DB  Pfam db file, e.g. Pfam-A.hmm
  -t_db T_DB  TIGRFAMs db folder, e.g. TIGRFAMs_14.0_HMM
```

## metachip_get_SCG_tree

### Tool Description
Get SCG tree

### Metadata
- **Docker Image**: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
- **Homepage**: https://github.com/songweizhi/MetaCHIP
- **Package**: https://anaconda.org/channels/bioconda/packages/metachip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
===================================== get SCG tree example commands =====================================

# for completed genome
MetaCHIP get_SCG_tree -i genomes -p NorthSea -x fasta -t 4 -nonmeta

# for metagenome-assembled genomes (MAGs) 
MetaCHIP get_SCG_tree -i genomes -p NorthSea -x fasta -t 4

# Software dependencies:
Prodigal, HMMER, Mafft and FastTree

=========================================================================================================

get SCG tree

optional arguments:
  -h, --help  show this help message and exit
  -i I        input genome folder
  -p P        output prefix
  -x X        file extension
  -nonmeta    annotate Non-metagenome-assembled genomes (Non-MAGs)
  -t T        number of threads, default: 1
```

## metachip_rename_seqs

### Tool Description
Rename sequences in a file

### Metadata
- **Docker Image**: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
- **Homepage**: https://github.com/songweizhi/MetaCHIP
- **Package**: https://anaconda.org/channels/bioconda/packages/metachip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
========================= rename_seqs example commands =========================

# rename sequences according to the file name by incrementally adding 1 to suffix
MetaCHIP rename_seqs -inc_suffix -in Contigs.fa
MetaCHIP rename_seqs -inc_suffix -in bin_folder -x fa

# rename "NODE_941_length_17600_cov_52.7123" to "NODE_941"
MetaCHIP rename_seqs -in Contigs.fa -sep_in "_" -n 2

# rename "Seawater|NODE|941|length|17600|cov|52.7123" to "Seawater_NODE_941"
MetaCHIP rename_seqs -in Contigs.fa -sep_in "|" -sep_out "_" -n 3

# add prefix to all sequences in a fasta file
MetaCHIP rename_seqs -in Contigs.fa -prefix seawater

# rename "NODE_941_length_17600_cov_52.7123" to "Seawater_NODE_941"
MetaCHIP rename_seqs -in Contigs.fa -sep_in "_" -n 2 -prefix Seawater

===============================================================================

rename sequences in a file

optional arguments:
  -h, --help        show this help message and exit
  -in IN            input sequence file
  -inc_suffix       rename sequences by incrementally adding suffix to file
                    name
  -sep_in SEP_IN    separator for input sequences
  -sep_out SEP_OUT  separator for output sequences, default: same as sep_in
  -n N              the number of columns to keep
  -prefix PREFIX    add prefix to sequence
  -x X              file extension
```

