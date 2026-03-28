# vgorient CWL Generation Report

## vgorient_jaccard_dit_wrapper.py

### Tool Description
Run kmer_jaccard.py and VG_diterative.py

### Metadata
- **Docker Image**: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/whelixw/vgOrient
- **Package**: https://anaconda.org/channels/bioconda/packages/vgorient/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vgorient/overview
- **Total Downloads**: 487
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/whelixw/vgOrient
- **Stars**: N/A
### Original Help Text
```text
usage: jaccard_dit_wrapper.py [-h] [--output OUTPUT]
                              [--vg_output_dir VG_OUTPUT_DIR]
                              [--kmer_size KMER_SIZE] [--orientation]
                              [--vg_orient] [--band_width BAND_WIDTH]
                              [--min_match_length MIN_MATCH_LENGTH]
                              [--append_wm] [--log LOG] [--min_jaccard_init]
                              input_files [input_files ...]

Run kmer_jaccard.py and VG_diterative.py

positional arguments:
  input_files           Input file paths for kmer_jaccard.py

options:
  -h, --help            show this help message and exit
  --output OUTPUT, -o OUTPUT
                        Output file name for kmer_jaccard.py
  --vg_output_dir VG_OUTPUT_DIR
                        Output directory for VG_diterative.py
  --kmer_size KMER_SIZE, -k KMER_SIZE
                        kmer size for computing jaccard similarity
  --orientation         Reorient inputs in kmer_jaccard.py
  --vg_orient, -vo      use vg to orient nodes
  --band_width BAND_WIDTH, -w BAND_WIDTH
                        Band width for VG mapping.
  --min_match_length MIN_MATCH_LENGTH, -m MIN_MATCH_LENGTH
                        Minimum match length for VG mapping.
  --append_wm           Append w and m values to the output directory name.
  --log LOG             Log file name for recording execution details and
                        timings.
  --min_jaccard_init, -mcj
                        Order sequences by lowest sum of j-dist
```


## vgorient_kmer_rotation_multiprocessing.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/whelixw/vgOrient
- **Package**: https://anaconda.org/channels/bioconda/packages/vgorient/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/bin/kmer_rotation_multiprocessing.py: line 1: import: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 2: from: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 3: from: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 4: from: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 5: from: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 6: from: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 7: import: command not found
/usr/local/bin/kmer_rotation_multiprocessing.py: line 9: syntax error near unexpected token `('
/usr/local/bin/kmer_rotation_multiprocessing.py: line 9: `def generate_kmer_deque(seq, k):'
```


## vgorient_cut_and_rot_rebuild.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/whelixw/vgOrient
- **Package**: https://anaconda.org/channels/bioconda/packages/vgorient/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/bin/cut_and_rot_rebuild.py: line 1: import: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 2: from: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 3: from: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 4: from: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 5: import: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 6: import: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 7: import: command not found
/usr/local/bin/cut_and_rot_rebuild.py: line 9: syntax error near unexpected token `('
/usr/local/bin/cut_and_rot_rebuild.py: line 9: `def parse_vg_gfa(gfa_file):'
```


## vgorient_noisify.py

### Tool Description
Adds random transformations to FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/whelixw/vgOrient
- **Package**: https://anaconda.org/channels/bioconda/packages/vgorient/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/noisify.py: line 1: import: command not found
/usr/local/bin/noisify.py: line 2: import: command not found
/usr/local/bin/noisify.py: line 3: import: command not found
/usr/local/bin/noisify.py: line 4: from: command not found
/usr/local/bin/noisify.py: line 5: from: command not found
/usr/local/bin/noisify.py: line 6: from: command not found
/usr/local/bin/noisify.py: line 8: syntax error near unexpected token `('
/usr/local/bin/noisify.py: line 8: `def random_transform_fasta(input_file, output_dir, reverse, transformation_log):'
```


## Metadata
- **Skill**: generated
