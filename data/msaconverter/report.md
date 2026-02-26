# msaconverter CWL Generation Report

## msaconverter

### Tool Description
Convert multiple-sequence-alignment into different formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/msaconverter:0.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/linzhi2013/msaconverter
- **Package**: https://anaconda.org/channels/bioconda/packages/msaconverter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msaconverter/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linzhi2013/msaconverter
- **Stars**: N/A
### Original Help Text
```text
usage: msaconverter [-h] [-i <INFILE>] [-o <OUTFILE>]
                    [-p {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,phylip-sequential-relaxed,mauve,maf}]
                    [-q {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,phylip-sequential-relaxed,mauve,maf}]
                    [-t {DNA,RNA,protein}]

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.

**WHEN YOU ADAPT (PART OF) THE SOFTWARE FOR YOUR USE CASES, THE AUTHOR AND
THE SOFTWARE MUST BE EXPLICITLY CREDITED IN YOUR PUBLICATIONS AND SOFTWARE,
AND YOU SHOULD ASK THE USERS OF YOUR SOFTWARE TO CITE THE SOFTWARE IN
THEIR PUBLICATIONS. IN A WORD, 请讲武德.**

Convert multiple-sequence-alignment into different formats. 
See https://biopython.org/wiki/AlignIO for format introductions. 

V0.0.3:
phylip-sequential-relaxed (for output) is a custom format by MGL, which 
allows long sequence names but like phylip-sequential. 

By Guanliang MENG, available from https://github.com/linzhi2013/msaconverter.

options:
  -h, --help            show this help message and exit
  -i <INFILE>           input msa file
  -o <OUTFILE>          output msa file
  -p {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,phylip-sequential-relaxed,mauve,maf}
                        input msa format [fasta]
  -q {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,phylip-sequential-relaxed,mauve,maf}
                        input msa format [phylip-relaxed]
  -t {DNA,RNA,protein}  Molecule types [DNA]
```

