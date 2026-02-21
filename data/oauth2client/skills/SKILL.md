---
name: oauth2client
description: The oauth2client skill provides procedural knowledge for implementing the NXOAuth2Client library in Cocoa and Cocoa Touch environments.
homepage: https://github.com/nxtbgthng/OAuth2Client
---

# oauth2client

## Overview

The oauth2client skill provides procedural knowledge for implementing the NXOAuth2Client library in Cocoa and Cocoa Touch environments. This library, based on OAuth2 Draft 10, manages the complexities of the native application profile, including token acquisition, storage in the Keychain, and refreshing expired tokens. Use this skill to correctly configure service endpoints, handle redirect URLs, and customize request headers for compatibility with various OAuth2 providers.

## Implementation Patterns

### Client Configuration
The recommended practice is to configure the shared account store within the `+initialize` method of your App Delegate to ensure settings are available before any network requests occur.

```objective-c
+ (void)initialize {
    [[NXOAuth2AccountStore sharedStore] setClientID:@"YOUR_CLIENT_ID"
                                             secret:@"YOUR_CLIENT_SECRET"
                                   authorizationURL:[NSURL URLWithString:@"https://service.com/auth"]
                                           tokenURL:[NSURL URLWithString:@"https://service.com/token"]
                                        redirectURL:[NSURL URLWithString:@"app-scheme://oauth"]
                                     forAccountType:@"MyService"];
}
```

### Authorization Flows

1. **Username and Password (Resource Owner Credentials)**:
   Use this for trusted applications where you collect credentials directly.
   ```objective-c
   [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"MyService" 
                                                             username:username 
                                                             password:password];
   ```

2. **External Browser**:
   Triggers the system browser. Requires your app to handle the custom URL scheme in `application:openURL:sourceApplication:annotation:`.
   ```objective-c
   [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"MyService"];
   // In AppDelegate:
   [[NXOAuth2AccountStore sharedStore] handleRedirectURL:url];
   ```

3. **Embedded UIWebView**:
   Use a prepared authorization URL handler to intercept the code exchange within your app's UI.
   ```objective-c
   [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"MyService"
                                   withPreparedAuthorizationURLHandler:^(NSURL *preparedURL){
       [_webView loadRequest:[NSURLRequest requestWithURL:preparedURL]];
   }];
   ```

### Customizing Token Requests
By default, the library uses `multipart/form-data`. If the provider requires `application/x-www-form-urlencoded`, modify the account store configuration:

```objective-c
NSMutableDictionary *config = [NSMutableDictionary dictionaryWithDictionary:[[NXOAuth2AccountStore sharedStore] configurationForAccountType:@"MyService"]];
NSDictionary *headers = @{@"Content-Type": @"application/x-www-form-urlencoded"};
[config setObject:headers forKey:kNXOAuth2AccountStoreConfigurationCustomHeaderFields];
[[NXOAuth2AccountStore sharedStore] setConfiguration:config forAccountType:@"MyService"];
```

## Expert Tips

- **Keychain Integration**: The library automatically persists tokens in the system Keychain. You do not need to manually store access tokens.
- **Account Types**: Use unique strings for `forAccountType:` to manage multiple services (e.g., "GitHub", "Instagram") within the same application.
- **Dependency Requirements**: Ensure `Security.framework` is added to your project's Link Binary With Libraries phase, as it is required for secure token storage.
- **Redirect Parsing**: When using `UIWebView`, always check the `webViewDidFinishLoad:` delegate to detect if the current URL matches your `redirectURL` before passing it to `handleRedirectURL:`.

## Reference documentation
- [OAuth2Client README](./references/github_com_nxtbgthng_OAuth2Client.md)
- [OAuth2Client Wiki](./references/github_com_nxtbgthng_OAuth2Client_wiki.md)