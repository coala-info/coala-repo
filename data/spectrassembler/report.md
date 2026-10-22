# spectrassembler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| spectrassembler_gen_cons_from_poa | Failed | tool bug: --contig is read as text but later used with %d, so every run stops with a TypeError |
| spectrassembler_spectral_layout_from_minimap | PASS | New CWL; 138 real PacBio HiFi plastid reads gave a 127-read layout with POA windows (crashes on some inputs: duplicate overlaps early in the PAF file hit a list index bug) |

## spectrassembler_spectral_layout_from_minimap

### Tool Description
Compute a spectral layout of long reads from minimap overlaps (PAF) and write POA input files

### Metadata
- **Docker Image**: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
- **Homepage**: https://github.com/antrec/spectrassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/spectrassembler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spectral_layout_from_minimap.py [-h] [-r ROOT] -f FASTAFN -m MINIMAPFN
                                       [-w] [--w_len W_LEN]
                                       [--w_ovl_len W_OVL_LEN]
                                       [--sim_thr SIM_THR] [--len_thr LEN_THR]
                                       [-v] [--ref_pos_csvf REF_POS_CSVF]

optional arguments:
  -h, --help            show this help message and exit
  -r ROOT, --root ROOT  directory where to store layout files.
  -f FASTAFN, --fastafn FASTAFN
                        reads file path (fasta format))
  -m MINIMAPFN, --minimapfn MINIMAPFN
                        overlap file path (from minimap in PAF format).
  -w, --write_poa_files
                        Whether to write POA input files for consensus
                        generation or not.
  --w_len W_LEN         length of consensus windows for POA.
  --w_ovl_len W_OVL_LEN
                        overlap length between two successive consensus
                        windows.
  --sim_thr SIM_THR     threshold on overlap score (similarity matrix
                        preprocessing.)
  --len_thr LEN_THR     threshold on length of overlaps (similarity matrix
                        preprocessing).
  -v, --verbosity       verbosity level (-v, -vv or none)
  --ref_pos_csvf REF_POS_CSVF
                        csv file with position of reads (in same order as in
                        fastafn) obtained from BWA, in order to plot reads
                        position found vs reference.
```

## spectrassembler_gen_cons_from_poa

### Tool Description
Generate a consensus sequence for one contig from POA window files

### Metadata
- **Docker Image**: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
- **Homepage**: https://github.com/antrec/spectrassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/spectrassembler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gen_cons_from_poa.py [-h] [-r ROOT] [--poa_path POA_PATH]
                            [--poa_mat_path POA_MAT_PATH] -cc CONTIG
                            [--w_len W_LEN] [--w_ovl_len W_OVL_LEN] [-v]

optional arguments:
  -h, --help            show this help message and exit
  -r ROOT, --root ROOT  directory where to look for files (the one given to
                        spectral_layout_from_minimap.py).
  --poa_path POA_PATH   path/to/poa/poa (path to the executable)
  --poa_mat_path POA_MAT_PATH
                        path/to/poa-score.mat
  -cc CONTIG, --contig CONTIG
                        index of contig you wish to compute consensus for
  --w_len W_LEN         length of consensus windows for POA.
  --w_ovl_len W_OVL_LEN
                        overlap length between two successive consensus
                        windows.
  -v, --verbosity       verbosity level (nothing : 0, -v : 1; -vv : 2)
```

