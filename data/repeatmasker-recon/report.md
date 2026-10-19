# repeatmasker-recon CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| repeatmasker-recon | PASS | ran the C. elegans demo; the Tc3 family matches the 26 curated copies |
| repeatmasker-recon_MSPCollect | Not completed | needs WU-BLAST output; NCBI BLAST output gives zero coordinates and no sample WU-BLAST output is available |
| repeatmasker-recon_edgeredef | PASS | ran on the C. elegans demo data in pipeline order; chained output gives the same families as the full run |
| repeatmasker-recon_eledef | PASS | ran on the C. elegans demo data in pipeline order; chained output gives the same families as the full run |
| repeatmasker-recon_eleredef | PASS | ran on the C. elegans demo data in pipeline order; chained output gives the same families as the full run |
| repeatmasker-recon_famdef | PASS | ran on the C. elegans demo data in pipeline order; chained output gives the same families as the full run |
| repeatmasker-recon_imagespread | PASS | ran on the C. elegans demo data in pipeline order; chained output gives the same families as the full run |

## repeatmasker-recon

### Tool Description
See 00README for details.

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repeatmasker-recon/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: recon seq_name_list_file MSP_file integer
See 00README for details.
```


## repeatmasker-recon_imagespread

### Tool Description
Spread the MSPs into images (first step of repeatmasker-recon).

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
  imagespread seq_name_list msp_list number_of_output_files
last parameter optional with default of 1
```

## repeatmasker-recon_eledef

### Tool Description
Define elements from the sorted MSP images.

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ele_def seq_list msp_file method cut_off
for method, choose 'single' or 'double'
cutoff is optional
```

## repeatmasker-recon_eleredef

### Tool Description
Re-define elements.

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: redef seq_list start clan_ct
 where seq_list is the list of sequence names, start is the index of the element to start redefining, and clan_ct is the number to start counting the number of clans.  The latter two are optional.
```

## repeatmasker-recon_edgeredef

### Tool Description
Re-define edges.

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fam_def seq_list start
 where seq_list is the list of sequence names, start is the index of the element to start defining families.  The latter one is optional.
```

## repeatmasker-recon_famdef

### Tool Description
Define families.

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: famdef seq_list
 where seq_list is the list of sequence names.
```

## repeatmasker-recon_MSPCollect

### Tool Description
Convert a BLAST output into an MSP file.

### Metadata
- **Docker Image**: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
- **Homepage**: https://www.repeatmasker.org/RepeatMasker
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatmasker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MSPCollect BLAST_output_file
```
