# bcftools-liftover-plugin CWL Generation Report

## bcftools-liftover-plugin

### Tool Description
Lift over a VCF from one genome build to another.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools-liftover-plugin:1.22--hb66fcc3_0
- **Homepage**: https://github.com/freeseek/score
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools-liftover-plugin/overview
- **Validation**: PASS

### Original Help Text
```text
About: Lift over a VCF from one genome build to another. (version 2024-09-27 http://github.com/freeseek/score)
[ Genovese, G., et al. BCFtools/liftover: an accurate and comprehensive tool to convert genetic variants
across genome assemblies. Bioinformatics 40, Issue 2 (2024) http://doi.org/10.1093/bioinformatics/btae038 ]

Usage: bcftools +liftover [General Options] -- [Plugin Options]
Options:
   run "bcftools plugin" for a list of common options

Plugin options:
   -s, --src-fasta-ref <file>      source reference sequence in fasta format
   -f, --fasta-ref <file>          destination reference sequence in fasta format
       --set-cache-size <int>      select fasta cache size in bytes
   -c, --chain <file>              UCSC liftOver chain file
       --max-snp-gap <int>         maximum distance to merge contiguous blocks separated by same distance [1]
       --max-indel-inc <int>       maximum distance used to increase the size an indel during liftover [250]
       --lift-mt                   force liftover of MT/chrMT [automatically determined from contig lengths]
       --print-blocks <file>       output contiguous blocks used for the liftOver
       --no-left-align             do not attempt to left align indels after liftover
       --reject <file>             output variants that cannot be lifted over
   -O, --reject-type u|b|v|z[0-9]  u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
       --write-src                 write the source contig/position/alleles for lifted variants
       --write-fail                write whether the 5' and 3' anchors have failed to lift
       --write-nw                  write the Needleman-Wunsch alignments when required
       --write-reject              write the reason variants cannot be lifted over

Options for how to update INFO/FORMAT records:
       --fix-tags                  fix Number type for INFO/AC, INFO/AF, FORMAT/GP, and FORMAT/DS tags
       --flip-tag <string>         INFO annotation flag to record whether alleles are flipped [FLIP]
       --swap-tag <string>         INFO annotation to record when alleles are swapped [SWAP]
       --drop-tags <list>          tags to drop when alleles are swapped [.]
       --ac-tags <list>            AC-like tags (must be Number=A,Type=Integer/Float) [INFO/AC,FMT/AC]
       --af-tags <list>            AF-like tags (must be Number=A,Type=Float) [INFO/AF,FMT/AF,FMT/AP1,FMT/AP2]
       --ds-tags <list>            DS-like tags (must be Number=A,Type=Float) [FMT/DS]
       --gt-tags <list>            tags with integers like FORMAT/GT (must be Type=Integer) [INFO/ALLELE_A,INFO/ALLELE_B]
       --es-tags <list>            GWAS-VCF tags (must be Number=A) [FMT/EZ,FMT/ES,FMT/ED]

Examples:
      bcftools +liftover -Ou input.hg19.bcf -- -s hg19.fa -f hg38.fa \
        -c hg19ToHg38.over.chain.gz | bcftools sort -Ob -o output.hg38.bcf -W
      bcftools +liftover -Ou GRCh38_dbSNPv156.vcf.gz -- -s hg38.fa -f chm13v2.0.fa \
        -c hg38ToHs1.over.chain.gz | bcftools sort -Oz -o chm13v2.0_dbSNPv156.vcf.gz -W=tbi

To obtain liftover chain files:
      wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/hg19ToHg38.over.chain.gz
      wget http://ftp.ensembl.org/pub/assembly_mapping/homo_sapiens/GRCh37_to_GRCh38.chain.gz
      wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHs1.over.chain.gz
```
## Metadata
- **Skill**: generated
