---
name: perl-bio-db-refseq
description: The `perl-bio-db-refseq` skill provides a standardized object interface for querying and retrieving genomic, transcript, and protein data from the NCBI RefSeq database.
homepage: https://metacpan.org/release/Bio-DB-RefSeq
---

# perl-bio-db-refseq

## Overview
The `perl-bio-db-refseq` skill provides a standardized object interface for querying and retrieving genomic, transcript, and protein data from the NCBI RefSeq database. It is primarily used to automate the fetching of high-quality, non-redundant sequences for bioinformatics pipelines, ensuring that sequence data and associated metadata (features, annotations) are correctly parsed into BioPerl objects.

## Usage Patterns

### Basic Sequence Retrieval
To fetch a sequence by its accession number, initialize the `Bio::DB::RefSeq` module. This is the most reliable way to ensure you are getting the curated RefSeq version of a record rather than a general GenBank entry.

```perl
use Bio::DB::RefSeq;

my $db = Bio::DB::RefSeq->new();

# Fetch a specific accession (e.g., a human mRNA)
my $seq = $db->get_Seq_by_acc('NM_000546'); 

print "Display ID: ", $seq->display_id, "\n";
print "Sequence: ", $seq->seq, "\n";
```

### Batch Retrieval
For multiple accessions, use the `get_Stream_by_acc` method to handle data efficiently without overloading memory.

```perl
my $stream = $db->get_Stream_by_acc(['NM_000546', 'NM_000633', 'NP_000537']);

while (my $s = $stream->next_seq) {
    print "Fetched: ", $s->accession_number, " Length: ", $s->length, "\n";
}
```

### Expert Tips
- **Database Selection**: By default, the module queries NCBI. Ensure your environment has internet access as this tool acts as a web client.
- **Object Compatibility**: The returned objects are standard `Bio::Seq` objects. You can immediately pipe them into other BioPerl modules like `Bio::SeqIO` for format conversion (e.g., to FASTA or GenBank).
- **Error Handling**: Always check if the sequence object is defined. If an accession is deprecated or private, the database may return undef.
- **Rate Limiting**: When performing large batch downloads, NCBI may throttle requests. Use the stream interface or implement small sleeps between requests if you encounter 429 errors.

## Reference documentation
- [Bio-DB-RefSeq Documentation](./references/metacpan_org_release_Bio-DB-RefSeq.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-db-refseq_overview.md)