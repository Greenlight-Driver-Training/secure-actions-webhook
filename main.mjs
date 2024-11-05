const hmacSecret = process.env.HMAC_SECRET

if (!hmacSecret || hmacSecret === "" || hmacSecret.trim() === "") {
    console.warn("HMAC_SECRET secret seems empty. This doesn't seem like what you want.")
}

if (hmacSecret.length < 32) {
    console.warn("HMAC_SECRET seems weak. You should use at least 32 secure random hex chars.")
}

const createHmacSignature = async (jsonBody) => {
    const key =
        await crypto.subtle.importKey("raw",
                                      new TextEncoder().encode(hmacSecret),
                                      { name: "HMAC", hash: "SHA-256" },
                                      false,
                                      ["sign"])

    const signature = await crypto.subtle.sign("HMAC", key, new TextEncoder().encode(jsonBody))

    return Buffer.from(new Uint8Array(signature)).toString('base64')
}

const jsonBody = process.env.REQUEST_DATA

try {
    JSON.parse(jsonBody)
} catch (e) {
    console.error("REQUEST_DATA is not a valid JSON string.")
    process.exit(1)
}

const signature = await createHmacSignature(jsonBody)

const response =
    await fetch(process.env.REQUEST_URI, {
        method: `${process.env.METHOD ? process.env.METHOD : 'POST'}`,
        body: jsonBody,
        headers: { 'X-Request-Signature': signature }
    })

if (response.status < 200 || response.status > 299) {
    console.error(`Request failed with status code ${response.status}!`)
    process.exit(1)
} else process.exit()
