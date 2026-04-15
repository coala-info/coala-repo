---
name: perl-bio-tools-run-remoteblast
description: This tool executes BLAST searches against remote NCBI servers using the BioPerl RemoteBlast module. Use when user asks to run remote sequence alignments, submit sequences to NCBI BLAST servers, or programmatically retrieve BLAST results without local infrastructure.
homepage: https://metacpan.org/release/Bio-Tools-Run-RemoteBlast
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-tools-run-remoteblast:1.7.3--pl5321hdfd78af_0"
---

# perl-bio-tools-run-remoteblast

## Overview
This skill facilitates the programmatic execution of BLAST searches against remote NCBI servers. It utilizes the `Bio::Tools::Run::RemoteBlast` module from the BioPerl project. This tool is ideal for low-to-medium throughput sequence analysis where maintaining a local BLAST infrastructure is impractical. It handles the submission of sequences, polling for job completion, and retrieval of results in various formats (typically BLAST XML or report text).

## Usage Patterns

### Basic Script Structure
To use this tool, you must initialize a factory object, set the search parameters, and implement a loop to wait for the NCBI queue to process the request.

```perl
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

# 1. Initialize the factory
my $factory = Bio::Tools::Run::RemoteBlast->new(
    -prog   => 'blastn',
    -data   => 'nr',
    -expect => '1e-10',
    -readmethod => 'SearchIO' # Returns Bio::SearchIO objects
);

# 2. Submit a sequence (Bio::Seq object or file)
my $response = $factory->submit_blast("sequence.fasta");

# 3. Poll for results
while (my @rids = $factory->each_rid) {
    foreach my $rid (@rids) {
        my $rc = $factory->retrieve_blast($rid);
        if (!ref($rc)) {
            if ($rc eq 'DONE') {
                $factory->remove_rid($rid);
            }
            sleep 5; # Wait before polling again
            next;
        }
        
        # 4. Process results
        my $result = $rc->next_result;
        while (my $hit = $result->next_hit) {
            print "Hit: ", $hit->name, "\n";
        }
        $factory->remove_rid($rid);
    }
}
```

### Best Practices
- **Email Requirement**: While not always strictly enforced by the module, it is best practice to identify yourself to NCBI by setting the environment variable or passing parameters if the specific version supports it, to avoid IP blocking.
- **Polling Intervals**: Do not poll NCBI more frequently than every 5 seconds. The `retrieve_blast` method returns the string 'WAIT' if the job is still in the queue.
- **Database Selection**: Ensure the `-data` parameter matches a valid NCBI remote database (e.g., `nr`, `swissprot`, `refseq_rna`).
- **Large Batches**: For many sequences, submit them in small batches rather than one at a time to minimize connection overhead, but be mindful of NCBI's usage policies regarding concurrent connections.

## Troubleshooting
- **Empty Results**: If a job returns 'DONE' but no hits are found, verify your `-expect` (E-value) threshold and ensure the sequence format is valid FASTA.
- **Connection Timeouts**: Remote BLAST is subject to network stability and NCBI server load. Implement error handling for cases where `$factory->submit_blast` fails to return a Request ID (RID).
- **Module Dependencies**: Ensure `BioPerl` is fully installed, as `RemoteBlast` relies on `Bio::Seq` and `Bio::SearchIO` for input and output processing.

## Reference documentation
- [Bio-Tools-Run-RemoteBlast Documentation](./references/metacpan_org_release_Bio-Tools-Run-RemoteBlast.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-tools-run-remoteblast_overview.md)