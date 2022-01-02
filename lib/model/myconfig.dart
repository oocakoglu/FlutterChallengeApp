import 'package:aad_oauth/model/config.dart';

class MyConfig extends Config {
  MyConfig(
      {required tenant,
      required clientId,
      required redirectUri,
      required scope,
      tokenIdentifier,
      clientSecret,
      policy,
      responseMode,
      state,
      prompt,
      codeChallenge,
      codeChallengeMethod,
      resource,
      loginHint,
      codeVerifier,
      userAgent})
      : super(
            tenant: tenant,
            clientId: clientId,
            redirectUri: redirectUri,
            scope: scope,
            tokenIdentifier: tokenIdentifier,
            clientSecret: clientSecret,
            policy: policy,
            responseMode: responseMode,
            state: state,
            prompt: prompt,
            codeChallenge: codeChallenge,
            codeChallengeMethod: codeChallengeMethod,
            resource: resource,
            loginHint: loginHint,
            codeVerifier: codeVerifier,
            userAgent: userAgent);

  factory MyConfig.fromJson(Map<String, dynamic> json) {
    return MyConfig(
        tenant: json['tenant'] as String,
        clientId: json['clientId'] as String,
        redirectUri: json['redirectUri'] as String,
        scope: json['scope'] as String,
        tokenIdentifier: json['tokenIdentifier'] as String?,
        clientSecret: json['clientSecret'] as String?,
        policy: json['policy'] as String?,
        responseMode: json['responseMode'] as String?,
        state: json['state'] as String?,
        prompt: json['prompt'] as String?,
        codeChallenge: json['codeChallenge'] as String?,
        codeChallengeMethod: json['codeChallengeMethod'] as String?,
        resource: json['resource'] as String?,
        loginHint: json['loginHint'] as String?,
        codeVerifier: json['codeVerifier'] as String?,
        userAgent: json['userAgent'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'tenant': tenant,
        'clientId': clientId,
        'redirectUri': redirectUri,
        'scope': scope,
        'tokenIdentifier': tokenIdentifier,
        'clientSecret': clientSecret,
        'policy': policy,
        'responseMode': responseMode,
        'state': state,
        'prompt': prompt,
        'codeChallenge': codeChallenge,
        'codeChallengeMethod': codeChallengeMethod,
        'resource': resource,
        'loginHint': loginHint,
        'codeVerifier': codeVerifier,
        'userAgent': userAgent,
      };
}
