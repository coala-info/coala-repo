# vgp-processcuration CWL Generation Report

## vgp-processcuration_split_agp

### Tool Description
Correct AGP for sequence lengths, split the agp per haplotype, assign unlocs and remove duplicated haplotigs

### Metadata
- **Docker Image**: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/vgl-hub/vgl-curation
- **Package**: https://anaconda.org/channels/bioconda/packages/vgp-processcuration/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vgp-processcuration/overview
- **Total Downloads**: 64
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/vgl-hub/vgl-curation
- **Stars**: N/A
### Original Help Text
```text
usage: split_agp -f assembly.fasta -a curated_agp.agp

Correct AGP for sequence lengths, split the agp per haplotype, assign unlocs and remove duplicated haplotigs  

options:
  -h, --help            show this help message and exit
  -a, --agp AGP         Path to the curated AGP file
  -f, --fasta FASTA     Path to the assembly fasta file
  -o, --output OUTPUT_DIR
                        Path to the output directory (Default: current directory)

Outputs:
- corrected.agp: Curated AGP file corrected for sequence lengths.
- Hap_1/hap1.agp: AGP file for Haplotype 1.
- Hap_2/hap2.agp: AGP file for Haplotype 2.
- Hap_1/hap.unlocs.no_hapdups.agp: AGP file for Haplotype 1 with assigned unlocs and purged of duplicated haplotigs.
- Hap_2/hap.unlocs.no_hapdups.agp: AGP file for Haplotype 2 with assigned unlocs and purged of duplicated haplotigs.
- Hap_1/haplotigs.agp: AGP file containing the haplotig duplications removed from Haplotype 1.
- Hap_2/haplotigs.agp: AGP file containing the haplotig duplications removed from Haplotype 2.
```


## vgp-processcuration_chromosome_assignment

### Tool Description
Modify scaffold names to reflect chromosomal assignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/vgl-hub/vgl-curation
- **Package**: https://anaconda.org/channels/bioconda/packages/vgp-processcuration/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosome_assignment -a Hap_2/hap.unlocs.no_hapdups.agp -f Hap_2/hap2_sorted.fasta -o Hap_2

Modify scaffold names to reflect chromosomal assignment.

options:
  -h, --help            show this help message and exit
  -a, --agp AGP         Path to the haplotype AGP without haplotig duplications
  -f, --fasta FASTA     Path to the sorted fasta file
  -o, --output_dir OUTPUT_DIR
                        Output directory

Outputs: 
- {output_dir}/inter_chr.tsv:  Table mapping the scaffolds to their chromosomal assignment.
- {output_dir}/hap.chr_level.fa:  Fasta file with chromosomal level sequences.
```


## vgp-processcuration_sak_generation

### Tool Description
Filter Mashmap output to keep only Scaffolds paired with the tags Hap_1 and Hap_2

### Metadata
- **Docker Image**: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/vgl-hub/vgl-curation
- **Package**: https://anaconda.org/channels/bioconda/packages/vgp-processcuration/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_mashmap_with_tagged_pairs -1 Hap_1/inter_chr.tsv -2 Hap_2/inter_chr.tsv -q Hap_2 -r Hap_1 -agp curated_agp_with_micro_tags.agp -m mashmap.out -o results/ 

Filter Mashmap output to keep only Scaffolds paired with the tags Hap_1 and Hap_2

options:
  -h, --help            show this help message and exit
  -1, --hap1 HAP1       Path to the chromosome assignment file for  Haplotype 1 (inter_chr.tsv) 
  -2, --hap2 HAP2       Path to the chromosome assignment file for Haplotype 2 (inter_chr.tsv) 
  -q, --query QUERY     Haplotype use as Query for MashMap: Hap_1 or Hap_2 (Default Hap_2)
  -r, --reference REFERENCE
                        Haplotype use as reference for MashMap: Hap_1 or Hap_2 (Default Hap_1)
  -a, --agp AGP         Path to the curated AGP file (with the tags Hap_1 and Hap_2)
  -m, --mashmap MASHMAP
                        Path to the curated Mashmap output
  -o, --out_dir OUT_DIR
                        Path to output Prefix

Outputs: 
- {out_dir}/rvcp.sak: SAK file for gfastats reversing of hap2 sequences
- {out_dir}/orientation.tsv:  Table with the orientation of Hap1 vs Hap2 scaffolds (The sign is the most represented in the mashmap alignments between two sequences)
- {out_dir}/hap2.vs.hap1.tsv: The Mapping between hap2 and hap1 names.
```

