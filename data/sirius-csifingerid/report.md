# sirius-csifingerid CWL Generation Report

## sirius-csifingerid_sirius login

### Tool Description
Allows a user to login for SIRIUS Webservices (e.g. CSI:FingerID or CANOPUS) and securely store a personal access token.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Total Downloads**: 49.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/boecker-lab/sirius
- **Stars**: N/A
### Original Help Text
```text
Usage: sirius login [-hV] [--clear] [--limits] [--request-token-only] [--show]
                    [--select-license=<sid>] [[-u=<username> -p] |
                    [--token=<token>] | [--user-env=<username>
                    --password-env=<password>]]
<STANDALONE> Allows a user to login for SIRIUS Webservices (e.g. CSI:FingerID
or CANOPUS) and securely store a personal access token.
      --clear, --logout      Logout. Deletes stored refresh and access token
                               (re-login required to use webservices again).
  -h, --help                 Show this help message and exit.
      --limits, --license-info
                             Show license information and compound limits.
  -p, --pwd, --password      Console password input.
      --password-env=<password>
                             Environment variable with login password.
      --request-token-only   Requests and prints a new SECRET refresh token but
                               does not store the token as login.
                             This can be used to request a token to be used in
                               third party applications that wish to call
                               SIRIUS Web Services using your account.
                             Do never store your username and password in third
                               party apps.
                             Do not store the output of this command in any
                               log. We recommend redirecting the output into a
                               file.
      --select-license, --select-subscription=<sid>
                             Specify active subscription (sid) if multiple
                               licenses are available at your account.
                               Available subscriptions can be listed with
                               '--show'
      --show                 Show profile information about the profile you are
                               logged in with.
      --token=<token>        Refresh token to use as login.
  -u, --user, --email=<username>
                             Login username/email
      --user-env=<username>  Environment variable with login username.
  -V, --version              Print version information and exit.
```

