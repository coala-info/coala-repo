# teloscope CWL Generation Report

## teloscope

### Tool Description
teloscope [commands]

### Metadata
- **Docker Image**: quay.io/biocontainers/teloscope:0.1.3--h35c04b2_0
- **Homepage**: https://github.com/vgl-hub/teloscope
- **Package**: https://anaconda.org/channels/bioconda/packages/teloscope/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/teloscope/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/vgl-hub/teloscope
- **Stars**: N/A
### Original Help Text
```text
teloscope [commands]

Required Parameters:
	'-f'	--input-sequence	Initiate tool with fasta file.
	'-o'	--output	Set output route. [Default: Input path]
	'-c'	--canonical	Set canonical pattern. [Default: TTAGGG]
	'-p'	--patterns	Set patterns to explore, separate them by commas [Default: TTAGGG]
	'-j'	--threads	Set maximum number of threads. [Default: max. available]
	'-t'	--terminal-limit	Set terminal limit for exploring telomere variant regions (TVRs). [Default: 50000]
	'-k'	--max-match-distance	Set maximum distance for merging matches. [Default: 50]
	'-d'	--max-block-distance	Set maximum block distance for extension. [Default: 200]
	'-l'	--min-block-length	Set minimum block length. [Default: 500]
	'-y'	--min-block-density	Set minimum block density. [Default: 0.5]
	'-x'	--edit-distance	Set edit distance for pattern matching (0-2). [Default: 0]

Optional Parameters:
	'-w'	--window	Set sliding window size. [Default: 1000]
	'-s'	--step	Set sliding window step. [Default: 500]
	'-r'	--out-win-repeats	Output canonical/noncanonical repeats and density by window. [Default: false]
	'-g'	--out-gc	Output GC content for each window. [Default: false]
	'-e'	--out-entropy	Output Shannon entropy for each window. [Default: false]
	'-m'	--out-matches	Output all canonical and terminal non-canonical matches. [Default: false]
	'-i'	--out-its	Output assembly interstitial telomere (ITSs) regions.[Default: false] 
	'-u'	--ultra-fast	Ultra-fast mode. Only scans terminal telomeres at contig ends. [Default: true]
	'-v'	--version	Print current software version.
	'-h'	--help	Print current software options.
	--verbose	Verbose output.
	--cmd	Print command line.
```

