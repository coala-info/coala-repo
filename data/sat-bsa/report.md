# sat-bsa CWL Generation Report

## sat-bsa_Sat-BSA

### Tool Description
Sat-BSA is a package used for applying local de novo assembly and identifying the structural variants in the assembled contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
- **Homepage**: https://github.com/SegawaTenta/Sat-BSA
- **Package**: https://anaconda.org/channels/bioconda/packages/sat-bsa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sat-bsa/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SegawaTenta/Sat-BSA
- **Stars**: N/A
### Original Help Text
```text
oooo                        ooooooo      oooo      oo    
   o   oo                       oo    oo    o   oo     oo    
  oo                 o          oo    oo   oo          ooo   
  oo                 o          oo    oo   oo         oo o   
  ooo       oooo   ooooo        oo    oo   ooo        o  o   
   oooo    oo   o    o          ooooooo     oooo     oo  oo  
     oooo       o    o    oooo  oo    oo      oooo   o    o  
       oo    ooooo   o          oo     o        oo   ooooooo 
        oo oo   oo   o          oo     oo        oo oo    oo 
        oo o    oo   o          oo     o         oo o      o 
  oo   oo  oo  ooo   o          oo    oo   oo   oo oo      oo
   ooooo    oooooo   ooo        ooooooo     ooooo  oo      oo


  Description:
  This is Sat-BSA version 1.12.
  Sat-BSA is a package used for applying local de novo assembly and identifying the structural variants in the assembled contigs.

Usage:
  Sat-BSA -w command [Required arguments] [Additional options]

command : Local_reads_selection
  This command is applied for selecting long reads alined at target region.
  Required arguments:
    -c String     : Chromosome name for selecting the aligned reads.
    -s Int        : Start position for selecting the aligned reads.
    -e Int        : End position for selecting the aligned reads.
    -b Path       : Full path of bam_list.txt listing bam files (Input format 1).
    -f Path       : Full path of fa_list.txt listing fasta.gz files (Input format 2).
  Additional options:
    -t Int        : Thread number. Default=[1]

command : Local_de_novo_assembly
  This command is applied for selecting long reads alined at target region and assembling the selected long reads with Canu (https://github.com/marbl/canu).
  Required arguments:
    -c String     : Chromosome name for selecting the aligned reads.
    -s Int        : Start position for selecting the aligned reads.
    -e Int        : End position for selecting the aligned reads.
    -b Path       : Full path of bam_list.txt listing bam files (Input format 1).
    -f Path       : Full path of fa_list.txt listing fasta.gz files (Input format 2).
    -d Path       : Full path of Canu.
  Additional options:
    -g Int        : Genome size in Mb set in Canu.
    -r String     : Read status set in Canu. Default=[-nanopore-raw].

command : Long_reads_alignment
  This command is applied for aligning long reads with Minimap2.
  Required arguments:
    -f Path       : Full path of aligned_read_list.txt listing sequence reads applied to Minimap2 (Input format 3).
    -r Path       : Full path of fasta file used as reference.
  Additional options:
    -q Int        : The mapping quality value excluded from analysis. Default=[0]
    -t Int        : Thread number. Default=[1]
    -i ont or pb  : The used sequence reads type (Oxford Nanopore Technologies[ont] or PacBio[pb]).

command : SVs_detection
   This command is applied for identifying structural variants between samples by comparing the alignment depth of long reads in the contigs constructed by local de novo assembly.
  Required arguments:
    -g Path       : Full path of gtf file (Input format 4).
    -c Path       : Full path of samples.txt listing the compared samples (Input format 5).
    -r Path       : Full path of fasta files used as refarence genome.
  Additional options:
    -p Int        : Defining promoter size applied for identifying SVs. Default=[0]
    -t Int        : Thread number Default=[1]
    -v Int        : Threshold for P-value from Fishers exact test. Default=[0.05]
    -f Int        : The minimum length of insertion or deletion applied for analysis. Default=[5]

command : Graph
  This command is applied for drawing graph with the result from SVs_detections.
  Required arguments:
    -r Path       : Full path of result.txt which is an output from SVs_detection command.
    -c Path       : Full path of graph_data.txt listing the path to directory constructed by SVs_detection command and color used for the line of graph (Input format 6).
  Additional options:
    -t Int        : Thread number. Default=[1]
```

