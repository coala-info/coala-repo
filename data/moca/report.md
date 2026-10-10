# moca CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| moca_find_motifs | Failed | image problem: the MEME suite (meme, fimo, centrimo) that this command runs is not installed in the image |
| moca_plot | Failed | image problem: LaTeX (latex) is missing from the image, so the plot step stops after the conservation scores are computed |

## moca_plot

### Tool Description
Create conservation plots

### Metadata
- **Docker Image**: quay.io/biocontainers/moca:0.4.3--py27_0
- **Homepage**: https://github.com/saketkc/moca
- **Package**: https://anaconda.org/channels/bioconda/packages/moca/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: moca plot [OPTIONS]

  Create conservation plots

Options:
  --meme-dir, --meme_dir TEXT     MEME output directory  [required]
  --centrimo-dir, --centrimo_dir TEXT
                                  Centrimo output directory  [required]
  --fimo-dir-sample, --fimo_dir_sample TEXT
                                  Sample fimo.txt  [required]
  --fimo-dir-control, --fimo_dir_control TEXT
                                  Control fimo.txt  [required]
  --name TEXT                     Plot title
  --flank-motif INTEGER           Length of sequence flanking motif
                                  [required]
  --motif INTEGER                 Motif number
  -o, --oc TEXT                   Output Directory  [required]
  -c, --configuration TEXT        Configuration file  [required]
  --show-progress                 Print progress
  -g, -gb, --genome-build TEXT    Key denoting genome build to use in
                                  configuration file  [required]
  -h, --help                      Show this message and exit.
```

## moca_find_motifs

### Tool Description
Search motifs and create conservation plots

### Metadata
- **Docker Image**: quay.io/biocontainers/moca:0.4.3--py27_0
- **Homepage**: https://github.com/saketkc/moca
- **Package**: https://anaconda.org/channels/bioconda/packages/moca/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: moca find_motifs [OPTIONS]

  Search motifs and create conservation plots

Options:
  -i, --bedfile TEXT              Bed file input  [required]
  -o, --oc TEXT                   Output Directory  [required]
  -c, --configuration TEXT        Configuration file  [required]
  -s, --slop-length, --slop_length INTEGER
                                  Flanking sequence length
  -f, --flank-motif, --flank_motif INTEGER
                                  Length of sequence flanking motif
  --n-motif INTEGER               Number of motifs
  -t, --cores INTEGER             Number of parallel MEME jobs  [required]
  -g, -gb, --genome-build TEXT    Key denoting genome build to use in
                                  configuration file  [required]
  --show-progress                 Print progress
  -h, --help                      Show this message and exit.
```

