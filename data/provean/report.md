# provean CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| provean | Not completed | Needs the huge NCBI nr protein database with gi numbers; on a small p53-family BLAST database PROVEAN found no supporting sequences and printed nan. CWL fixed (tool paths as strings, database index files, scores captured). |

## provean

### Tool Description
Protein Variation Effect Analyzer (PROVEAN) predicts the functional effect of amino acid substitutions and indels.

### Metadata
- **Docker Image**: quay.io/biocontainers/provean:1.1.5--h503566f_3
- **Homepage**: https://www.jcvi.org/research/provean
- **Package**: https://anaconda.org/channels/bioconda/packages/provean/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/provean/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE:		
  provean [Options]		

Options:		
  -q <string>		
  -d <string>		
  -v <string>		
  --psiblast <string>		
  --cdhit <string>		
  --blastdbcmd <string>		
  --quiet		
  --supporting_set <string>		
  --save_supporting_set <string>		
  --subject_sequences <string>		
  --num_threads <integer, >=1> (default=1)		
  --tmp_dir <string>
```

