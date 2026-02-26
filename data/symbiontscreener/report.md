# symbiontscreener CWL Generation Report

## symbiontscreener_sysc

### Tool Description
Symbiont Screener (SYSC) is a tool for analyzing microbial communities. It supports two main modes: strobemer mode (s40) and kmer mode (k21), with various actions for building, density analysis, clustering, and consensus clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Stars**: N/A
### Original Help Text
```text
#----------------------------------------
LOG : version           -- 1.0-0-0
LOG : release date      -- 2023/01/06
LOG : installation path -- /usr/local/bin 
#----------------------------------------
CMD : /usr/local/bin/sysc -help
Usage : ./sysc <action> [options]

Actions:
  +---------+-----------------------+-----------------------+
  |stage    | strobemer mode (s40)  | kmer mode (k21)       |
  +---------+-----------------------+-----------------------+
  |step01   | build_s40             | build_k21             |
  +---------+-----------------------+-----------------------+
  |step02.1 | density_s40           | density_k21           |
  |step02.2 | trio_result_s40       | trio_result_k21       |
  +---------+-----------------------+-----------------------+
  |step03.1 | cluster_s40           | cluster_k21           |
  |step03.2 | consensus_cluster_s40 | consensus_cluster_k21 |
  +---------+-----------------------+-----------------------+

Try sysc <action> -h to see detail usage for each action like: ./sysc build_s40 -h


The four available workflows of sysc :
  +--------------------------------------------------------------------------------+-------------------------------+
  |                                   Workflows                                    |     Example pipeline          |
  +---+------------------------------------------------------------------------+---+-------------------------------+
  |   | -> build_s40 -> density_s40 -> trio_result_s40 ----------------------> |   |  sysc_strobmer_mode.sh        |
  | S |                     |                                                  |   |                               |
  | T |                     +--------> cluster_s40 -> consensus_cluster_s40 -> | E |  sysc_strobmercluster_mode.sh |
  | A |                                                                        | N |                               |
  | R | -> build_k21 -> density_k21 -> trio_result_k21 ----------------------> | D |  sysc_kmer_mode.sh            |
  | T |                     |                                                  |   |                               |
  |   |                     +--------> cluster_k21 -> consensus_cluster_k21 -> |   |  sysc_kmercluster_mode.sh     |
  +---+------------------------------------------------------------------------+---+-------------------------------+

Please find example pipelines in easy-to-use_pipelines folder.
```

