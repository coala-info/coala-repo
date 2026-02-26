# star-fusion CWL Generation Report

## star-fusion_STAR-Fusion

### Tool Description
STAR-Fusion is a tool for detecting gene fusions from RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/star-fusion:1.15.1--hdfd78af_1
- **Homepage**: https://github.com/STAR-Fusion/STAR-Fusion
- **Package**: https://anaconda.org/channels/bioconda/packages/star-fusion/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/star-fusion/overview
- **Total Downloads**: 393.9K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/STAR-Fusion/STAR-Fusion
- **Stars**: N/A
### Original Help Text
```text
############################################################################################
#
#      _________________________ __________         ___________           .__
#     /   _____/\__    ___/  _  \\______   \        \_   _____/_ __  _____|__| ____   ____
#     \_____  \   |    | /  /_\  \|       _/  ______ |    __)|  |  \/  ___/  |/  _ \ /    \
#     /        \  |    |/    |    \    |   \ /_____/ |     \ |  |  /\___ \|  (  <_> )   |  \
#    /_______  /  |____|\____|__  /____|_  /         \___  / |____//____  >__|\____/|___|  /
#            \/                 \/       \/              \/             \/               \/
#
#
############################################################################################
#
#  Required:
#
#  To include running STAR:
#
#      --left_fq <string>                    left.fq file (or single.fq)
#
#      --right_fq <string>                   right.fq file  (actually optional, but highly recommended)
#

#  Or use output from earlier STAR run:
#
#      --chimeric_junction|J <string>        Chimeric.out.junction file
#
#
#    --genome_lib_dir <string>             directory containing genome lib (see http://STAR-Fusion.github.io)
#                                          (required to specify, unless env var CTAT_GENOME_LIB is set to it)
#                                          Easiest - get plug-n-play version from:
#                                            < https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/ >
#
#  Optional:
#
#    --CPU <int>                           number of threads for running STAR (default: 4)
#
#    --output_dir|O <string>               output directory  (default: STAR-Fusion_outdir)
#
#    --show_full_usage_info                provide full usage info.
#
#
#######################
#
#   Quick guide to running:
#
#       STAR-Fusion --left_fq reads_1.fq  --right_fq reads_2.fq --genome_lib_dir /path/to/ctat_genome_lib_build_dir
#
############################################################################################
```

