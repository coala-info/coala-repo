# phylocsfpp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phylocsfpp_annotate-with-mmseqs | Not completed | needs MMseqs2 (not in the image) and a set of reference genomes |
| phylocsfpp_annotate-with-tracks | PASS |  |
| phylocsfpp_build-tracks | PASS |  |
| phylocsfpp_find-cds | PASS |  |
| phylocsfpp_score-msa | PASS |  |

## phylocsfpp_build-tracks

### Tool Description
Computes PhyloCSF tracks for each codon and all 6 frames from alignment files in MAF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
- **Homepage**: https://github.com/cpockrandt/PhyloCSFpp
- **Package**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Validation**: PASS

### Original Help Text
```text
PhyloCSF++ v1.2.0 (build date: 2022-01-04, git commit: 9643238d)

Computes PhyloCSF tracks for each codon and all 6 frames from alignment files in MAF 
format as well as the power track containing the branch length scores (confidence of 
the PhyloCSF scores). Optionally the PhyloCSF scores can be smoothened and posterior 
probabilities can be computed. Outputs wig files.

Usage: phylocsf++ build-tracks [OPTIONS] <model> <alignments>...

Arguments:

  <model>                  Path to parameter files, or one of the following
                           predefined models: 21mosquitoes, 58mammals, 7yeast,
                           29mammals, 53birds, 49birds, 100vertebrates, 23flies,
                           12flies, 26worms, 20flies.

  <alignments>             One or more files containing multiple sequence alignments.
                           Formats: MAF and multi FASTA. Multiple MSAs can be stored
                           in a single file separated by empty lines.

Options:

  --output-raw-phylo BOOL  Compute all 6 unsmoothened PhyloCSF tracks. Default: 1
  --output-phylo BOOL      Compute all 6 smoothened PhyloCSF tracks. Requires coding
                           exon coordinates and genome length. Default: 0
  --output-regions BOOL    Generate bed files with coordinates of potential protein
                           coding regions. Requires coding exon coordinates and
                           genome length. Default: 0
  --power-threshold FLOAT  Minimum confidence score to output PhyloCSF score.
                           Default: 0.1
  --genome-length INT      Total genome length (needed for --output-phylo).
  --coding-exons STRING    BED-like file (chrom name, strand, phase, start, end) with
                           coordinates of coding exons (needed for --output-phylo).
  --threads INT            Parallelize scoring of multiple MSAs in a file using
                           multiple threads. Default: 20
  --output STRING          Directory where tracks in wig format will be written to.
                           If it does not exist, it will be created. Default: output
                           files are stored next to the input files.
  --mapping STRING         If the MSAs don't use common species names (like Human,
                           Chimp, etc.) you can pass a two-column tsv file with a
                           name mapping.
  --species STRING         Comma separated list of species to reduce <model> to a
                           subset of species to improve running time, e.g.,
                           "Human,Chimp,Seaturtle"

Help options:

  --model-info STRING      Output the organisms included in a specific model.
                           Included models are: 21mosquitoes, 58mammals, 7yeast,
                           29mammals, 53birds, 49birds, 100vertebrates, 23flies,
                           12flies, 26worms, 20flies.
```

## phylocsfpp_score-msa

### Tool Description
Computes PhyloCSF scores and confidence scores for whole alignments in MAF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
- **Homepage**: https://github.com/cpockrandt/PhyloCSFpp
- **Package**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Validation**: PASS

### Original Help Text
```text
PhyloCSF++ v1.2.0 (build date: 2022-01-04, git commit: 9643238d)

Computes PhyloCSF scores and confidence scores for whole alignments in MAF 
files. Output is written to bed file(s). Optionally the ancestral sequence 
composition score can be computed as well. Only one forward frame is computed, 
i.e., for other frames reverse the alignments and/or remove the first one or two 
bases.

Usage: phylocsf++ score-msa [OPTIONS] <model> <alignments>...

Arguments:

  <model>                Path to parameter files, or one of the following predefined
                         models: 21mosquitoes, 58mammals, 7yeast, 29mammals, 53birds,
                         49birds, 100vertebrates, 23flies, 12flies, 26worms, 20flies.

  <alignments>           One or more files containing multiple sequence alignments.
                         Formats: MAF and multi FASTA. Multiple MSAs can be stored in
                         a single file separated by empty lines.

Options:

  --strategy STRING      PhyloCSF scoring algorithm: MLE, FIXED or OMEGA. Default:
                         MLE
  --comp-phylo BOOL      Compute the PhyloCSF score for each alignment. Default: 1
  --comp-anc BOOL        Compute the ancestral sequence composition score (only in
                         MLE and FIXED mode). Default: 0
  --threads INT          Parallelize scoring of multiple MSAs in a file. Default: 20
  --output STRING        Path where tracks in wig format will be written. If it does
                         not exist, it will be created. Default: output files are
                         stored next to the input files.
  --mapping STRING       If the MSAs don't use common species names (like Human,
                         Chimp, etc.) you can pass a two-column tsv file with a name
                         mapping.
  --species STRING       Comma separated list of species to reduce <model> to a
                         subset of species to improve running time, e.g.,
                         "Human,Chimp,Seaturtle"
  --genome-length INT    Total genome length (needed for --output-phylo).
  --coding-exons STRING  BED-like file (chrom name, strand, phase, start, end) with
                         coordinates of coding exons (needed for --output-phylo).

Help options:

  --model-info STRING    Output the organisms included in a specific model. Included
                         models are: 21mosquitoes, 58mammals, 7yeast, 29mammals,
                         53birds, 49birds, 100vertebrates, 23flies, 12flies, 26worms,
                         20flies.
```

