# codan CWL Generation Report

## codan_codan.py

### Tool Description
CodAn: Coding Regions Annotator for transcripts using deep learning and BLAST.

### Metadata
- **Docker Image**: quay.io/biocontainers/codan:1.2--hdfd78af_1
- **Homepage**: https://github.com/pedronachtigall/CodAn
- **Package**: https://anaconda.org/channels/bioconda/packages/codan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/codan/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-11-07
- **GitHub**: https://github.com/pedronachtigall/CodAn
- **Stars**: N/A
### Original Help Text
```text
Usage: codan.py [options]

Options:
  -h, --help            show this help message and exit
  -t file, --transcripts=file
                        Mandatory - input transcripts file (FASTA format),
                        /path/to/transcripts.fa
  -m model, --model=model
                        Mandatory - path to model, /path/to/model
  -s string, --strand=string
                        Optional - strand of sequence to predict genes (plus,
                        minus or both) [default=plus]
  -c int, --cpu=int     Optional - number of threads to be used [default=1]
  -o folder, --output=folder
                        Optional - path to output folder,
                        /path/to/output/folder/ if not declared, it will be
                        created at the transcripts input folder
                        [default="CodAn_output"]
  -b proteinDB, --blastdb=proteinDB
                        Optional - path to blastDB of known protein sequences,
                        /path/to/blast/DB/DB_name
  -H int, --HSP=int     Optional - used in the "-qcov_hsp_perc" option of
                        blastx [default=80]
```


## codan_tops-viterbi_decoding

### Tool Description
ToPS Viterbi decoding tool

### Metadata
- **Docker Image**: quay.io/biocontainers/codan:1.2--hdfd78af_1
- **Homepage**: https://github.com/pedronachtigall/CodAn
- **Package**: https://anaconda.org/channels/bioconda/packages/codan/overview
- **Validation**: PASS

### Original Help Text
```text
tops-viterbi_decoding: ToPS version "master 00f9ed6"

error: unrecognised option '-help'
Allowed options:
  -h [ --help ]         produce help message
  -m [ --model ] arg    a decodable model
  -F [ --fasta ]        use fasta format
```

