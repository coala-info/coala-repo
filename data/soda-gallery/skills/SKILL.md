---
name: soda-gallery
description: soda-gallery generates visual galleries of genomic regions by capturing snapshots from the UCSC Genome Browser based on a BED file and session ID. Use when user asks to create a soda plot gallery, automate genome browser snapshots, or visualize genomic regions in an HTML gallery.
homepage: https://github.com/alexpreynolds/soda
metadata:
  docker_image: "quay.io/biocontainers/soda-gallery:1.2.0--pyhdfd78af_0"
---

# soda-gallery

## Overview
`soda-gallery` is a specialized tool for generating "soda plots"—visual galleries of genomic regions captured directly from a UCSC Genome Browser instance. It automates the tedious process of taking manual snapshots by using a BED file to define regions and a Browser Session ID to maintain consistent track configurations across all images. The final output is a portable HTML gallery (using PhotoSwipe or blueimp) suitable for presentations, reports, or supplementary data.

## Core Command Structure
The basic execution requires four parameters:
```bash
soda -r regions.bed -b hg38 -s "SESSION_ID" -o ./output_gallery
```

## Key Parameters and Best Practices
- **Region Labeling**: If your BED file has a 4th column (name), `soda` automatically uses these values as labels for the gallery pages. Ensure this column contains unique, descriptive identifiers.
- **Gallery Ordering**: Snapshots appear in the exact order of the input BED file. To group regions by significance or score, sort the BED file before running `soda`:
  `sort -k5,5n input.bed > sorted_by_score.bed`
- **Visual Context**: Use `--range <bases>` to pad the midpoint of your BED regions symmetrically. This is essential for providing genomic context around small features like SNPs or narrow peaks.
- **Annotations**:
  - Use `-i` (`--addIntervalAnnotation`) to draw a rectangle highlighting the specific genomic range.
  - Use `-d` (`--addMidpointAnnotation`) to draw a vertical line at the center of the range.
  - *Note*: You cannot use both `-i` and `-d` simultaneously.

## Advanced Configuration
- **Custom Browsers**: To use a local mirror or a non-UCSC browser, specify the URL with `-g`. If the instance is protected, use `-u` (username) and `-p` (password) or `-y` for Kerberos authentication.
- **Gallery Frameworks**: The default gallery uses `photoswipe`. If you prefer a different UI, switch to `blueimp` using `-m blueimp`.
- **Styling**: Customize annotation appearance to match publication standards using:
  - `-w`: RGBA color (e.g., `rgba(255,0,0,0.5)`)
  - `-z`: Font point size
  - `-f`: Font family (e.g., `Helvetica-Bold`)

## Expert Tips
- **Session Management**: Before running `soda`, ensure your UCSC session is saved and the "Session ID" is correct. The session controls which tracks are visible and their display mode (dense, squish, full).
- **Output Directory**: The tool will exit with an error if the specified output directory already exists. Always provide a new path or remove the old directory first.
- **Local Viewing**: Once generated, open the `index.html` file within the output directory in any modern web browser to view the gallery.

## Reference documentation
- [soda-gallery Overview](./references/anaconda_org_channels_bioconda_packages_soda-gallery_overview.md)
- [soda GitHub Documentation](./references/github_com_alexpreynolds_soda.md)