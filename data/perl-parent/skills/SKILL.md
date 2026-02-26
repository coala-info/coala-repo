---
name: perl-parent
description: This tool manages Vipul's Razor v2 to identify and filter spam using a collaborative network of statistical signatures. Use when user asks to check if a message is spam, report new spam, revoke false positives, register a reporter identity, or discover Razor servers.
homepage: https://github.com/toddr/Razor2-Client-Agent
---


# perl-parent

## Overview
The perl-parent skill provides procedural knowledge for interacting with Vipul's Razor v2, a collaborative network for identifying and filtering spam. Unlike simple keyword filters, Razor uses statistical and randomized signatures (including Ephemeral Signatures) to identify mutating spam content. This skill guides the use of the Razor agent suite to perform message checks, submissions, and administrative tasks like reporter registration and configuration of the Truth Evaluation System (TeS).

## Core CLI Tools and Workflows

### Message Filtering and Checking
Use `razor-check` to determine if a message is known spam.
- **Standard Check**: Pipe an email message into `razor-check`. It returns a non-zero exit code if the message is identified as spam.
- **Confidence Levels**: Razor assigns a confidence value (0-100) to signatures. Configure your local agent to respect specific confidence thresholds based on your tolerance for false positives.

### Reporting and Revocation
Contributing to the network requires a registered identity to build reputation.
- **Reporting Spam**: Use `razor-report` to submit the entire body of a spam message. This allows the system to compute new signatures and seed the database.
- **Revoking False Positives**: Use `razor-revoke` if a legitimate message was incorrectly flagged. This input is fed into the TeS to adjust signature confidence or remove the signature entirely.

### Administrative Tasks
- **Registration**: Use `razor-admin -register` to create a reporter account. This is mandatory for reporting and revoking. Authentication uses CRAM-SHA1.
- **Discovery**: Use `razor-admin -discover` to find and update the list of available Razor Nomination and Catalogue servers.

## Expert Tips and Best Practices

### Leveraging Preprocessors
Razor v2 automatically handles various obfuscation techniques. Ensure the agent is configured to use its built-in preprocessors for:
- **De-HTML**: Converting HTML to plaintext to hash the content the user actually sees.
- **Decoding**: Handling Base64 and Quoted-Printable (QP) encoded messages before signature computation.

### Understanding Engines
Razor v2 supports multiple filtration engines simultaneously:
- **VR1**: Backward compatibility with Razor v1.
- **VR2**: SHA1 signatures of body text.
- **VR3**: Nilsimsa (locality-sensitive) signatures.
- **VR4**: Ephemeral hashes based on collaborative random numbers to defeat spammers targeting specific hash sections.

### MIME Handling
Razor v2 treats each MIME attachment as a separate content class. When processing complex emails, the agent can track and filter specific attachments (like viruses) individually.

## Reference documentation
- [Vipul's Razor v2 README](./references/github_com_toddr_Razor2-Client-Agent.md)