## phylocsfpp_annotate-with-tracks

### Tool Description
Computes PhyloCSF scores for CDS features in GFF/GTF files using precomputed tracks.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
- **Homepage**: https://github.com/cpockrandt/PhyloCSFpp
- **Package**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Validation**: PASS

### Original Help Text
```text
PhyloCSF++ v1.2.0 (build date: 2022-01-04, git commit: 9643238d)

Computes PhyloCSF scores for CDS features in GFF/GTF files and outputs them in 
the same format. Requires PhyloCSF tracks in BigWig (*.bw) format.

Usage: phylocsf++ annotate-with-tracks [OPTIONS] <tracks> <gff-files>...

Arguments:

  <tracks>         Path to the bigWig file PhyloCSF+1.bw (expects the other 5 frames
                   to be in the same directory, optionally the power track).

  <gff-files>      One or more GFF/GTF files with coding exons to be scored.

Options:

  --output STRING  Path where output GFF/GTF will be written to. If it does not
                   exist, it will be created. Default: output files are stored next
                   to the input files.
```

## phylocsfpp_annotate-with-mmseqs

### Tool Description
Computes PhyloCSF scores for CDS features in GFF/GTF files with alignments made by MMseqs2.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
- **Homepage**: https://github.com/cpockrandt/PhyloCSFpp
- **Package**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Validation**: PASS

### Original Help Text
```text
PhyloCSF++ v1.2.0 (build date: 2022-01-04, git commit: 9643238d)

Computes PhyloCSF scores for CDS features in GFF/GTF files and outputs them in 
the same format. Requires MMseqs2 to be installed and a set of reference genomes 
to compute multiple sequence alignments from scratch.
To get an average score over all codons of posterior probabilities (similar to 
annotate-with-tracks), use --strategy FIXED_MEAN.

Usage: phylocsf++ annotate-with-mmseqs [OPTIONS] <genome-file> <model> <gff-files>...

Arguments:

  <genome-file>          Two-column tsv file with species name and path to its
                         genomic fasta file. First line has to be the reference
                         genome of the GFF file.

  <model>                Path to parameter files, or one of the following predefined
                         models: 21mosquitoes, 58mammals, 7yeast, 29mammals, 53birds,
                         49birds, 100vertebrates, 23flies, 12flies, 26worms, 20flies.

  <gff-files>            One or more GFF/GTF files with coding exons to be scored.

Options:

  --threads INT          Parallelize scoring of multiple MSAs in a file. Default: 20
  --output STRING        Path where output GFF/GTF will be written to. If it does not
                         exist, it will be created. Default: output files are stored
                         next to the input files.
  --strategy STRING      PhyloCSF scoring algorithm: MLE, FIXED, OMEGA or FIXED_MEAN.
                         Default: MLE
  --mmseqs-bin STRING    Path to MMseqs2 binary. Default: mmseqs
  --genome-length INT    Total genome length (needed for --strategy FIXED_MEAN).
  --coding-exons STRING  BED-like file (chrom name, strand, phase, start, end) with
                         coordinates of coding exons (needed for --strategy
                         FIXED_MEAN).
  --mapping STRING       If the MSAs don't use common species names (like Human,
                         Chimp, etc.) you can pass a two-column tsv file with a name
                         mapping.

Help options:

  --model-info STRING    Output the organisms included in a specific model. Included
                         models are: 21mosquitoes, 58mammals, 7yeast, 29mammals,
                         53birds, 49birds, 100vertebrates, 23flies, 12flies, 26worms,
                         20flies.
```

## phylocsfpp_find-cds

### Tool Description
Scores every possible ORF of transcripts in a GFF file to find protein-coding genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
- **Homepage**: https://github.com/cpockrandt/PhyloCSFpp
- **Package**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Validation**: PASS

### Original Help Text
```text
PhyloCSF++ v1.2.0 (build date: 2022-01-04, git commit: 9643238d)

Takes a GFF file with transcripts and scores every possible ORF to find novel 
protein-coding genes and outputs a GFF file with annotated CDS features.
Either all CDS meeting the criteria can be outputted, or the longest or 
best-scoring one.
'find-cds' and especially '--evaluate' is experimental. It is recommended to 
only have 'transcript', 'exon', and optionally 'CDS' features (see --evaluate) 
in the GFF file. Other features can mess up the output.

Usage: phylocsf++ find-cds [OPTIONS] <fasta> <tracks> <gff-files>...

Arguments:

  <fasta>            Path to the genome fasta file.

  <tracks>           Path to the bigWig file PhyloCSF+1.bw (expects the other 5
                     frames to be in the same directory, optionally the power track).

  <gff-files>        One or more GFF/GTF files with coding exons to be scored.

Options:

  --output STRING    Path where output GFF/GTF will be written to. If it does not
                     exist, it will be created. Default: output files are stored next
                     to the input files.
  --mode STRING      Which CDS to report: ALL, LONGEST, BEST_SCORE. Default: LONGEST
  --min-score FLOAT  Only consider ORFs with a minimum weighted PhyloCSF mean score
                     (range from -15 to +15, >0 more likely to be protein-coding).
                     Default: 0.000000
  --min-codons INT   Only consider ORFs with a minimum codon length. Default: 25
  --evaluate BOOL    Additionally reads CDS features in input GFF/GTF and outputs
                     statistics how well PhyloCSF++ has predicted CDS. This does not
                     affect the output GFF file, i.e., CDS from the input file are
                     not included, only predicted CDS are outputted (regardless
                     whether they matched the CDS in the input or not). Default: 0
```

