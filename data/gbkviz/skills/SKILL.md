---
name: gbkviz
description: gbkviz is a bioinformatics tool for visualizing and comparing Genbank genomes through a web-based dashboard. Use when user asks to visualize Genbank files, perform genomic sequence alignments, or generate publication-ready genomic diagrams.
homepage: https://github.com/moshi4/GBKviz/
metadata:
  docker_image: "quay.io/biocontainers/gbkviz:1.2.0--pyhdfd78af_0"
---

# gbkviz

## Overview
gbkviz is a specialized bioinformatics tool built on the Streamlit framework that facilitates the visualization and comparison of genomes stored in Genbank format. It utilizes BioPython's GenomeDiagram for rendering and MUMmer for sequence alignments. This skill provides the necessary commands and procedural knowledge to install, launch, and effectively use the tool for generating publication-ready genomic diagrams in PNG or SVG formats.

## Installation and Setup
gbkviz requires Python 3 and MUMmer (for comparison features).

- **Conda (Recommended)**:
  ```bash
  conda install -c bioconda -c conda-forge gbkviz
  ```
- **PyPI**:
  ```bash
  pip install gbkviz
  ```
- **Docker**:
  ```bash
  docker pull moshi4/gbkviz:latest
  docker run -d -p 8501:8501 moshi4/gbkviz:latest
  ```

## Usage Patterns
The primary interface for gbkviz is a web-based dashboard.

### Launching the Application
To start the local web server, execute:
```bash
gbkviz_webapp
```
Once running, access the interface at `http://localhost:8501`.

### Genome Comparison Methods
When performing comparative genomics within the app, you can choose from four MUMmer-based alignment methods:
1. **Nucleotide One-to-One Mapping**: Best for closely related strains.
2. **Nucleotide Many-to-Many Mapping**: Best for detecting rearrangements or duplications.
3. **Protein One-to-One Mapping**: Useful for divergent sequences where coding similarity remains.
4. **Protein Many-to-Many Mapping**: Most sensitive for distant evolutionary comparisons.

### Data Export
- **Visuals**: Export diagrams as **SVG** for infinite scalability in publications or **PNG** for quick sharing.
- **Alignment Data**: Comparison results are available as a TSV file containing reference/query coordinates, lengths, and identity percentages.

## Expert Tips
- **Local vs. Cloud**: Always prefer a local installation over Streamlit Cloud for large genomic datasets or complex comparative analyses to avoid resource-related crashes.
- **Environment Path**: Ensure `mummer` is in your system's PATH; otherwise, the comparison features in the webapp will fail silently or throw errors.
- **Vector Graphics**: Use the SVG output format if you intend to manually annotate or adjust the diagram in tools like Adobe Illustrator or Inkscape.

## Reference documentation
- [GBKviz GitHub Repository](./references/github_com_moshi4_GBKviz.md)
- [GBKviz Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gbkviz_overview.md)