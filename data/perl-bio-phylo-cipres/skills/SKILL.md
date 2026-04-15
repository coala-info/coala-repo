---
name: perl-bio-phylo-cipres
description: This tool provides programmatic access to the CIPRES REST API for running phylogenetic analyses on remote supercomputing resources. Use when user asks to submit phylogenetic jobs, monitor job status, or retrieve analysis results from the CIPRES gateway.
homepage: http://metacpan.org/pod/Bio::Phylo::CIPRES
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-phylo-cipres:v0.2.1--pl5321hdfd78af_2"
---

# perl-bio-phylo-cipres

## Overview
This skill enables programmatic access to the CIPRES (Cyberinfrastructure for Phylogenetic Research) REST API. It leverages the `Bio::Phylo::CIPRES` module to bridge local Perl scripts with remote supercomputing resources. Use this tool when you need to submit large-scale phylogenetic analyses (like RAxML, MrBayes, or BEAST) to the CIPRES gateway, monitor job status, and retrieve result files without using the web interface.

## Core Usage Patterns

### Client Initialization
To interact with the API, you must initialize a client object with your CIPRES developer credentials.
```perl
use Bio::Phylo::CIPRES::Client;

my $client = Bio::Phylo::CIPRES::Client->new(
    'user_name' => $USER,
    'password'  => $PASS,
    'app_id'    => $APP_ID,
    'app_key'   => $APP_KEY,
);
```

### Job Submission Workflow
1.  **List Tools**: Identify the available tool IDs (e.g., `RAXMLHPC_8`).
2.  **Define Parameters**: Create a hash of tool-specific parameters and input files.
3.  **Submit**: Use the `submit_job` method.

```perl
my $job = $client->submit_job(
    'tool' => 'RAXMLHPC_8',
    'input.infile_' => 'my_alignment.phy',
    'vparam.runtime_' => '0.5',
    # ... other tool-specific parameters
);
print "Job submitted with ID: " . $job->job_handle . "\n";
```

### Monitoring and Retrieval
Jobs are asynchronous. You must poll the status before attempting to download results.
```perl
# Check status
while ( $job->status ne 'COMPLETED' ) {
    sleep 30;
    $job->update_status;
}

# List and download output files
my @files = $job->list_output_files;
foreach my $file (@files) {
    $file->download($file->filename);
}
```

## Best Practices
- **Credential Management**: Never hardcode API keys. Use environment variables or a secure configuration file.
- **Polling Intervals**: Do not poll the CIPRES API more frequently than once every 30-60 seconds to avoid rate limiting.
- **Error Handling**: Wrap client calls in `eval` blocks or use modules like `Try::Tiny` to handle network timeouts or API errors gracefully.
- **Validation**: Always verify that your input files (e.g., NEXUS or PHYLIP) are valid before submission to prevent wasting CIPRES compute credits on failed jobs.

## Reference documentation
- [Bio::Phylo::CIPRES Documentation](./references/metacpan_org_pod_Bio__Phylo__CIPRES.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-phylo-cipres_overview.md)