% @hidden
-module(jwerl_hs).

-export([sign/3, verify/4]).

%% OTP 21+
-ifdef(OTP_RELEASE).
-if(?OTP_RELEASE >= 23).

sign(ShaBits, Key, Data) ->
  crypto:mac(hmac, algo(ShaBits), Key, Data).

-else. % < 23, >= 21
sign(ShaBits, Key, Data) ->
  crypto:hmac(algo(ShaBits), Key, Data).

-endif.
-else. % < OTP 21
sign(ShaBits, Key, Data) ->
  crypto:hmac(algo(ShaBits), Key, Data).

-endif.

verify(ShaBits, Key, Data, Signature) ->
  Signature == sign(ShaBits, Key, Data).

algo(256) -> sha256;
algo(384) -> sha384;
algo(512) -> sha512.
