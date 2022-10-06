# secure-actions-webhook

Securely call CD servers / notification services after your Action finishes

## Usage

Sending a string:

```yaml
- name: Webhook
  uses: Greenlight-Simulation/secure-actions-webhook@0.1.3
  env:
    REQUEST_URI: ${{ secrets.REQUEST_URI }}
    REQUEST_DATA: "something_interesting"
    HMAC_SECRET: ${{ secrets.HMAC_SECRET }}
```

Sending a json string:

```yaml
- name: Webhook
  uses: Greenlight-Simulation/secure-actions-webhook@0.1.3
  env:
    REQUEST_URI: ${{ secrets.REQUEST_URI }}
    REQUEST_DATA: '{ "something": "interesting" }'
    HMAC_SECRET: "secret_used_to_generate_signature"
```

The request will include the header `X-Request-Signature`, which is the HMAC signature of the raw body (SHA256, Base64).
Verify it on your endpoint for integrity.
