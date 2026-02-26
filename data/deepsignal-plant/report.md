# deepsignal-plant CWL Generation Report

## deepsignal-plant_deepsignal_plant

### Tool Description
deepsignal_plant detects base modifications from Nanopore reads of plants, which contains five modules:

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/deepsignal-plant
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/deepsignal-plant
- **Stars**: N/A
### Original Help Text
```text
usage: deepsignal_plant [-h] [-v]
                        {call_mods,call_freq,extract,train,denoise} ...

deepsignal_plant detects base modifications from Nanopore reads of plants, which contains five modules:
	deepsignal_plant call_mods: call modifications
	deepsignal_plant call_freq: call frequency of modifications at genome level
	deepsignal_plant extract: extract features from corrected (tombo) fast5s for training or testing
	deepsignal_plant train: train a model, need two independent datasets for training and validating
	deepsignal_plant denoise: denoise training samples by deep-learning, filter false positive samples (and false negative samples)

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show deepsignal-plant version and exit.

modules:
  {call_mods,call_freq,extract,train,denoise}
                        deepsignal_plant modules, use -h/--help for help
```

