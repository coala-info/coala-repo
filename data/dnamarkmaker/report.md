# dnamarkmaker CWL Generation Report

## dnamarkmaker_DNAMarkMaker

### Tool Description
DNAMarkMaker version 1.0

### Metadata
- **Docker Image**: quay.io/biocontainers/dnamarkmaker:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/SegawaTenta/DNAMarkMaker-CUI
- **Package**: https://anaconda.org/channels/bioconda/packages/dnamarkmaker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnamarkmaker/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SegawaTenta/DNAMarkMaker-CUI
- **Stars**: N/A
### Original Help Text
```text
usage: DNAMarkMaker -w <target_SNP_selection/ARMS_preparation/tri_ARMS/tetra_ARMS/CAPS>

DNAMarkMaker version 1.0

options:
  -h, --help            show this help message and exit
  -w {target_SNP_selection,CAPS,ARMS_preparation,tri_ARMS,tetra_ARMS}, --work {target_SNP_selection,CAPS,ARMS_preparation,tri_ARMS,tetra_ARMS}
                        Choose between target_SNP_selection, CAPS,
                        ARMS_preparation, tri_ARMS and tetra_ARMS
  -Abam ABAM, --Abam ABAM
                        Full path of A bam
  -Bbam BBAM, --Bbam BBAM
                        Full path of B bam
  -Cbam CBAM, --Cbam CBAM
                        Full path of C bam
  -Aname ANAME, --Aname ANAME
                        A name (A)
  -Bname BNAME, --Bname BNAME
                        B name (B)
  -Csim CSIM, --Csim CSIM
                        C simulation file
  -reference REFERENCE, --reference REFERENCE
                        Full path of reference fasta
  -position POSITION, --position POSITION
                        Target chromosome position [chr:start:end]
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory
  -min_depth MIN_DEPTH, --min_depth MIN_DEPTH
                        Minimum depth of target SNP (10)
  -max_depth MAX_DEPTH, --max_depth MAX_DEPTH
                        Maximum depth of target SNP (99)
  -Bhetero BHETERO, --Bhetero BHETERO
                        Whether to target heterozygous SNP in B (no)
  -Bsim BSIM, --Bsim BSIM
                        B simulation file
  -minMQ MINMQ, --minMQ MINMQ
                        Minimum mapping quality detected from bam (0)
  -minBQ MINBQ, --minBQ MINBQ
                        Minimum base quality detected from bam (13)
  -restriction_enzyme RESTRICTION_ENZYME, --restriction_enzyme RESTRICTION_ENZYME
                        Full path of restriction enzyme file
  -recipe RECIPE, --recipe RECIPE
                        Full path of primer recipe file
  -PCR_max_size PCR_MAX_SIZE, --PCR_max_size PCR_MAX_SIZE
                        Maximum size of PCR product (1000 or 700)
  -PCR_min_size PCR_MIN_SIZE, --PCR_min_size PCR_MIN_SIZE
                        Minimum size of PCR product (500 or 100)
  -fragment_min_size FRAGMENT_MIN_SIZE, --fragment_min_size FRAGMENT_MIN_SIZE
                        Minimum fragment size of restricted PCR product (200)
  -first_size FIRST_SIZE, --first_size FIRST_SIZE
                        Size of first band (100:500)
  -second_size SECOND_SIZE, --second_size SECOND_SIZE
                        Size of second band (600:1000)
  -SNP_dist SNP_DIST, --SNP_dist SNP_DIST
                        Target SNP distance (100:300)
  -make_html MAKE_HTML, --make_html MAKE_HTML
                        Whether to html file (yes)
```

