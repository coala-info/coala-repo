# ir CWL Generation Report

## ir

### Tool Description
calculate the index of repetitiveness, I_r

### Metadata
- **Docker Image**: quay.io/biocontainers/ir:2.8.0--h7b50bb2_8
- **Homepage**: http://guanine.evolbio.mpg.de/cgi-bin/ir/ir.cgi.pl
- **Package**: https://anaconda.org/channels/bioconda/packages/ir/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ir/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-08-10
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# unknown argument: -
ir version 2.8.0, copyright (c) 2006-2008 Bernhard Haubold & Thomas Wiehe
	distributed under the GNU General Public License.
purpose: calculate the index of repetitiveness, I_r
usage: ir [options]
options:
	[-i <FILE> read query sequence(s) from FILE; default: FILE=stdin]
	[-j <FILE> read sbjct sequence(s) from FILE; default: analyse only query]
	[-o <FILE> write output to FILE; default: FILE=stdout]
	[-w <NUM> sliding window of width NUM; default: no sliding window]
	[-f <NUM> filter private regions of minimum length NUM; default: no filter]
	[-c <NUM> increment sliding window by NUM positions; default: window_width/10]
	[-n <NUM> print NUM characters of header; all if NUM<0; default: NUM=30]
	[-r <NUM> compute Ae by randomizing sbjct NUM times; NUM=0 for analytical computation (fast)
		default: NUM=floor(pow(10,4.99999999-log(seq->numSbjctNuc/2)/log(10)))+1]
	[-S <NUM> NUM is seed of random number generator; default: seed from file or clock]
	[-P <NUM> proportion of random shustrings considered; default:  1]
	[-D <NUM> maximum depth of suffix tree; default: 1000000]
	[-s treat each sequence (query & sbjct) separately; default: union(query)/union(sbjct)]
	[-u unnormalize Ir; default: normalized Ir]
	[-I compare sequences with identical headers when using -s (slow); default: assume ir=1]
	[-p print information about program]
	[-h print this help message]
	[-d print debugging messages (use in conjunction with grep)]
```


## Metadata
- **Skill**: generated
