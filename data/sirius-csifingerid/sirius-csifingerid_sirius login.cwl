cwlVersion: v1.2
class: CommandLineTool
baseCommand: sirius login
label: sirius-csifingerid_sirius login
doc: "Allows a user to login for SIRIUS Webservices (e.g. CSI:FingerID or CANOPUS)
  and securely store a personal access token.\n\nTool homepage: https://bio.informatik.uni-jena.de/software/sirius/"
inputs:
  - id: clear
    type:
      - 'null'
      - boolean
    doc: Logout. Deletes stored refresh and access token (re-login required to 
      use webservices again).
    inputBinding:
      position: 101
      prefix: --clear
  - id: email
    type:
      - 'null'
      - string
    doc: Login username/email
    inputBinding:
      position: 101
      prefix: --email
  - id: license_info
    type:
      - 'null'
      - boolean
    doc: Show license information and compound limits.
    inputBinding:
      position: 101
      prefix: --license-info
  - id: limits
    type:
      - 'null'
      - boolean
    doc: Show license information and compound limits.
    inputBinding:
      position: 101
      prefix: --limits
  - id: logout
    type:
      - 'null'
      - boolean
    doc: Logout. Deletes stored refresh and access token (re-login required to 
      use webservices again).
    inputBinding:
      position: 101
      prefix: --logout
  - id: password
    type:
      - 'null'
      - boolean
    doc: Console password input.
    inputBinding:
      position: 101
      prefix: --pwd
  - id: password_env
    type:
      - 'null'
      - string
    doc: Environment variable with login password.
    inputBinding:
      position: 101
      prefix: --password-env
  - id: pwd
    type:
      - 'null'
      - boolean
    doc: Console password input.
    inputBinding:
      position: 101
      prefix: --pwd
  - id: request_token_only
    type:
      - 'null'
      - boolean
    doc: Requests and prints a new SECRET refresh token but does not store the 
      token as login. This can be used to request a token to be used in third 
      party applications that wish to call SIRIUS Web Services using your 
      account. Do never store your username and password in third party apps. Do
      not store the output of this command in any log. We recommend redirecting 
      the output into a file.
    inputBinding:
      position: 101
      prefix: --request-token-only
  - id: select_license
    type:
      - 'null'
      - string
    doc: Specify active subscription (sid) if multiple licenses are available at
      your account. Available subscriptions can be listed with '--show'
    inputBinding:
      position: 101
      prefix: --select-license
  - id: select_subscription
    type:
      - 'null'
      - string
    doc: Specify active subscription (sid) if multiple licenses are available at
      your account. Available subscriptions can be listed with '--show'
    inputBinding:
      position: 101
      prefix: --select-subscription
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show profile information about the profile you are logged in with.
    inputBinding:
      position: 101
      prefix: --show
  - id: token
    type:
      - 'null'
      - string
    doc: Refresh token to use as login.
    inputBinding:
      position: 101
      prefix: --token
  - id: user_env
    type:
      - 'null'
      - string
    doc: Environment variable with login username.
    inputBinding:
      position: 101
      prefix: --user-env
  - id: username
    type:
      - 'null'
      - string
    doc: Login username/email
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
stdout: sirius-csifingerid_sirius login.out
