//
//  PKConstants.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-17.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGConstants.h"

NSString *const PGErrorDomain = @"PKErrorDomain";

NSString *const PGPokemonApiUrl = @"https://pgorelease.nianticlabs.com/plfe/rpc";
NSString *const PGPokemonApiLoginUrl = @"https://sso.pokemon.com/sso/login?service=https://sso.pokemon.com/sso/oauth2.0/callbackAuthorize";
NSString *const PGPokemonApiLoginOauth = @"https://sso.pokemon.com/sso/oauth2.0/accessToken";

NSString *const PGPokemonApiRequestUserAgent = @"Niantic App";

NSString *const PGPokemonApiAppId = @"com.nianticlabs.pokemongo";
NSString *const PGPokemonApiAndroidId = @"9774d56d682e549c";
NSString *const PGPokemonApiClientSecret = @"w8ScCUXJQc6kXKw8FiOhd8Fixzht18Dq3PEVkUCP5ZPxtgyWsbTvWHFLm2wNY0JR";
NSString *const PGPokemonApiService = @"ptc";
NSString *const PGPokemonApiClientSig = @"321187995bc7cdc2b5fc91b11a96e2baa8602c62";

const uint32_t PGPokemonApiAppVersion = 3300;
const uint32_t PGHashSeed = 0x1B845238;

const uint64_t PGRequestIdBase = 100000000;
const uint64_t PGRequestIdRange = 899999999;
