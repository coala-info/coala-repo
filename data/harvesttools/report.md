# harvesttools CWL Generation Report

## harvesttools

### Tool Description
harvesttools version 1.3 options:

### Metadata
- **Docker Image**: quay.io/biocontainers/harvesttools:1.3--ha9fde67_0
- **Homepage**: https://github.com/marbl/harvest-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/harvesttools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/harvesttools/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/marbl/harvest-tools
- **Stars**: N/A
### Original Help Text
```text
harvesttools version 1.3 options:
   -i <Gingr input>
   -b <bed filter intervals>,<filter name>,"<description>"
   -B <output backbone intervals>
   -f <reference fasta>
   -F <reference fasta out>
   -g <reference genbank>
   -a <MAF alignment input>
   -m <multi-fasta alignment input>
   -M <multi-fasta alignment output (concatenated LCBs)>
   -I <multi-fasta alignment output (concatenated LCBs minus filtered SNPs)>
   -n <Newick tree input>
   -N <Newick tree output>
   --midpoint-reroot (reroot the tree at its midpoint after loading)
   -o <Gingr output>
   -S <output for multi-fasta SNPs>
   -u 0/1 (update the branch values to reflect genome length)
   -v <VCF input>
   -V <VCF output>
     --internal <track1>,<track2>,...  #only variants that differ among tracks
                                        listed
     --internal <track1>:<track2>      #only variants that differ within LCA
                                        clade of <track1> and <track2>
     --signature <track1>,<track2>,... #only signature variants of tracks listed
     --signature <track1>:<track2>     #only signature variants of LCA clade of
                                        <track1> and <track2>
   -x <xmfa alignment file>
   -X <output xmfa alignment file>
   -h (show this help)
   -q (quiet mode)
```


## Metadata
- **Skill**: generated
