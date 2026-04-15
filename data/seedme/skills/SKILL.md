---
name: seedme
description: Seedme manages a Capture The Flag challenge environment focused on demonstrating predictable random number generation vulnerabilities in PHP. Use when user asks to deploy the challenge, reset user accounts, modify administrative credentials, or analyze cryptographic flaws in the seeding logic.
homepage: https://github.com/HackUCF/seedme
metadata:
  docker_image: "quay.io/biocontainers/seedme:1.2.4--py27_1"
---

# seedme

## Overview
Seedme is a specialized Capture The Flag (CTF) challenge designed to demonstrate cryptographic vulnerabilities, specifically those involving predictable random number generation in PHP. This skill assists administrators in deploying and maintaining the challenge environment and provides security researchers with the necessary context to analyze the underlying flaws.

## Management and Configuration

### Account Reset
To clear existing user accounts and reset the challenge state to its initial configuration, execute the following command in the application's root directory:

`echo "1" > count.s`

### Administrative Credentials
The administrator password is defined statically within the application logic. To modify the admin password, you must manually edit the configuration file:

1. Open `seed.php`.
2. Locate the admin password variable.
3. Update the value and save the file.

## File Structure and Purpose
Understanding the file layout is critical for both hosting and solving the challenge:

- **a.php**: The administrative login interface.
- **r.php**: The user registration page where new accounts are created.
- **h.php**: The hint page, providing clues about the cryptographic weakness.
- **i.php**: The main homepage content.
- **seed.php**: The core configuration file containing seeding logic and the admin password.
- **count.s**: A flat-file database/counter used to track account registrations.

## Expert Tips: Cryptographic Analysis

### Seed Prediction
The core vulnerability in "seedme" typically involves the misuse of PHP's Mersenne Twister random number generator. 
- Focus on how `mt_srand()` is called. If the seed is based on a predictable value (such as a timestamp or the incrementing value in `count.s`), the output of `mt_rand()` becomes deterministic.
- Analyze `seed.php` to determine if the seed is leaked or can be brute-forced based on known outputs from the registration process.

### Environment Consistency
Because PHP's random number generation behavior (specifically `mt_rand`) changed in version 7.1.0, ensure that the hosting environment's PHP version matches the version the challenge was authored for to maintain the intended difficulty and solvability.

## Reference documentation
- [HackUCF/seedme Repository](./references/github_com_HackUCF_seedme.md)