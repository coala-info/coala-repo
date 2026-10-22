# tttrlib CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tttrlib_image_export | PASS | new CWL; real PicoQuant imaging file (beads.ptu) gives a 49x50 count image |
| tttrlib_trace_correlate | Failed | tool bug: the command passes method 'default' to the Correlator, which prints 'Correlation mode not recognized!' and every correlation value is zero |

## tttrlib_image_export

### Tool Description
Export image from LSM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
- **Homepage**: https://github.com/Fluorescence-Tools/tttrlib
- **Package**: https://anaconda.org/channels/bioconda/packages/tttrlib/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tttrlib image export [OPTIONS] INPUT

  Export image from LSM file

Options:
  -ch, --channels TEXT  List of routing channel numbers considered. Photons in
                        detection channels separated by commas
                        areintegrated/combined in groups. Groups are separated
                        by colons. The input "0,3:1,2" outputs two images
                        where photons of channel 0,3 and 1,2 are combined. By
                        default all photons of all channelsare combined.
  --help                Show this message and exit.
```

## tttrlib_trace_correlate

### Tool Description
Compute correlation.

### Metadata
- **Docker Image**: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
- **Homepage**: https://github.com/Fluorescence-Tools/tttrlib
- **Package**: https://anaconda.org/channels/bioconda/packages/tttrlib/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tttrlib trace correlate [OPTIONS] [INPUT]...

  Compute correlation

Options:
  -f, --fine BOOLEAN              Make fine correlation (with microtime)
                                  [default: False]
  -ch1, --correlation_channel_1 TEXT
                                  List of routing channel numbers considered
                                  in correlation channel 1, e.g. "0,1".
                                  [required]
  -ch2, --correlation_channel_2 TEXT
                                  List of routing channel numbers considered
                                  in correlation channel 2, e.g. "0,1". If no
                                  correlation channels are given routing
                                  channels of ch1 are used.
  -n_casc, --n_casc INTEGER       Multi tau correlation parameter, number of
                                  cascades).  [default: 25]
  -n_bins, --n_bins INTEGER       Multi tau correlation parameter, number of
                                  bins per cascade).  [default: 9]
  -c, --n_chunks INTEGER          Number of pieces the data is to be split
                                  into.  [default: 5]
  -j, --join BOOLEAN              If True files select by wildcard are
                                  lexically sorted and joined.  [default:
                                  False]
  -p, --do_plot BOOLEAN           If True plots to a svg file
  --help                          Show this message and exit.
```

## Metadata
- **Skill**: generated
