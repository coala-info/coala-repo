# yleaf-pipelines CWL Generation Report

## yleaf-pipelines_Yleaf

### Tool Description
software tool for human Y-chromosomal phylogenetic analysis and haplogroup inference v3.3.0

### Metadata
- **Docker Image**: quay.io/biocontainers/yleaf-pipelines:3.3.0--pyh7e72e81_0
- **Homepage**: https://github.com/trianglegrrl/Yleaf-pipelines
- **Package**: https://anaconda.org/channels/bioconda/packages/yleaf-pipelines/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yleaf-pipelines/overview
- **Total Downloads**: 158
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/trianglegrrl/Yleaf-pipelines
- **Stars**: N/A
### Original Help Text
```text
Erasmus MC Department of Genetic Identification
Yleaf: software tool for human Y-chromosomal phylogenetic analysis and haplogroup inference v3.3.0


                   |
                  /|\          
                 /\|/\    
                \\\|///   
                 \\|//  
                  |||   
                  |||    
                  |||    

        
usage: Yleaf [-h] [-fastq PATH] [-bam PATH] [-cram PATH] [-cr PATH]
             [-vcf PATH] [-ra] [-force] -rg {hg19,hg38} [-fg PATH] [-yr PATH]
             -o STRING [-r INT] [-q INT] [-b INT] [-t INT] [-pq FLOAT] [-old]
             [-dh] [-hc] [-aDNA] [-p] [-maf FLOAT]

optional arguments:
  -h, --help            show this help message and exit
  -fastq PATH, --fastq PATH
                        Use raw FastQ files
  -bam PATH, --bamfile PATH
                        input BAM file
  -cram PATH, --cramfile PATH
                        input CRAM file
  -cr PATH, --cram_reference PATH
                        Reference genome for the CRAM file. Required when
                        using CRAM files.
  -vcf PATH, --vcffile PATH
                        input VCF file (.vcf.gz)
  -ra, --reanalyze      reanalyze (skip filtering and splitting) the vcf file
  -force, --force       Delete files without asking
  -rg {hg19,hg38}, --reference_genome {hg19,hg38}
                        The reference genome build to be used. If no reference
                        is available they will be downloaded. If you added
                        references in your config.txt file these will be used
                        instead as reference or the location will be used to
                        download the reference if those files are missing or
                        empty.
  -fg PATH, --full_genome_reference PATH
                        Custom full genome reference fasta file (.fa, .fasta,
                        or .fna)
  -yr PATH, --y_chromosome_reference PATH
                        Custom Y chromosome reference fasta file (.fa, .fasta,
                        or .fna)
  -o STRING, --output STRING
                        Folder name containing outputs
  -r INT, --reads_treshold INT
                        The minimum number of reads for each base.
                        (default=10)
  -q INT, --quality_thresh INT
                        Minimum quality for each read, integer between 10 and
                        40. [10-40] (default=20)
  -b INT, --base_majority INT
                        The minimum percentage of a base result for
                        acceptance, integer between 50 and 99. [50-99]
                        (default=90)
  -t INT, --threads INT
                        The number of processes to use when running Yleaf.
  -pq FLOAT, --prediction_quality FLOAT
                        The minimum quality of the prediction (QC-scores) for
                        it to be accepted. [0-1] (default=0.95)
  -old, --use_old       Add this value if you want to use the old prediction
                        method of Yleaf (version 2.3). This version only uses
                        the ISOGG tree and slightly different prediction
                        criteria.
  -dh, --draw_haplogroups
                        Draw the predicted haplogroups in the haplogroup tree.
  -hc, --collapsed_draw_mode
                        Add this flag to compress the haplogroup tree image
                        and remove all uninformative haplogroups from it.
  -aDNA, --ancient_DNA  Add this flag if the sample is ancient DNA. This will
                        ignore all G > A and C > T mutations.
  -p, --private_mutations
                        Add this flag to search for private mutations. These
                        are variations that are not considered in the
                        phylogenetic tree and thus not used for haplogroup
                        prediction, however can be informative and
                        differentiate individuals within the same haplogroup
                        prediction.
  -maf FLOAT, --minor_allele_frequency FLOAT
                        Maximum rate of minor allele for it to be considered
                        as a private mutation. (default=0.01)
```

