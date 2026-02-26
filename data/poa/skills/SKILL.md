---
name: poa
description: Poastal is an automated email reconnaissance framework that identifies the digital footprint and account registrations associated with a specific email address. Use when user asks to verify an email address, identify the owner of an unknown email, or check for registered accounts across various social media and service platforms.
homepage: https://github.com/jakecreps/poastal
---


# poa

## Overview
Poastal (poa) is an automated email reconnaissance framework designed to pivot from a single email address to a broader digital footprint. It streamlines the investigation process by checking the validity of an email and correlating it with registered accounts on various social media and service platforms. Use this skill to verify targets during the information-gathering phase of an investigation or to identify the potential owner of an unknown email address.

## Usage and Best Practices

### Initial Setup
Before running investigations, ensure the environment is prepared:
*   **Dependencies**: Install required Python packages using `pip install -r requirements.txt`.
*   **API Configuration**: The GitHub module requires a manual API key. Edit `backend/github.py` to insert your personal GitHub API key to enable profile lookups.

### Running the Tool
Poastal operates primarily as a Flask-based web application with a backend processing engine.

*   **Start the Backend**: Navigate to the `backend` directory and execute the main script:
    ```bash
    python poastal.py
    ```
    The server typically initializes on `port:8080`.
*   **Access the Interface**: Open `index.html` from the root directory in a browser to interact with the UI.
*   **CLI Execution**: For direct script interaction, you can invoke the specific platform modules within the `backend/` folder or use `cli.py` if available in your local environment for headless operations.

### Investigation Workflow
1.  **Validation**: Always check the "Deliverable" and "Disposable" status first. If an email is disposable (e.g., Mailinator), platform registration results are less likely to be tied to a permanent identity.
2.  **Platform Correlation**: Use the tool to check for presence on:
    *   **Social**: Facebook, Twitter, Snapchat, MeWe.
    *   **Professional/Dev**: GitHub, Adobe, WordPress.
    *   **Alternative/Niche**: Rumble, Imgur, Duolingo.
3.  **Verification**: Use `example@gmail.com` as a baseline test to ensure the backend and platform scrapers are functioning correctly before running a real investigation.

### Expert Tips
*   **GitHub Module**: Since the GitHub module is a recent addition and requires an API key, it is often the most reliable source for finding a real name if the "Name" field in the general search returns empty.
*   **Spam Detection**: If an email is flagged as "Considered Spam," it may be associated with known botnets or marketing lists, which can provide context on the email's history.
*   **Error Handling**: If you encounter "Unable to fetch data" errors, verify that your local Flask server is still running and that your network is not being rate-limited by the target platforms.

## Reference documentation
- [Poastal - the Email OSINT tool](./references/github_com_jakecreps_poastal.md)
- [Poastal Backend Directory](./references/github_com_jakecreps_poastal_tree_main_backend.md)