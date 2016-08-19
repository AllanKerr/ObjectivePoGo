//
//  PKConstants.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PGErrorCode) {
    PGErrorCodeInvalidJSON = 0,
    PGErrorCodePrepareLoginFailed,
    PGErrorCodeGetTicketFailed,
    PGErrorCodeGetAccessTokenFailed,
    PGErrorCodeExpiredAuthTicket,
    PGErrorCodeRequestFailed,
    PGErrorCodeAcceptTermsOfServiceFailed,
    PGErrorCodeDidNotFindPokemon,
    PGErrorCodeSigningIn,
    PGErrorCodeNoInactiveAccounts,
    PGErrorCodeInvalidStatusCode
};

FOUNDATION_EXPORT NSString *const PGErrorDomain;

FOUNDATION_EXPORT NSString *const PGPokemonApiUrl;
FOUNDATION_EXPORT NSString *const PGPokemonApiLoginUrl;
FOUNDATION_EXPORT NSString *const PGPokemonApiLoginOauth;

FOUNDATION_EXPORT NSString *const PGPokemonApiRequestUserAgent;

FOUNDATION_EXPORT NSString *const PGPokemonApiAppId;
FOUNDATION_EXPORT NSString *const PGPokemonApiAndroidId;
FOUNDATION_EXPORT NSString *const PGPokemonApiClientSecret;
FOUNDATION_EXPORT NSString *const PGPokemonApiService;
FOUNDATION_EXPORT NSString *const PGPokemonApiClientSig;

FOUNDATION_EXPORT const uint32_t PGPokemonApiAppVersion;
FOUNDATION_EXPORT const uint32_t PGHashSeed;

FOUNDATION_EXPORT const uint64_t PGRequestIdBase;
FOUNDATION_EXPORT const uint64_t PGRequestIdRange;
