package com.quickresponse.security.token

interface TokenService {
    fun generate(
        config: TokenConfig,
        vararg claims : TokenClaim
    ) : String
}