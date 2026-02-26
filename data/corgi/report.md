# corgi CWL Generation Report

## corgi

### Tool Description
Classify DNA sequences using a pretrained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/corgi:0.4.3--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/bio-corgi/
- **Package**: https://anaconda.org/channels/bioconda/packages/corgi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/corgi/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-06-02
- **GitHub**: https://github.com/rbturnbull/corgi
- **Stars**: N/A
### Original Help Text
```text
Usage: corgi [OPTIONS]

Options:
  --gpu / --no-gpu                Whether or not to use a GPU for processing
                                  if available.  \[default: gpu]
  --pretrained TEXT               The location (URL or filepath) of a
                                  pretrained model.
  --reload / --no-reload          Should the pretrained model be downloaded
                                  again if it is online and already present
                                  locally.  \[default: no-reload]
  --file PATH                     A fasta file with sequences to be
                                  classified.
  --max-seqs INTEGER
  --batch-size INTEGER            \[default: 1]
  --max-length INTEGER            \[default: 5000]
  --min-length INTEGER            \[default: 128]
  --output-dir PATH               A path to output the results as a CSV.
  --csv PATH                      A path to output the results as a CSV. If
                                  not given then a default name is chosen
                                  inside the output directory.
  --save-filtered / --no-save-filtered
                                  Whether or not to save the filtered
                                  sequences.  \[default: save-filtered]
  --threshold FLOAT               The threshold to use for filtering. If not
                                  given, then only the most likely category
                                  used for filtering.
  --help                          Show this message and exit.
```

