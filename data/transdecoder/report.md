# transdecoder CWL Generation Report

## Metadata
- **Skill**: generated

## transdecoder_TransDecoder.LongOrfs

### Tool Description
Transcriptome Protein Prediction - identify candidate open reading frames (ORFs) within transcripts

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

### Original Help Text
```text
########################################################################################
#             ______                 ___                  __
#            /_  __/______ ____ ___ / _ \___ _______  ___/ /__ ____
#             / / / __/ _ `/ _\(_-</ // / -_) __/ _ \/ _  / -_) __/
#            /_/ /_/ \_,_/_//_/___/____/\__/\__/\___/\_,_/\__/_/   .LongOrfs
#                                                       
########################################################################################
#
#  Transdecoder.LongOrfs|http://transdecoder.github.io> - Transcriptome Protein Prediction
#
#
#  Required:
#
#    -t <string>                            transcripts.fasta
#
#  Optional:
#
#   --gene_trans_map <string>              gene-to-transcript identifier mapping file (tab-delimited, gene_id<tab>trans_id<return> ) 
#
#   -m <int>                               minimum protein length (default: 100)
# 
#   -S                                     strand-specific (only analyzes top strand)
#
#   --output_dir | -O  <string>            path to intended output directory
#
#   --version                              show version tag (5.7.1)
#
#   --genetic_code | -G <string>                            genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena, Candida, Acetabularia)
#                                              Genetic Codes (derived from: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)#  
Acetabularia
Candida
Ciliate
Dasycladacean
Euplotid
Hexamita
Mesodinium
Mitochondrial-Ascidian
Mitochondrial-Chlorophycean
Mitochondrial-Echinoderm
Mitochondrial-Flatworm
Mitochondrial-Invertebrates
Mitochondrial-Protozoan
Mitochondrial-Pterobranchia
Mitochondrial-Scenedesmus_obliquus
Mitochondrial-Thraustochytrium
Mitochondrial-Trematode
Mitochondrial-Vertebrates
Mitochondrial-Yeast
Pachysolen_tannophilus
Peritrich
SR1_Gracilibacteria
Tetrahymena
Universal 
#
#   --complete_orfs_only                   yields only complete ORFs (peps start with Met (M), end with stop (*))
#
#########################################################################################
```
