name: agc
description: High-efficiency compression and management of de-novo assembled genome collections. Use this skill when you need to (1) compress multiple FASTA files into a single archive, (2) add new genomes to an existing archive, (3) extract specific samples or contigs without decompressing the entire collection, or (4) inspect the contents and statistics of an AGC archive.

# Assembled Genomes Compressor (AGC)

AGC is designed for high-ratio compression of genomic datasets (viruses to humans) while maintaining fast random access to samples and contigs.

## Core Workflows

### Creating Archives
Create a new archive by providing a reference genome and additional FASTA files.
- **Basic creation**: `agc create ref.fa sample1.fa sample2.fa > collection.agc`
- **Using a file list**: `agc create -i file_list.txt ref.fa -o collection.agc` (where `file_list.txt` contains one FASTA path per line).
- **Bacterial/Diverse data**: Use adaptive mode for better ratios on non-human/diverse datasets: `agc create -a ref.fa samples.fa > collection.agc`
- **Concatenated input**: If multiple samples are in one file, use `-c`: `agc create -c ref.fa all_samples.fa > collection.agc`

### Appending Data
Add new genomes to an existing archive without recompressing the whole set.
- **Basic append**: `agc append in.agc new_sample.fa > out.agc`
- **In-place style**: `agc append -i new_list.txt in.agc -o out.agc`

### Extraction and Retrieval
Extract data to stdout or specific files.
- **Full collection**: `agc getcol in.agc > all.fa`
- **Specific samples**: `agc getset in.agc sample1 sample2 > subset.fa`
- **Specific contigs**: `agc getctg in.agc contig1 contig2 > contigs.fa`
- **Coordinate-based**: `agc getctg in.agc contig1:100-500 > fragment.fa`
- **Disambiguation**: If contig names are not unique across samples, use `@`: `agc getctg in.agc contig1@sampleA > specific.fa`

### Inspection
- **List samples**: `agc listset in.agc`
- **List contigs in samples**: `agc listctg in.agc sample1 sample2`
- **Archive stats**: `agc info in.agc` (shows compression parameters and command history)

## Expert Tips & Optimization

### Performance Tuning
- **Threads**: Use `-t <int>` to specify CPU threads (default is usually auto-detected).
- **Memory vs. Speed**: In v3.2+, use `--stream` during decompression to reduce memory footprint at the cost of speed.
- **Manual Parameters**: For specialized needs, adjust k-mer size (`-k`) and segment length (`-l`). Default `k=31, l=20` is optimized for human pangenomes.

### Input Handling
- **Gzipped input**: AGC natively supports `.fa.gz` files.
- **Reference Selection**: The first genome provided to `create` is the reference. Choosing a high-quality, representative genome as the reference significantly improves compression ratios for the rest of the collection.

### Adaptive Mode (`-a`)
Always use `-a` for bacterial datasets or collections with high sequence diversity. It enables a more flexible matching strategy that handles shorter, more fragmented assemblies better than the default pangenome-optimized mode.