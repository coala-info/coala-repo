# plasmidcommunity CWL Generation Report

## plasmidcommunity_plasmidCommunity.sh

### Tool Description
Three modes are provided for analysis: silhouetteCurve, getCommunity and pan

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
- **Homepage**: https://github.com/wuxinmiao5/PlasmidCommunity
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidcommunity/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasmidcommunity/overview
- **Total Downloads**: 344
- **Last updated**: 2025-04-29
- **GitHub**: https://github.com/wuxinmiao5/PlasmidCommunity
- **Stars**: N/A
### Original Help Text
```text
Usage: plasmidCommunity.sh -h


Three modes are provided for analysis: silhouetteCurve, getCommunity and pan:
for silhouetteCurve mode: 
Usage: plasmidCommunity.sh -a silhouetteCurve -s input_plasmid_seq -o output_tag
-a|--input_Mode the mode chosen for analysis: silhouetteCurve, getCommunity or pan
-s|--input_plasmid_seq the path of a directory containing plasmids genomes
-o|--outputtag the output tag


for getCommunity mode: 
Usage: plasmidCommunity.sh -a getCommunity -c fastani -d discutoff -m membershipcutoff -o output_tag
-a|--input_Mode the mode chosen for analysis: silhouetteCurve, getCommunity or pan
-c|--fastani the fastani result for input, it's the result saved by silhouetteCurve
-d|--discutoff the distance cutoff to generate community
-m|--membershipcutoff the minimum of community size
-o|--outputtag the output tag


for pan mode: 
Usage: plasmidCommunity.sh -a pan -s input_plasmid_seq -f input_membership -m membershipcutoff -o output_tag
-a|--input_Mode the mode chosen for analysis: silhouetteCurve, getCommunity or pan
-s|--input_plasmid_seq the path of a directory containing plasmids genomes
-f|--input_membership the membership file of the network nodes
-m|--membershipcutoff the minimum of community size
-o|--outputtag the output tag
```

