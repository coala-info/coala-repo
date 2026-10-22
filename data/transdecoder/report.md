# transdecoder CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| transdecoder_TransDecoder.LongOrfs | PASS |  |
| transdecoder_TransDecoder.Predict | PASS |  |
| transdecoder_cdna_alignment_orf_to_genome_orf | PASS |  |
| transdecoder_gff3_file_to_proteins | PASS |  |
| transdecoder_gtf_genome_to_cdna_fasta | PASS |  |
| transdecoder_gtf_to_alignment_gff3 | PASS |  |

## transdecoder_TransDecoder.Predict

### Tool Description
Predict likely coding regions among the long ORFs found by TransDecoder.LongOrfs.

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
#            /_/ /_/ \_,_/_//_/___/____/\__/\__/\___/\_,_/\__/_/   .Predict
#
########################################################################################
#
#  Transdecoder.LongOrfs|http://transdecoder.github.io> - Transcriptome Protein Prediction
#
#
#  Required:
#
#   -t <string>                            transcripts.fasta
#
#  Common options:
#
#
#   --retain_long_orfs_mode <string>        'dynamic' or 'strict' (default: dynamic)
#                                        In dynamic mode, sets range according to 1%FDR in random sequence of same GC content.
#
# 
#   --retain_long_orfs_length <int>         under 'strict' mode, retain all ORFs found that are equal or longer than these many nucleotides even if no other evidence 
#                                         marks it as coding (default: 1000000) so essentially turned off by default.)
#
#   --retain_pfam_hits <string>            domain table output file from running hmmscan to search Pfam (see transdecoder.github.io for info)     
#                                        Any ORF with a pfam domain hit will be retained in the final output.
# 
#   --retain_blastp_hits <string>          blastp output in '-outfmt 6' format.
#                                        Any ORF with a blast match will be retained in the final output.
#
#   --single_best_only                     Retain only the single best orf per transcript (prioritized by homology then orf length)
#
#   --output_dir | -O  <string>            same output directory from the TransDecoder.LongOrfs
#
#   --no_refine_starts                     start refinement identifies potential start codons for 5' partial ORFs using a PWM, process on by default.
#
##  Advanced options
#
#    -T <int>                            Top longest ORFs to train Markov Model (hexamer stats) (default: 500)
#                                        Note, 10x this value are first selected for removing redundancies,
#                                        and then this -T value of longest ORFs are selected from the non-redundant set.
#  --version                           show version (5.7.1)
#
#   --genetic_code | -G <string>                            genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena, Candida, Acetabularia, ...)
#                                              Genetic Codes (derived from: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)
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
#
#########################################################################################
```

## transdecoder_gtf_genome_to_cdna_fasta

### Tool Description
Extract transcript (cDNA) sequences described in a GTF file from a genome FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/opt/transdecoder/util/gtf_genome_to_cdna_fasta.pl cufflinks.gtf genome.fasta
```

## transdecoder_gtf_to_alignment_gff3

### Tool Description
Convert a GTF file of transcript structures to GFF3 cDNA-to-genome alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/opt/transdecoder/util/gtf_to_alignment_gff3.pl cufflinks.gtf
```

## transdecoder_cdna_alignment_orf_to_genome_orf

### Tool Description
Convert ORF coordinates on transcripts into genome coordinates using the transcript alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

### Original Help Text
```text

usage: /usr/local/opt/transdecoder/util/cdna_alignment_orf_to_genome_orf.pl cdna_orfs.genes.gff3 cdna_genome.alignments.gff3 cdna.fasta [DEBUG]
```

## transdecoder_gff3_file_to_proteins

### Tool Description
Extract protein, CDS, cDNA or gene sequences for the features in a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

### Original Help Text
```text

####################################################
#
# Required:
#
#  --gff3 <string>          gff3 file
#
#  --fasta <string>         fasta file corresponding to gff3 file
#
##
#  Optional:
#
#  --seqType <string>        prot|CDS|cDNA|gene,  default=prot
#
#  --genetic_code  <string>   universal (default)
#                             Euplotes, Tetrahymena, Candida
#                             Acetabularia, Mitochondrial-Canonical
#                             Mitochondrial-Vertebrates, Mitochondrial-Arthropods
#                             Mitochondrial-Echinoderms, Mitochondrial-Molluscs
#                             Mitochondrial-Ascidians, Mitochondrial-Nematodes
#                             Mitochondrial-Platyhelminths,Mitochondrial-Yeasts
#                             Mitochondrial-Euascomycetes, Mitochondrial-Protozoans
#
###################################################
```

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
