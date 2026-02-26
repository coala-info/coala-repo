# mbg CWL Generation Report

## mbg_MBG

### Tool Description
MBG bioconda 1.0.17

### Metadata
- **Docker Image**: quay.io/biocontainers/mbg:1.0.17--h06902ac_0
- **Homepage**: https://github.com/maickrau/MBG
- **Package**: https://anaconda.org/channels/bioconda/packages/mbg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mbg/overview
- **Total Downloads**: 44.5K
- **Last updated**: 2025-06-12
- **GitHub**: https://github.com/maickrau/MBG
- **Stars**: N/A
### Original Help Text
```text
MBG bioconda 1.0.17

Usage:
  MBG [OPTION...]

  -h, --help                    Print help
  -v, --version                 Print version
  -i, --in arg                  Input reads. Multiple files can be input with
                                -i file1.fa -i file2.fa etc (required)
  -o, --out arg                 Output graph (required)
  -t arg                        Number of threads (default: 1)
  -k arg                        K-mer size. Must be odd and >=31 (required)
  -w arg                        Window size. Must be 1 <= w <= k-30 (default:
                                k-30)
  -a, --kmer-abundance arg      Minimum k-mer abundance (default: 1)
  -u, --unitig-abundance arg    Minimum average unitig abundance (default: 2)
      --error-masking arg       Error masking (default: hpc)
      --blunt                   Output a bluntified graph without edge
                                overlaps
      --include-end-kmers       Force k-mers at read ends to be included
      --output-sequence-paths arg
                                Output the paths of the input sequences to a
                                file (.gaf)
  -r, --resolve-maxk arg        Maximum k-mer size for multiplex DBG
                                resolution
  -R, --resolve-maxk-allowgaps arg
                                Allow multiplex resolution to add gaps up to
                                this k-mer size
      --node-name-prefix arg    Add a prefix to output node names
      --sequence-cache-file arg
                                Use a temporary sequence cache file to speed
                                up graph construction
      --keep-gaps               Don't remove low coverage nodes if it would
                                leave a gap in the graph
      --hpc-variant-onecopy-coverage arg
                                Separate k-mers based on hpc variants, using
                                arg as single copy coverage
      --do-unsafe-guesswork-resolutions
                                Use extra heuristics during multiplex
                                resolution
      --copycount-filter-heuristic
                                Use coverage based heuristic filter during
                                multiplex resolution
      --only-local-resolve      Only resolve nodes which are repetitive
                                within a read
      --output-homology-map arg
                                Output a list of homologous k-mer locations
      --no-kmer-filter-inside-unitig
                                Don't filter out k-mers which are completely
                                contained by two other k-mers
      --no-multiplex-cleaning   Don't clean low coverage tips and structures
                                during multiplex resolution
      --keep-sequence-name-tags
                                Keep tags in input sequence names
      --resolve-palindromes-global
                                Resolve palindromic nodes even if their
                                length is above the local resolution length
Options for --error-masking:
	no	No error masking
	hpc	Mask homopolymer errors (default)
	dinuc	Mask homopolymer and dinucleotide errors
	msat	Mask homopolymer and microsatellite errors up to 6bp
	collapse	Collapse homopolymers
	collapse-dinuc	Collapse homopolymers and mask dinucleotide errors
	collapse-msat	Collapse homopolymers and mask microsatellite errors up to 6bp
```

