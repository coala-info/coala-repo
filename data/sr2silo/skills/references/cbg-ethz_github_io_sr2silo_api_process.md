[ ]
[ ]

[Skip to content](#processing-module)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Processing

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../../usage/configuration/)
* [API Reference](../loculus/)
* [Contributing](../../contributing/)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [ ]

  Usage

  Usage
  + [Configuration](../../usage/configuration/)
  + [Multi-Organism Support](../../usage/organisms/)
  + [Deployment](../../usage/deployment/)
  + [Resource Requirements](../../usage/resource_requirements/)
* [x]

  API Reference

  API Reference
  + [Loculus Integration](../loculus/)
  + [ ]

    Processing

    [Processing](./)

    Table of contents
    - [Data Structures](#data-structures)

      * [AlignedRead](#alignedread)
    - [AlignedRead](#sr2silo.process.AlignedRead)

      * [\_\_init\_\_](#sr2silo.process.AlignedRead.__init__)
      * [\_\_str\_\_](#sr2silo.process.AlignedRead.__str__)
      * [get\_amino\_acid\_insertions](#sr2silo.process.AlignedRead.get_amino_acid_insertions)
      * [get\_metadata](#sr2silo.process.AlignedRead.get_metadata)
      * [set\_metadata](#sr2silo.process.AlignedRead.set_metadata)
      * [set\_nuc\_insertion](#sr2silo.process.AlignedRead.set_nuc_insertion)
      * [to\_dict](#sr2silo.process.AlignedRead.to_dict)
      * [to\_silo\_json](#sr2silo.process.AlignedRead.to_silo_json)
      * [Gene](#gene)
    - [Gene](#sr2silo.process.Gene)

      * [\_\_init\_\_](#sr2silo.process.Gene.__init__)
      * [to\_dict](#sr2silo.process.Gene.to_dict)
      * [GeneSet](#geneset)
    - [GeneSet](#sr2silo.process.GeneSet)

      * [\_\_init\_\_](#sr2silo.process.GeneSet.__init__)
      * [get\_gene](#sr2silo.process.GeneSet.get_gene)
      * [get\_gene\_length](#sr2silo.process.GeneSet.get_gene_length)
      * [get\_gene\_name\_list](#sr2silo.process.GeneSet.get_gene_name_list)
      * [set\_gene\_length](#sr2silo.process.GeneSet.set_gene_length)
      * [to\_dict](#sr2silo.process.GeneSet.to_dict)
      * [NucInsertion](#nucinsertion)
    - [NucInsertion](#sr2silo.process.NucInsertion)

      * [AAInsertion](#aainsertion)
    - [AAInsertion](#sr2silo.process.AAInsertion)

      * [AAInsertionSet](#aainsertionset)
    - [AAInsertionSet](#sr2silo.process.AAInsertionSet)

      * [\_\_eq\_\_](#sr2silo.process.AAInsertionSet.__eq__)
      * [\_\_init\_\_](#sr2silo.process.AAInsertionSet.__init__)
      * [from\_dict](#sr2silo.process.AAInsertionSet.from_dict)
      * [set\_insertions\_for\_gene](#sr2silo.process.AAInsertionSet.set_insertions_for_gene)
      * [to\_dict](#sr2silo.process.AAInsertionSet.to_dict)
    - [BAM Conversion](#bam-conversion)
    - [bam\_to\_sam](#sr2silo.process.bam_to_sam)
    - [sam\_to\_bam](#sr2silo.process.sam_to_bam)
    - [bam\_to\_fasta\_query](#sr2silo.process.bam_to_fasta_query)
    - [sort\_bam\_file](#sr2silo.process.sort_bam_file)
    - [sort\_and\_index\_bam](#sr2silo.process.sort_and_index_bam)
    - [sort\_sam\_by\_qname](#sr2silo.process.sort_sam_by_qname)
    - [get\_gene\_set\_from\_ref](#sr2silo.process.get_gene_set_from_ref)
    - [Translation and Alignment](#translation-and-alignment)
    - [nuc\_to\_aa\_alignment](#sr2silo.process.nuc_to_aa_alignment)
    - [parse\_translate\_align](#sr2silo.process.parse_translate_align)
    - [parse\_translate\_align\_in\_batches](#sr2silo.process.parse_translate_align_in_batches)
    - [curry\_read\_with\_metadata](#sr2silo.process.curry_read_with_metadata)
    - [Read Merging](#read-merging)
    - [paired\_end\_read\_merger](#sr2silo.process.paired_end_read_merger)
    - [Exceptions](#exceptions)
    - [ZeroFilteredReadsError](#sr2silo.process.ZeroFilteredReadsError)
  + [Data Schemas](../schema/)
  + [V-Pipe Integration](../vpipe/)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# Processing Module

Core functions for BAM processing, translation, and alignment.

## Data Structures

### AlignedRead

## `sr2silo.process.AlignedRead`

Class to represent an aligned read.

### `__init__(read_id, unaligned_nucleotide_sequence, aligned_nucleotide_sequence, aligned_nucleotide_sequence_offset, nucleotide_insertions, amino_acid_insertions, aligned_amino_acid_sequences, metadata=None)`

Initialize with a AlignedRead object.

### `__str__()`

toString method as pretty JSON string.

### `get_amino_acid_insertions()`

Return the amino acid insertions.

### `get_metadata()`

Return the metadata.

### `set_metadata(metadata)`

Set the metadata. Keep as ReadMetadata object to preserve alias information.

### `set_nuc_insertion(nuc_insertion)`

Append a nucleotide insertion to the list of nucleotide insertions.

### `to_dict()`

Return a dictionary / json representation of the object.

Uses camelCase field names (via Pydantic aliases) for metadata fields
to match SILO database schema.

### `to_silo_json(indent=False)`

Validate the aligned read dict using the new SILO schema and return a
nicely formatted JSON string conforming to the DB requirements.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `indent` | `bool` | Whether to indent the JSON string, True for pretty print. | `False` |

### Gene

## `sr2silo.process.Gene`

Class to represent a gene with a name and a length.

### `__init__(gene_name, gene_length)`

Initialize with a gene name and a gene length.

### `to_dict()`

Return a dictionary with gene name and gene length.

### GeneSet

## `sr2silo.process.GeneSet`

Class to represent a set of genes for a pathogen

### `__init__(genes)`

Initialize with a list of genes.

### `get_gene(gene_name)`

Return a gene by name.

### `get_gene_length(gene_name)`

Return the length of a gene.

### `get_gene_name_list()`

Return a list of genes.

### `set_gene_length(gene_name, gene_length)`

Set the length of a gene.

### `to_dict()`

Return a dictionary with gene names as keys and gene
length as values.

### NucInsertion

## `sr2silo.process.NucInsertion`

Bases: `Insertion`

A nuclotide insertion.

### AAInsertion

## `sr2silo.process.AAInsertion`

Bases: `Insertion`

An amino acid insertion.

### AAInsertionSet

## `sr2silo.process.AAInsertionSet`

Class to represent the set of amino acid insertions for a full set of genes.

### `__eq__(other)`

Compare two AAInsertionSet objects by their values.

This compares the dictionaries generated by to\_dict() method,
ensuring a value-based comparison rather than identity-based.

### `__init__(genes)`

Initialize with an empty set of insertions for each gene.

### `from_dict(data)` `staticmethod`

Create an AAInsertionSet object from a dictionary.

### `set_insertions_for_gene(gene_name, aa_insertions)`

Set the amino acid insertions for a particular gene.

### `to_dict()`

Return a dictionary with gene names as keys.

## BAM Conversion

## `sr2silo.process.bam_to_sam(bam_file, sam_file)`

Converts a BAM file to SAM format and writes it to the specified output file.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `bam_file` | `Path` | Path to the input BAM file. | *required* |
| `sam_file` | `Path` | Path to the output SAM file. | *required* |
| `sam_file` | `Path` | Path to the output SAM file. | *required* |

## `sr2silo.process.sam_to_bam(sam_file, bam_file)`

Convert a SAM file to a BAM file.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `sam_file` | `Path` | Path to the input SAM file. | *required* |
| `bam_file` | `Path` | Path to the output BAM file. | *required* |

## `sr2silo.process.bam_to_fasta_query(bam_file, fasta_file)`

Convert a BAM file to a FASTA file. Bluntly resolved the sam to fasta,
removing soft clippings, keeping insertions and deletions, ignoring skipped
regions and paddings.

Outputs the sequence as it is read from the molecule.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `bam_file` | `Path` | Path to the input BAM file. | *required* |
| `fasta_file` | `Path` | Path to the output FASTQ file. | *required* |

## `sr2silo.process.sort_bam_file(input_bam_path, output_bam_path, sort_by_qname=False)`

Sorts a BAM file using pysam.sort by alignment positions by default,
but can also sort by query name if specified.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `input_bam_path` | `Path` | Path to the input BAM file. | *required* |
| `output_bam_path` | `Path` | Path to the output sorted BAM file. | *required* |
| `sort_by_qname` | `bool` | If True, sorts by query name. Defaults to False. | `False` |

## `sr2silo.process.sort_and_index_bam(input_bam_fp, output_bam_fp)`

Function to sort and index the input BAM file,

implements checks to see if the input BAM file is already sorted and indexed.

If not sorted and indexed, the function will sort and index the input BAM file.

## `sr2silo.process.sort_sam_by_qname(input_sam_path, output_sam_path)`

Sorts a sam file using pysam.sort command by query name.
Args:
input\_bam\_path (Path): Path to the input BAM file.
output\_bam\_path (Path): Path to the output sorted BAM file.

## `sr2silo.process.get_gene_set_from_ref(reference_fp)`

Load the gene ref fasta and create a GeneSet with gene short
names and lengths.

## Translation and Alignment

## `sr2silo.process.nuc_to_aa_alignment(in_nuc_alignment_fp, in_aa_db_fp, out_aa_alignment_fp)`

Function to convert files and translate and align with Diamond / blastx.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `in_nuc_alignment_fp` | `Path` | Path to the input nucleotide alignment file. | *required* |
| `in_aa_db_fp` | `Path` | Path to the input amino acid diamond database file. | *required* |
| `out_aa_alignment_fp` | `Path` | Path to the output amino acid alignment file. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `None` | None |

Description

Uses Diamond with the settings:
--evalue 1
--gapopen 6
--gapextend 2
--outfmt 101
--matrix BLOSUM62
--unal 0
--max-hsps 1
--block-size 0.5

## `sr2silo.process.parse_translate_align(nuc_reference_fp, aa_reference_fp, nuc_alignment_fp, aa_db_fp, target_reference=None)`

Parse nucleotides, translate and align amino acids the input files.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `nuc_reference_fp` | `Path` | Path to nucleotide reference FASTA file. | *required* |
| `aa_reference_fp` | `Path` | Path to amino acid reference FASTA file. | *required* |
| `nuc_alignment_fp` | `Path` | Path to nucleotide alignment BAM file. | *required* |
| `aa_db_fp` | `Path` | Path to Diamond database file. | *required* |
| `target_reference` | `str | None` | Filter reads to only include those aligned to this reference accession. If None, all reads are processed. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `Dict[str, [AlignedRead](#sr2silo.process.AlignedRead "sr2silo.process.AlignedRead (sr2silo.process.interface.AlignedRead)")]` | Dictionary mapping read IDs to AlignedRead objects. |

## `sr2silo.process.parse_translate_align_in_batches(nuc_reference_fp, aa_reference_fp, nuc_alignment_fp, metadata_fp, output_fp, chunk_size=100000, write_chunk_size=20, target_reference=None)`

Parse nucleotides, translate and align amino acids in batches.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `nuc_reference_fp` | `Path` | Path to the nucleotide reference genome - .fasta | *required* |
| `aa_reference_fp` | `Path` | Path to the amino acid reference genome - .fasta | *required* |
| `nuc_alignment_fp` | `Path` | Path to the nucleotide alignment file - .bam | *required* |
| `metadata_fp` | `Path` | Path to the metadata file - .json | *required* |
| `output_fp` | `Path` | Path to the output file - .ndjson | *required* |
| `chunk_size` | `int` | Size of each batch, in number of reads. | `100000` |
| `write_chunk_size` | `int` | Size of each write batch. | `20` |
| `target_reference` | `str | None` | Filter reads to only include those aligned to this reference accession. Should match @SQ SN field in BAM header. If None, all reads are processed. | `None` |

Returns:

| Name | Type | Description |
| --- | --- | --- |
| `Path` | `Path` | The path to the output file with the correct suffix. |

Resources

A chunk\_size of 100000 reads is a good starting point for most cases.
This will take about 3.7 GB ram for Covid Genomes and 1-2 minutes to process.

Constraints

No sorting constraints are enforced on the input files.
The output file is compressed with zstd.

Constraints

No sorting constraints are enforced on the input files.
The output file is compressed with zstd.

Logs

All logs of INFO and below are suppressed.

## `sr2silo.process.curry_read_with_metadata(metadata_fp)`

Returns a function that enriches an AlignedRead with metadata.

Reads metadata from a JSON file and returns a function that enriches
an AlignedRead with the loaded metadata.

## Read Merging

## `sr2silo.process.paired_end_read_merger(nuc_align_sam_fp, ref_genome_fasta_fp, output_merged_sam_fp)`

Merge paired-end reads using `smallgenomutilities`tool `paired_end_read_merger`.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `nuc_align_sam_fp` | `Path` | Path to the nucleotide alignment SAM file. | *required* |
| `ref_genome_fasta_fp` | `Path` | Path to the reference genome FASTA file. | *required* |
| `output_merged_sam_fp` | `Path` | Path to the output merged SAM file. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `None` | None |

## Exceptions

## `sr2silo.process.ZeroFilteredReadsError`

Bases: `Exception`

Raised when reference filtering results in zero reads.

This error indicates that a target reference was specified for filtering,
but no reads in the BAM file aligned to that reference. This typically
means the wrong reference was specified or the data doesn't contain
reads for the expected reference.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)